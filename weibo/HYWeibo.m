//
//  HYWeibo.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/18.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYWeibo.h"
#import "HYWeiboFrame.h"


@implementation HYWeibo

-(HYWeiboFrame *)frame
{
    if(_frame == nil)
    {
        _frame = [[HYWeiboFrame alloc] init];
    }
    return _frame;
}

-(NSString *)getCreateTime
{
    NSDate *date = [NSDate date];
    int seconds = date.timeIntervalSince1970 - self.created_at.timeIntervalSince1970;
    seconds /= 60;
    return [NSString stringWithFormat:@"%d分钟", seconds];
}

-(void)setSource:(NSString *)source
{
    NSRange range = [source rangeOfString:@">"];
    NSString *str = [source substringFromIndex:(range.location + range.length)];
    range = [str rangeOfString:@"<"];
    str = [str substringToIndex:range.location];
    _source = [NSString stringWithFormat:@"来自 %@", str];
}

@end
