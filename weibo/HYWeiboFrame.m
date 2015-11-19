//
//  HYWeiboFrame.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/19.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYWeiboFrame.h"
#import <UIKit/UIKit.h>
#import "HYWeibo.h"
#import "HYUser.h"

#define margin 10

@implementation HYWeiboFrame

-(instancetype)initWithHYWeibo:(HYWeibo *)weibo
{
    if(self = [super init])
    {
        _weibo = weibo;
        [self setupFrames];
    }
    return self;
}

-(void)setupFrames
{
    CGFloat cellWidth = [[UIScreen mainScreen] bounds].size.width - 2 * margin;
    
    self.headFrame = CGRectMake(margin, margin, 35, 35);
    
    CGSize size = [self.weibo.user.name sizeWithAttributes:@{NSFontAttributeName : HYNameFont}];
    self.nameFrame = CGRectMake(CGRectGetMaxX(self.headFrame) + margin, margin, size.width, size.height);
    
    size = [[self.weibo getCreateTime] sizeWithAttributes:@{NSFontAttributeName : HYTimeFont}];
    self.timeFrame = CGRectMake(self.nameFrame.origin.x, CGRectGetMaxY(self.nameFrame) + 3, size.width, size.height);
    
    size = [self.weibo.source sizeWithAttributes:@{NSFontAttributeName : HYTimeFont}];
    self.sourceFrame = CGRectMake(CGRectGetMaxX(self.timeFrame) + margin, self.timeFrame.origin.y, size.width, size.height);
    
    CGFloat arrawW = 12;
    CGFloat arrawH = arrawW;
    self.arrowFrame = CGRectMake(cellWidth - margin - arrawW, margin, arrawW, arrawH);
    
    size = [self.weibo.text boundingRectWithSize:CGSizeMake(cellWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : HYTextFont} context:nil].size;
    self.textFrame = CGRectMake(margin, CGRectGetMaxY(self.headFrame) + 7, size.width, size.height);
    
    self.height = CGRectGetMaxY(self.textFrame) + margin;
    
}

@end
