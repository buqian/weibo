//
//  HYWeiboTopView.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/25.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYWeiboTopView.h"
#import "HYWeiboFrame.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "HYPhotoView.h"
#import "HYRetweetView.h"

@interface HYWeiboTopView ()

@property (nonatomic, weak) UIButton *headBtn;
@property (nonatomic, weak) UIImageView *headView;
@property (nonatomic, weak) UIButton *nameBtn;
@property (nonatomic, weak) UILabel *timeLable;
@property (nonatomic, weak) UILabel *sourceLable;
@property (nonatomic, weak) UILabel *textLable;
@property (nonatomic, weak) UIButton *arrowBtn;
@property (nonatomic, weak) HYPhotoView *photoView;
@property (nonatomic, weak) HYRetweetView *retweetView;

@end

@implementation HYWeiboTopView

-(instancetype)init
{
    if(self = [super init])
    {
        UIButton *headBth = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:headBth];
        self.headBtn = headBth;
        
        UIImageView *headView = [[UIImageView alloc] init];
        [headBth addSubview:headView];
        self.headView = headView;
        
        UIButton *nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [nameBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [nameBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [nameBtn.titleLabel setFont:HYNameFont];
        
        nameBtn.contentHorizontalAlignment = UIViewContentModeLeft;
        
        [self addSubview:nameBtn];
        self.nameBtn = nameBtn;
        
        UILabel *timeLable = [[UILabel alloc] init];
        timeLable.textColor = [UIColor orangeColor];
        timeLable.font = HYTimeFont;
        [self addSubview:timeLable];
        self.timeLable = timeLable;
        
        
        UILabel *sourceLable = [[UILabel alloc] init];
        sourceLable.textColor = [UIColor colorWithRed:0.275 green:0.282 blue:0.279 alpha:1.000];
        sourceLable.font = HYTimeFont;
        [self addSubview:sourceLable];
        self.sourceLable = sourceLable;
        
        UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [arrowBtn setImage:[UIImage imageNamed:@"detail_wares_icon_more"] forState:UIControlStateNormal];
        [arrowBtn setImage:[UIImage imageNamed:@"detail_wares_icon_more"] forState:UIControlStateHighlighted];
        [self addSubview:arrowBtn];
        self.arrowBtn = arrowBtn;
        
        UILabel *textLable = [[UILabel alloc] init];
        textLable.textColor = [UIColor colorWithRed:0.275 green:0.282 blue:0.279 alpha:1.000];
        [textLable setFont:HYTextFont];
        textLable.numberOfLines = 0;
        [self addSubview:textLable];
        self.textLable = textLable;
        
        HYPhotoView *photoView = [[HYPhotoView alloc] init];
        [self addSubview:photoView];
        self.photoView = photoView;
        
        HYRetweetView *retweetView = [[HYRetweetView alloc] init];
        [self addSubview:retweetView];
        self.retweetView = retweetView;
        
//        self.layer.borderWidth = 1;
//        self.layer.borderColor = [[UIColor redColor] CGColor];
        
    }
    return self;
}

-(void)setWeibo:(HYWeibo *)weibo
{
    _weibo = weibo;
    
    HYUser *user = weibo.user;
    
    //    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:user.profile_image_url]]];
    //    [self.headBtn setImage:image forState:UIControlStateNormal];
    //    [self.headBtn setImage:image forState:UIControlStateHighlighted];
    //    [self.headBtn sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] forState:UIControlStateNormal];
    //    [self.headBtn sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] forState:UIControlStateHighlighted];
    
    [self.headView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url]];
    
    [self.nameBtn setTitle:user.name forState:UIControlStateNormal];
    
    //    [self.timeLable setText:[NSString stringWithFormat:@"%@", weibo.created_at]];
    [self.timeLable setText:[weibo getCreateTime]];
    
    [self.sourceLable setText:weibo.source];
    //    self.sourceLable.attributedText = [[NSAttributedString alloc] initWithData:[weibo.source dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    [self.textLable setText:weibo.text];
    
    self.photoView.weibo = weibo;
    
    HYWeiboFrame *frame = _weibo.frame;
    
    self.headBtn.frame = frame.headFrame;
    self.headBtn.layer.cornerRadius = frame.headFrame.size.width * 0.5;
    self.headBtn.layer.masksToBounds = YES;
    self.headView.frame = self.headBtn.bounds;
    
    self.nameBtn.frame = frame.nameFrame;
    
    self.timeLable.frame = frame.timeFrame;
    
    self.sourceLable.frame = frame.sourceFrame;
    
    self.arrowBtn.frame = frame.arrowFrame;
    
    self.textLable.frame = frame.textFrame;
    
    if(nil == weibo.retweet)
    {
        self.retweetView.hidden = YES;
        self.photoView.hidden = NO;
        self.retweetView.frame = CGRectZero;
        self.photoView.frame = frame.photoViewFrame;
    }
    else
    {
        self.retweetView.hidden = NO;
        self.photoView.hidden = YES;
        self.retweetView.weibo = weibo;
        self.photoView.frame = CGRectZero;
        self.retweetView.frame = frame.retweetFrame;
    }
}


@end
