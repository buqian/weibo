//
//  HYRefreshHeaderView.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/26.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYRefreshFooterView.h"

@interface HYRefreshFooterView ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, assign) BOOL startRefresh;
@property (nonatomic, assign) double angle;

@end

@implementation HYRefreshFooterView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableview_pull_refresh"]];
        [self addSubview:imageView];
        self.imageView = imageView;
        self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"下拉刷新";
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = HYColor(148, 148, 148);
        [self addSubview:label];
        self.label = label;
        
        CGFloat labelWidth = 80;
        CGFloat imageWidth = 32;
        CGFloat imageHeight = imageWidth;
        CGFloat imageX = (self.frame.size.width - labelWidth - imageWidth) * 0.5;
        CGFloat imageY = (self.frame.size.height - imageHeight) * 0.5;
        self.imageView.frame = CGRectMake(imageX, imageY, imageWidth, imageHeight);
        self.label.frame = CGRectMake(165, imageY, labelWidth, imageHeight);
    }
    return self;
}

-(void)clickBtn
{
    [self startRefreshImageViewRotate];
}

-(void)setTableView:(UITableView *)tableView
{
    _tableView = tableView;
    tableView.contentInset = UIEdgeInsetsMake(tableView.contentInset.top, tableView.contentInset.left, -50, tableView.contentInset.right);
    self.angle = 0;
}

-(void)refreshWithTableView:(UITableView *)tableView scrollView:(UIScrollView *)scrollView
{
    if(self.startRefresh)
    {
        return;
    }
    CGFloat offsety = scrollView.contentOffset.y + self.tableView.frame.size.height - 44;
    if(offsety > CGRectGetMaxY(self.frame))
    {
        self.isRefresh = YES;
        self.label.text = @"释放更新";
        [UIView animateWithDuration:0.2 animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
        }];
    }
    else
    {
        self.isRefresh = NO;
        self.label.text = @"上拉刷新";
        [UIView animateWithDuration:0.2 animations:^{
            self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }
}

-(void)refreshDidEndDragging:(UITableView *)tableView scrollView:(UIScrollView *)scrollView
{
    if(self.isRefresh) {
        self.startRefresh = YES;
        tableView.bounces = NO;
        tableView.contentInset = UIEdgeInsetsMake(tableView.contentInset.top, tableView.contentInset.left, 44, tableView.contentInset.right);
        self.label.text = @"加载中...";
        self.imageView.image = [UIImage imageNamed:@"tableview_loading"];
        
        self.imageView.transform = CGAffineTransformIdentity;
        [self startRefreshImageViewRotate];
        [UIView animateWithDuration:0.5 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            tableView.contentInset = UIEdgeInsetsMake(tableView.contentInset.top, tableView.contentInset.left, 0, tableView.contentInset.right);
        } completion:^(BOOL finished) {
            tableView.bounces = YES;
            self.imageView.image = [UIImage imageNamed:@"tableview_pull_refresh"];
            self.label.text = @"下拉刷新";
            self.startRefresh = NO;
        }];
    }
}

-(void)startRefreshImageViewRotate
{
    if(!self.startRefresh)
    {
        return;
    }
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(self.angle * (M_PI /180.0f));
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.imageView.transform = endAngle;
    } completion:^(BOOL finished) {
        self.angle += 3;
        [self startRefreshImageViewRotate];
    }];
}


@end
