//
//  HYUnlockView.h
//  weibo
//
//  Created by zhangfuqiang on 15/12/4.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYUnlockView;

@protocol HYUnlockViewDelegate <NSObject>

@optional
-(BOOL)unlockViewSuccess:(HYUnlockView *)unlockView result:(NSString *)result;
-(void)unlockViewCancel:(HYUnlockView *)unlockView;

@end

@interface HYUnlockView <HYUnlockViewDataSource> : UIView

@property (nonatomic, weak) id<HYUnlockViewDelegate> delegate;

@end
