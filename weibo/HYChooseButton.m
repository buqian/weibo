//
//  HYChooseButton.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/1.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYChooseButton.h"

@implementation HYChooseButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addTarget:self action:@selector(btnDownClick) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(btnUpClick) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(btnUpClick) forControlEvents:UIControlEventTouchUpOutside];
    }
    return self;
}

- (void)btnUpClick
{
    self.alpha = 1;
}

- (void)btnDownClick
{
    self.alpha= 0.5;
}

-(void)setHighlighted:(BOOL)highlighted
{
}


@end
