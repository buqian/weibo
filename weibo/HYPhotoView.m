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
#import "HYModelView.h"

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
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            imageView.backgroundColor = [UIColor colorWithRed:0.765 green:0.743 blue:0.768 alpha:1.000];
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)];
            [imageView addGestureRecognizer:recognizer];
            [self addSubview:imageView];
            [array addObject:imageView];
        }
        self.imageViewArray = array;
    }
    return self;
}

-(void)photoTap:(UITapGestureRecognizer *)recognizer
{
    HYModelView *modelView = [[HYModelView alloc] initWithFrame:self.window.bounds];
    [self.window addSubview:modelView];
    
    NSMutableArray *array = [NSMutableArray array];
    unsigned long count = self.weibo.pic_urls.count;
    for(int i = 0; i < count; i ++)
    {
        [array addObject:self.imageViewArray[i]];
    }
    modelView.photoArray = array;
    
    modelView.currentView = (UIImageView *)recognizer.view;
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
        [imageView sd_setImageWithURL:[NSURL URLWithString:weibo.pic_urls[i][@"thumbnail_pic"]]];
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
