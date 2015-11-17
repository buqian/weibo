//
//  HYHelper.h
//  weibo
//
//  Created by zhangfuqiang on 15/11/16.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYHelper : NSObject
+(void)setAccess_token:(NSString *)token;

+(NSString *)getAccess_token;

+(void)setCode:(NSString *)_code;

+(NSString *)getCode;
@end
