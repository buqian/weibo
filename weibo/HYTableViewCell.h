//
//  HYTableViewCell.h
//  weibo
//
//  Created by zhangfuqiang on 15/11/18.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYWeibo.h"

@interface HYTableViewCell : UITableViewCell

@property (nonatomic, strong) HYWeibo *weibo;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
