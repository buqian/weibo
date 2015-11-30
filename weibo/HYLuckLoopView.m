//
//  HYLuckLoopView.m
//  weibo
//
//  Created by bala on 30/11/15.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYLuckLoopView.h"
#import "HYLuckLoopButton.h"

#define ButtonWidth 78

@interface HYLuckLoopView ()

@property (nonatomic, weak) UIButton *selectedBtn;

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, strong) CADisplayLink *chooseDisplayLink;

@property (nonatomic, assign) CGFloat angle;

@property (nonatomic, assign) int index;

@property (nonatomic, assign) CGFloat stap;

@end

@implementation HYLuckLoopView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        for (int i = 0; i < 12; i ++) {
            HYLuckLoopButton *btn = [HYLuckLoopButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor clearColor];
            btn.bounds = CGRectMake(0, 0, ButtonWidth, self.frame.size.height * 0.5);
            btn.layer.anchorPoint = CGPointMake(0.5, 1);
            btn.layer.position = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
            btn.transform = CGAffineTransformMakeRotation(M_PI / 180 * (i * 30));
            
            UIImage *image = [UIImage imageNamed:@"LuckyAstrology"];
            UIImage *selectedImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
            
            CGFloat scale = [UIScreen mainScreen].scale;
            CGFloat imageWidth = image.size.width * scale / 12;
            CGRect imageRect = CGRectMake(i * imageWidth, 0, imageWidth, image.size.height * scale);
            CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], imageRect);
            [btn setImage:[UIImage imageWithCGImage:imageRef] forState:UIControlStateNormal];
            CGImageRef selectImageRef = CGImageCreateWithImageInRect([selectedImage CGImage], imageRect);
            [btn setImage:[UIImage imageWithCGImage:selectImageRef] forState:UIControlStateSelected];
            
            CGImageRelease(imageRef);
            CGImageRelease(selectImageRef);
            
            [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            if(i == 11)
            {
                [self btnClick:btn];
            }
        }
        
//        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(loop)];
//        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return self;
}

- (void)loop
{
    self.transform = CGAffineTransformRotate(self.transform, M_PI / 180 * 0.1);
}

-(void)awakeFromNib
{
}

- (void)btnClick:(UIButton *)sender
{
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
    [sender convertPoint:sender.center toView:self.superview];
}

- (void)startChoose
{
    self.displayLink.paused = YES;
    self.chooseDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(chooseLoop)];
    [self.chooseDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.userInteractionEnabled = NO;
    self.stap = 30;
}

- (void)chooseLoop
{
    NSLog(@"%@", NSStringFromCGPoint([self convertPoint:self.center toView:self.superview]));
    self.transform = CGAffineTransformRotate(self.transform, M_PI / 180 * self.stap);
    self.index ++;
    if(self.index >= 100)
    {
        self.chooseDisplayLink.frameInterval -= 30;

        self.stap -= 2;
        if(self.stap <= 0)
        {
            [self.chooseDisplayLink invalidate];
            self.chooseDisplayLink = nil;
            self.index = 0;
            self.displayLink.paused = NO;
            self.userInteractionEnabled = YES;
        }
    }
}


@end
