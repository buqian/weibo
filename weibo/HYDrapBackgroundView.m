//
//  HYTableDrapHeaderView.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/30.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYDrapBackgroundView.h"

@interface HYDrapBackgroundView ()

@property (nonatomic, strong) UIImage *image;

@end

@implementation HYDrapBackgroundView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _image = [UIImage imageNamed:@"SightAction"];
        _offsetY = 0;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _image = [UIImage imageNamed:@"SightAction"];
        _offsetY = 0;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setOffsetY:(CGFloat)offsetY
{
    _offsetY = fabs(offsetY);
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    if(self.offsetY < self.image.size.height * 0.5)
    {
        return;
    }
    CGFloat diameter = self.offsetY - self.image.size.height * 0.5;
    self.isOK = NO;
    if(diameter < 0)
    {
        return;
    }
    CGFloat alpha = 0.4f;
    CGFloat pointX = (self.frame.size.width - self.image.size.width) * 0.5;
    CGFloat pointY = 64 + ((self.offsetY - self.image.size.height) * 0.5);
    CGContextRef context = UIGraphicsGetCurrentContext();

    if(diameter > self.image.size.height && diameter > self.image.size.width)
    {
        self.isOK = YES;
        alpha = 1.0f;
    }
    else
    {
        CGFloat circleX = (self.frame.size.width - diameter) * 0.5;
        CGFloat circleY = 64 + ((self.offsetY - diameter) * 0.5) + 2;
        CGContextAddEllipseInRect(context, CGRectMake(circleX, circleY, diameter, diameter));
        CGContextClip(context);
        CGContextFillPath(context);
    }
    
    [_image drawAtPoint:CGPointMake(pointX, pointY) blendMode:kCGBlendModeNormal alpha:alpha];
}

@end
