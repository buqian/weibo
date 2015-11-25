//
//  HYPhotoView.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/25.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYPhotoView.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "HYWeiboFrame.h"

#define ColCount 3;
#define RowCount 3;

@interface HYPhotoView ()

@property (nonatomic, strong) NSArray *imageViewArray;

@end

@implementation HYPhotoView

-(instancetype)init
{
    if(self = [super init])
    {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 9; i ++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.backgroundColor = [UIColor colorWithRed:0.765 green:0.743 blue:0.768 alpha:1.000];
            [self addSubview:imageView];
            [array addObject:imageView];
        }
        self.imageViewArray = array;
    }
    return self;
}

-(void)setWeibo:(HYWeibo *)weibo
{
    [self hidePhotos];
    _weibo = weibo;
    unsigned long count = weibo.pic_urls.count;
    int colCount = ColCount;
    CGFloat width = ([[UIScreen mainScreen] bounds].size.width - margin * (colCount + 1)) / ColCount;
    CGFloat height = width;
    for(int i = 0; i < count; i ++)
    {
        UIImageView *imageView = self.imageViewArray[i];
        [imageView sd_setImageWithURL:weibo.pic_urls[i]];
        CGFloat col = i % ColCount;
        CGFloat row = i / RowCount;
        imageView.frame = CGRectMake(col * (width + margin) + margin, row * (height + margin) + margin, width, height);
        imageView.hidden = NO;
    }
}

-(void)hidePhotos
{
    for (UIImageView *imageView in self.imageViewArray) {
        imageView.image = nil;
        imageView.hidden = YES;
    }
}

@end
