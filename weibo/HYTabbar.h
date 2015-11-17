//
//  HYTabbar.h
//  test
//
//  Created by zhangfuqiang on 15/11/12.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYTabbar;

@protocol HYTabbarDeletage <NSObject>

@optional
-(void)tabbar:(HYTabbar *)tabbar tabbarItemClickFrom:(long)from to:(long)to;
@end

@interface HYTabbar : UIView

@property (nonatomic, weak) id<HYTabbarDeletage> delegate;

+(instancetype) tabbar;

-(void)addTabbarItem:(UITabBarItem *) item;
@end
