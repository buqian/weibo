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

@property (nonatomic, assign) BOOL isJian;

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
            btn.tag = i;
            
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
            
            if(i == 0)
            {
                [self btnClick:btn];
            }
        }
        
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(loop)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return self;
}

- (void)loop
{
    self.angle += 0.1;
    self.transform = CGAffineTransformMakeRotation(M_PI / 180 * self.angle);
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
//    self.chooseDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(chooseLoop)];
//    [self.chooseDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
//    self.userInteractionEnabled = NO;
    self.stap = 30;
    self.isJian = NO;
    [self addAnimation];
}

- (void)addAnimation
{
    CABasicAnimation *anima=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    //1.1设置动画执行时间
    anima.duration=2.0;
    //1.2修改属性，执行动画
    self.angle = M_PI * 6 + M_PI / 180 * self.angle;
    anima.toValue=[NSNumber numberWithFloat:self.angle];
    //1.3设置动画执行完毕后不删除动画
    anima.removedOnCompletion=NO;
    //1.4设置保存动画的最新状态
    anima.fillMode=kCAFillModeForwards;
    //2.添加动画到layer
    [self.layer addAnimation:anima forKey:nil];
}

- (void)chooseLoop
{
    self.angle += self.stap;
    self.transform = CGAffineTransformMakeRotation(M_PI / 180 * self.angle);
    self.index ++;
    if(self.index >= 60)
    {
        CGFloat loop = (self.angle + self.selectedBtn.tag * 30) - ((int)(self.angle + self.selectedBtn.tag * 30) / 360 * 360);
        if(!self.isJian)
        {
            if(loop < 270)
            {
                self.isJian = YES;
            }
            return;
        }
        else if(loop >= 270 && loop< 300)
        {
            self.stap = 10;
        }
        else if(loop >= 300 && loop < 330)
        {
            self.stap = 5;
        }
        else if(loop >= 330 && loop <= 358)
        {
            self.stap = 1;
        }
        else if(loop > 358)
        {
            [self.chooseDisplayLink invalidate];
            self.chooseDisplayLink = nil;
            self.index = 0;
            self.userInteractionEnabled = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.displayLink.paused = NO;
            });
        }
    }
}


@end
