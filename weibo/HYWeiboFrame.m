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
    
    CGFloat arrawW = 12;
    CGFloat arrawH = arrawW;
    self.arrowFrame = CGRectMake(cellWidth - margin - arrawW, margin, arrawW, arrawH);
    
    CGSize size = [[self.weibo getCreateTime] sizeWithAttributes:@{NSFontAttributeName : HYTimeFont}];
    
    CGFloat nameWidth = self.arrowFrame.origin.x - CGRectGetMaxX(self.headFrame) - margin;
    self.nameFrame = CGRectMake(CGRectGetMaxX(self.headFrame) + margin, 7, nameWidth, 35 - size.height);
    
    self.timeFrame = CGRectMake(self.nameFrame.origin.x, CGRectGetMaxY(self.nameFrame) + 3, size.width + margin, size.height);
    
    CGFloat sourceWidth = self.arrowFrame.origin.x - CGRectGetMaxX(self.timeFrame) - margin;
    self.sourceFrame = CGRectMake(CGRectGetMaxX(self.timeFrame) + margin, self.timeFrame.origin.y, sourceWidth, size.height);
    
    size = [self.weibo.text boundingRectWithSize:CGSizeMake(cellWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : HYTextFont} context:nil].size;
    self.textFrame = CGRectMake(margin, CGRectGetMaxY(self.headFrame) + 7, size.width, size.height);
    
    CGFloat photoViewHeight = 0;
    if(nil != self.weibo.retweet)
    {
        NSString *retweenText = [NSString stringWithFormat:@"@%@:%@", self.weibo.retweet.user.name, self.weibo.retweet.text];
        size = [retweenText boundingRectWithSize:CGSizeMake(cellWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : HYTextFont} context:nil].size;
        self.retweetTextFrame = CGRectMake(margin, margin, size.width, size.height);
        
        unsigned long count = self.weibo.retweet.pic_urls.count;
        CGFloat height = ([[UIScreen mainScreen] bounds].size.width - margin * 4) / 3;
        CGFloat row = (count - 1) / 3 + 1;
        photoViewHeight = row * (height + margin);
        
        self.retweetPhotoViewFrame = CGRectMake(0, CGRectGetMaxY(self.retweetTextFrame), [[UIScreen mainScreen] bounds].size.width, photoViewHeight);
        
        self.retweetFrame = CGRectMake(0, CGRectGetMaxY(self.textFrame), [[UIScreen mainScreen] bounds].size.width, CGRectGetMaxY(self.retweetPhotoViewFrame));
        
        self.toolbarFrame = CGRectMake(0, CGRectGetMaxY(self.retweetFrame) + margin, [[UIScreen mainScreen] bounds].size.width, 36);
    }
    else
    {
        unsigned long count = self.weibo.pic_urls.count;
        CGFloat height = ([[UIScreen mainScreen] bounds].size.width - margin * 4) / 3;
        CGFloat row = (count - 1) / 3 + 1;
        photoViewHeight = row * (height + margin);
        
        self.photoViewFrame = CGRectMake(0, CGRectGetMaxY(self.textFrame), [[UIScreen mainScreen] bounds].size.width, photoViewHeight);
        
        self.topViewFrame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, CGRectGetMaxY(self.photoViewFrame));
        
        self.toolbarFrame = CGRectMake(0, CGRectGetMaxY(self.photoViewFrame) + margin, [[UIScreen mainScreen] bounds].size.width, 36);
    }
    
    self.height = (long int)(CGRectGetMaxY(self.toolbarFrame) + margin - 3);
}

@end
