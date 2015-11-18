//
//  HYUser.h
//  weibo
//
//  Created by zhangfuqiang on 15/11/18.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYUser : NSObject

@property (nonatomic, copy) NSString *profile_image_url;
@property (nonatomic, copy) NSString *avatar_large;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *mbtype;
@property (nonatomic, copy) NSString *star;

@end
