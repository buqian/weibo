//
//  HYUnlockView.h
//  weibo
//
//  Created by zhangfuqiang on 15/12/4.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYUnlockView;

@protocol HYUnlockViewDataSource <NSObject>

@required
- (UIBezierPath *)drawRectUseBezierPath:(HYUnlockView *)unlockView;
- (UIColor *)drawRectUseColor:(HYUnlockView *)unlockView;

@end

@interface HYUnlockView <HYUnlockViewDataSource> : UIView

@property (nonatomic, weak) id<HYUnlockViewDataSource> dataSource;

@end
