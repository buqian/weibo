//
//  HYUnlockButton.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/4.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYUnlockButton.h"

@interface HYUnlockButton ()

@end

@implementation HYUnlockButton


-(void)drawRect:(CGRect)rect
{
    
    CGRect drawRect = CGRectInset(rect, 1, 1);
    
    CGFloat centerW = 20;
    CGRect centerC = CGRectMake((rect.size.width - centerW) * 0.5, (rect.size.height - centerW) * 0.5, centerW, centerW);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor whiteColor] set];
    
    CGContextFillEllipseInRect(context, drawRect);
    
    [self.tintColor set];
    
    if(self.selected)
    {
        CGContextFillEllipseInRect(context, centerC);
    }

    CGContextStrokeEllipseInRect(context, drawRect);
}

@end
