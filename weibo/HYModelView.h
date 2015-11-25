//
//  HYModelView.h
//  weibo
//
//  Created by bala on 25/11/15.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYModelView : UIScrollView

@property (nonatomic, strong) NSArray *photoArray;
@property (nonatomic, weak) UIImageView *currentView;

@end
