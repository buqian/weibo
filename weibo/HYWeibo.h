//
//  HYWeibo.h
//  weibo
//
//  Created by zhangfuqiang on 15/11/18.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYUser.h"

@interface HYWeibo : NSObject

@property (nonatomic, strong) HYUser *user;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, assign) NSDate *created_at;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, strong) NSArray *pic_urls;
@property (nonatomic, copy) NSString *thumbnail_pic;
@property (nonatomic, assign) int reposts_count;
@property (nonatomic, assign) int comments_count;
@property (nonatomic, assign) int attitudes_count;

@end
