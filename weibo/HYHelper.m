//
//  HYHelper.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/16.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYHelper.h"

static NSString *access_token;
static NSString *code;

@implementation HYHelper

+(void)setAccess_token:(NSString *)token
{
    access_token = token;
}

+(NSString *)getAccess_token
{
    return access_token;
}

+(void)setCode:(NSString *)_code
{
    code = _code;
}

+(NSString *)getCode
{
    return code;
}

@end
