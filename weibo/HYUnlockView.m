//
//  HYUnlockView.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/4.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYUnlockView.h"
#import "HYUnlockButton.h"

#define SelectedColor [UIColor redColor]
#define ErrorColor [UIColor colorWithRed:1.000 green:0.186 blue:0.881 alpha:1.000]
#define NormalColor [UIColor darkGrayColor]

@interface HYUnlockView ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic, strong) NSArray *btnArray;

@property (nonatomic, strong) UIBezierPath *path;

@property (nonatomic, assign) BOOL isStart;
- (IBAction)goback:(id)sender;
@end

@implementation HYUnlockView

@synthesize btnArray;
@synthesize path;
@synthesize isStart;
@synthesize delegate;

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData
{
    
    NSMutableArray *marray = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if([view isKindOfClass:[HYUnlockButton class]])
        {
            view.userInteractionEnabled = NO;
            [marray addObject:view];
        }
    }
    btnArray = marray;
}

-(void)drawRect:(CGRect)rect
{
    if(path)
    {
        if(isStart)
        {
            [SelectedColor set];
        }
        else
        {
            [ErrorColor set];
        }
        
        [path stroke];
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    isStart = YES;
    HYUnlockButton *button = [self findButton:[touches.anyObject locationInView:self]];
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
    
    [self setNeedsDisplay];
    _label.text = [NSString stringWithFormat:@"%@%ld", _label.text, button.tag];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    HYUnlockButton *button = [self findButton:[touches.anyObject locationInView:self]];
    if(!button || button.selected)
    {
        return;
    }
    button.selected = YES;
    button.tintColor = SelectedColor;
    [button setNeedsDisplay];
    
    [path addLineToPoint:button.centerPoint];
    
    [self setNeedsDisplay];
    _label.text = [NSString stringWithFormat:@"%@%ld", _label.text, button.tag];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    isStart = NO;
    self.userInteractionEnabled = NO;
    if(delegate && [delegate respondsToSelector:@selector(unlockViewSuccess:result:)])
    {
        [delegate unlockViewSuccess:self result:_label.text];
    }

    for (UIView *view in btnArray) {
        HYUnlockButton *button = (HYUnlockButton *)view;
        if(button.selected)
        {
            button.tintColor = ErrorColor;
            [button setNeedsDisplay];
        }
    }
    [self setNeedsDisplay];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        for (UIView *view in btnArray) {
            HYUnlockButton *button = (HYUnlockButton *)view;
            if(button.selected)
            {
                button.selected = NO;
                button.tintColor = NormalColor;
                [button setNeedsDisplay];
            }
        }
        path = nil;
        [self setNeedsDisplay];
        self.userInteractionEnabled = YES;
        _label.text = @" ";
    });
}

-(HYUnlockButton *)findButton:(CGPoint)point
{
    for (UIView *view in btnArray) {
        HYUnlockButton *button = (HYUnlockButton *)view;
        CGRect rect = [view convertRect:view.bounds toView:self];
        rect = CGRectInset(rect, rect.size.width * 0.25, rect.size.width * 0.25);
        if(CGRectContainsPoint(rect, point))
        {
            button.centerPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
            return button;
        }
    }
    return nil;
}

- (IBAction)goback:(id)sender {
    if(delegate && [delegate respondsToSelector:@selector(unlockViewCancel:)])
    {
        [delegate unlockViewCancel:self];
    }
}
@end
