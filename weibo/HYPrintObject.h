//
//  HYPrintObject.h
//  weibo
//
//  Created by zhangfuqiang on 15/12/8.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYPrintObject : NSObject

+ (void)print:(id)obj;

+ (NSDictionary*)getObjectData:(id)obj;

@end
