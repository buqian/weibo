//
//  HYUnlockView.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/4.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYUnlockView.h"

@implementation HYUnlockView

@synthesize dataSource;

-(void)drawRect:(CGRect)rect
{
    if(dataSource)
    {
        UIColor *color = [dataSource drawRectUseColor:self];
        [color set];
        
        UIBezierPath *path = [dataSource drawRectUseBezierPath:self];
        [path stroke];
    }
}

@end
