//
//  HYWeiboFrame.h
//  weibo
//
//  Created by zhangfuqiang on 15/11/19.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#define HYNameFont [UIFont systemFontOfSize:15]
#define HYTimeFont [UIFont systemFontOfSize:12]
#define HYTextFont [UIFont systemFontOfSize:17]

#define margin 10

@class HYWeibo;

@interface HYWeiboFrame : NSObject

@property (nonatomic, assign) CGRect headFrame;
@property (nonatomic, assign) CGRect nameFrame;
@property (nonatomic, assign) CGRect timeFrame;
@property (nonatomic, assign) CGRect sourceFrame;
@property (nonatomic, assign) CGRect arrowFrame;
@property (nonatomic, assign) CGRect textFrame;
@property (nonatomic, assign) CGRect topViewFrame;
@property (nonatomic, assign) CGRect photoViewFrame;
@property (nonatomic, assign) CGRect toolbarFrame;
@property (nonatomic, assign) CGRect retweetTextFrame;
@property (nonatomic, assign) CGRect retweetPhotoViewFrame;
@property (nonatomic, assign) CGRect retweetFrame;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) HYWeibo *weibo;

-(instancetype)initWithHYWeibo:(HYWeibo *)weibo;
@end
