//
//  HYLuckLoopButton.m
//  weibo
//
//  Created by bala on 30/11/15.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYLuckLoopButton.h"

@implementation HYLuckLoopButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setHighlighted:(BOOL)highlighted
{
    
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake((contentRect.size.width - 43) * 0.5, 25, 43, 50);
}

@end
