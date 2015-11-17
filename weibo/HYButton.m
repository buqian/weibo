//
//  HYButton.m
//  test
//
//  Created by zhangfuqiang on 15/11/12.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYButton.h"

#define ImageViewHight 30

@interface HYButton()


@end

@implementation HYButton

- (instancetype)init
{
    if (self = [super init]) {
        [self.imageView setContentMode:UIViewContentModeCenter];
        [self.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
//        [self setBackgroundColor:[UIColor colorWithRed:0.510 green:0.958 blue:1.000 alpha:1.000]];
//        [self.imageView setBackgroundColor:[UIColor colorWithRed:1.000 green:0.891 blue:0.264 alpha:1.000]];
//        [self.titleLabel setBackgroundColor:[UIColor colorWithRed:1.000 green:0.220 blue:0.765 alpha:1.0]];
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 1, contentRect.size.width, ImageViewHight);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height - ImageViewHight + 13;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, self.frame.size.width, titleH);
}

-(void)setItem:(UITabBarItem *)item
{
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    
    [self setTitle:item.title forState:UIControlStateNormal];
    
    _item = item;
}


@end
