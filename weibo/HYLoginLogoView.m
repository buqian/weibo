//
//  HYLoginLogoView.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/16.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYLoginLogoView.h"

@interface HYLoginLogoView()

@property (nonatomic, strong) UIImage *image;


@end

@implementation HYLoginLogoView

-(void)setUIImage:(UIImage *)image
{
    self.image = image;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [[UIColor whiteColor] set];
    CGContextAddEllipseInRect(context, rect);
    CGContextSetShadowWithColor(context,CGSizeMake(0.5, 0.5), 0.5,[[UIColor grayColor] CGColor]);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    CGContextAddEllipseInRect(context, CGRectMake(2, 2, 64, 64));
    [[UIColor redColor] set];
    
    CGContextClip(context);
    CGContextFillPath(context);
    
    [self.image drawInRect:rect];
//    CGContextClip(context);
//    CGContextFillPath(context);
    NSLog(@"HYLoginLogoView.drawRect,%@", self.image);
}

@end
