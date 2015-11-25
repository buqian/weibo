//
//  HYRetweetView.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/25.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYRetweetView.h"
#import "HYPhotoView.h"
#import "HYWeiboFrame.h"

@interface HYRetweetView ()

@property (nonatomic, weak) UILabel *textLabel;

@property (nonatomic, weak) HYPhotoView *photoView;

@end

@implementation HYRetweetView

-(instancetype)init
{
    if(self = [super init])
    {
        UILabel *textLable = [[UILabel alloc] init];
        textLable.textColor = [UIColor colorWithRed:0.275 green:0.282 blue:0.279 alpha:1.000];
        [textLable setFont:HYTextFont];
        textLable.numberOfLines = 0;
        [self addSubview:textLable];
        self.textLabel = textLable;
        
        HYPhotoView *photoView = [[HYPhotoView alloc] init];
        [self addSubview:photoView];
        self.photoView = photoView;
    }
    return self;
}

@end
