//
//  HYRefreshHeaderView.h
//  weibo
//
//  Created by zhangfuqiang on 15/11/26.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYRefreshHeaderView : UIView

-(void)refreshWithTableView:(UITableView *)tableView scrollView:(UIScrollView *)scrollView;

-(void)refreshDidEndDragging:(UITableView *)tableView scrollView:(UIScrollView *)scrollView;

@property (nonatomic, weak) UITableView *tableView;

@end
