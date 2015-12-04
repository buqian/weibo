//
//  HYUnlockController.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/4.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYUnlockController.h"
#import "HYUnlockButton.h"
#import "HYUnlockView.h"

#define SelectedColor [UIColor redColor]
#define ErrorColor [UIColor colorWithRed:1.000 green:0.186 blue:0.881 alpha:1.000]
#define NormalColor [UIColor darkGrayColor]

@interface HYUnlockController () <HYUnlockViewDataSource>
@property (strong, nonatomic) IBOutlet HYUnlockView *unlockView;
- (IBAction)goBack:(id)sender;

@property (nonatomic, strong) NSArray *btnArray;

@property (nonatomic, strong) UIBezierPath *path;

@property (nonatomic, assign) BOOL isStart;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation HYUnlockController

@synthesize btnArray;
@synthesize path;
@synthesize isStart;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.unlockView.dataSource = self;
    
    self.unlockView.layer.zPosition = -100;
    
    NSMutableArray *marray = [NSMutableArray array];
    for (UIView *view in self.view.subviews) {
        if([view isKindOfClass:[HYUnlockButton class]])
        {
            view.userInteractionEnabled = NO;
            [marray addObject:view];
        }
    }
    btnArray = marray;
}

-(UIBezierPath *)drawRectUseBezierPath:(HYUnlockView *)unlockView
{
    return path;
}

-(UIColor *)drawRectUseColor:(HYUnlockView *)unlockView
{
    if(isStart)
    {
        return SelectedColor;
    }
    return ErrorColor;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    isStart = YES;
    HYUnlockButton *button = [self findButton:[touches.anyObject locationInView:self.view]];
    if(!button)
    {
        return;
    }
    button.selected = YES;
    button.tintColor = SelectedColor;
    [button setNeedsDisplay];
    
    path = [UIBezierPath bezierPath];
    path.lineWidth = button.bounds.size.width * 0.15;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    [path moveToPoint:button.centerPoint];
    
    [_unlockView setNeedsDisplay];
    _label.text = [NSString stringWithFormat:@"%@ %ld", _label.text, button.tag];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    HYUnlockButton *button = [self findButton:[touches.anyObject locationInView:self.view]];
    if(!button || button.selected)
    {
        return;
    }
    button.selected = YES;
    button.tintColor = SelectedColor;
    [button setNeedsDisplay];
    
    [path addLineToPoint:button.centerPoint];
    
    [_unlockView setNeedsDisplay];
    _label.text = [NSString stringWithFormat:@"%@ %ld", _label.text, button.tag];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    isStart = NO;
    self.view.userInteractionEnabled = NO;
    for (UIView *view in btnArray) {
        HYUnlockButton *button = (HYUnlockButton *)view;
        if(button.selected)
        {
            button.tintColor = ErrorColor;
            [button setNeedsDisplay];
        }
    }
    [_unlockView setNeedsDisplay];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        for (UIView *view in btnArray) {
            HYUnlockButton *button = (HYUnlockButton *)view;
            if(button.selected)
            {
                button.selected = NO;
                button.tintColor = NormalColor;
                [button setNeedsDisplay];            }
        }
        path = nil;
        [_unlockView setNeedsDisplay];
        self.view.userInteractionEnabled = YES;
        _label.text = @" ";
    });
}

-(HYUnlockButton *)findButton:(CGPoint)point
{
    for (UIView *view in btnArray) {
        HYUnlockButton *button = (HYUnlockButton *)view;
        CGRect rect = [view convertRect:view.bounds toView:self.view];
        rect = CGRectInset(rect, rect.size.width * 0.25, rect.size.width * 0.25);
        if(CGRectContainsPoint(rect, point))
        {
            button.centerPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
            NSLog(@"%@", NSStringFromCGRect(rect));
            NSLog(@"%@", NSStringFromCGPoint(button.centerPoint));
            return button;
        }
    }
    return nil;
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
