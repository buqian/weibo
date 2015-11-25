//
//  HYModelView.m
//  weibo
//
//  Created by bala on 25/11/15.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYModelView.h"

@interface HYModelView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *imageViewArray;
@property (nonatomic, assign) CGRect currentRect;
@property (nonatomic, assign) BOOL stopScroll;

@end

@implementation HYModelView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor blackColor];
        self.pagingEnabled = YES;
        self.delegate = self;
        _stopScroll = NO;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.stopScroll) {
        return;
    }
    int index = scrollView.contentOffset.x / self.frame.size.width;
    UIImageView *view = (UIImageView *)self.photoArray[index];
    if(view == self.currentView) {
        return;
    }
    self.currentView.hidden = NO;
    self.currentRect = [self getRect:view];
    view.hidden = YES;
    _currentView = view;
}

-(void)setPhotoArray:(NSArray *)photoArray
{
    _photoArray = photoArray;
    unsigned long count = photoArray.count;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < count; i ++) {
        CGRect rect = [self getRect:photoArray[i]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
        imageView.userInteractionEnabled = YES;
        imageView.hidden = YES;
        imageView.image = ((UIImageView *)photoArray[i]).image;
        [self addSubview:imageView];
        [array addObject:imageView];
        imageView.tag = i;
        UITapGestureRecognizer *tapR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeModel:)];
        [imageView addGestureRecognizer:tapR];
    }
    self.imageViewArray = array;
    
    self.contentSize = CGSizeMake(self.imageViewArray.count * self.frame.size.width, self.frame.size.height);
}

-(void)setCurrentView:(UIImageView *)currentView
{
    _currentView = currentView;
    currentView.hidden = YES;
    unsigned long count = self.photoArray.count;
    int index = 0;
    for (int i = 0; i < count; i ++) {
        if(currentView == self.photoArray[i])
        {
            index = i;
            UIImageView *currentView = ((UIImageView *)self.imageViewArray[i]);
            currentView.hidden = NO;
            self.currentRect = [self getRect:self.photoArray[i]];
            [UIView animateWithDuration:0.5 animations:^{
                currentView.frame = CGRectMake(0, (self.frame.size.height - self.frame.size.width) / 2, self.frame.size.width, self.frame.size.width);
            } completion:^(BOOL finished) {
                self.contentOffset = CGPointMake(index * self.frame.size.width, 0);
                [self setupImageViewsFrame];
            }];
            break;
        }
    }
}

-(void)setupImageViewsFrame
{
    unsigned long count = self.imageViewArray.count;
    for(int i = 0; i < count; i ++) {
        UIImageView *imageView = self.imageViewArray[i];
        imageView.hidden = NO;
        imageView.frame = CGRectMake(self.frame.size.width * i, (self.frame.size.height - self.frame.size.width) / 2, self.frame.size.width, self.frame.size.width);
    }
}

-(void)removeModel:(UITapGestureRecognizer *)recongnizer
{
//    recongnizer.view.frame = recongnizer.view.bounds;
    for (UIImageView *view in self.imageViewArray) {
        if(view != recongnizer.view)
        {
            view.hidden = YES;
        }
    }
    self.stopScroll = YES;
    recongnizer.view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    self.contentOffset = CGPointZero;
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.5 animations:^{
        recongnizer.view.frame = self.currentRect;
    } completion:^(BOOL finished) {
        self.currentView.hidden = NO;
        [self removeFromSuperview];
    }];
}

-(CGRect)getRect:(UIView *)view
{
    return [view convertRect:view.bounds toView:nil];
}

@end
