//
//  HYWeiboToolbar.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/25.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYWeiboToolbar.h"
#import "HYWeiboFrame.h"

@interface HYWeiboToolbar ()

@property (nonatomic, weak) UIButton *retweetBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *likeBtn;
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, strong) NSMutableArray *lineArray;

@end

@implementation HYWeiboToolbar

-(NSMutableArray *)btnArray
{
    if(nil == _btnArray)
    {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

-(NSMutableArray *)lineArray
{
    if(nil == _lineArray)
    {
        _lineArray = [NSMutableArray array];
    }
    return _lineArray;
}

-(instancetype)init
{
    if(self = [super init])
    {
        self.userInteractionEnabled = YES;
        [self setImage:[UIImage imageNamed:@"timeline_card_background"]];
        [self setHighlightedImage:[UIImage imageNamed:@"timeline_card_background_highlighted"]];
        
        [self setupBtn];
        
        [self setupLine];
        
//        self.layer.borderColor = [[UIColor orangeColor] CGColor];
//        self.layer.borderWidth = 1;
        
    }
    return self;
}

-(void)setupLine
{
    UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
    [self addSubview:line];
    [self.lineArray addObject:line];
    
    line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
    [self addSubview:line];
    [self.lineArray addObject:line];
}

-(void)setupBtn
{
    UIButton *retweetBtn = [self buildBtn:@"timeline_topic_icon_retweet"];
    self.retweetBtn = retweetBtn;
    
    UIButton *commentBtn = [self buildBtn:@"timeline_topic_icon_comment"];
    self.commentBtn = commentBtn;
    
    UIButton *likeBtn = [self buildBtn:@"timeline_topic_icon_like"];
    self.likeBtn = likeBtn;
}

-(UIButton *)buildBtn:(NSString *)imageName
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitleColor:HYColor(190, 190, 190) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, 0);
    [self addSubview:btn];
    [self.btnArray addObject:btn];
    return btn;
}

-(void)setWeibo:(HYWeibo *)weibo
{
    _weibo = weibo;
    [self.retweetBtn setTitle:[NSString stringWithFormat:@"%d", weibo.reposts_count] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%d", weibo.comments_count] forState:UIControlStateNormal];
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%d", weibo.attitudes_count] forState:UIControlStateNormal];
}

-(void)layoutSubviews
{
    self.image = [self.image stretchableImageWithLeftCapWidth:self.image.size.width / 2 topCapHeight:self.image.size.height / 2];
    self.highlightedImage = [self.highlightedImage stretchableImageWithLeftCapWidth:self.highlightedImage.size.width / 2 topCapHeight:self.highlightedImage.size.height / 2];
//    [self setImage:[[UIImage imageNamed:@"timeline_card_background"] stretchableImageWithLeftCapWidth:13 topCapHeight:13]];
//    [self setHighlightedImage:[[UIImage imageNamed:@"timeline_card_background_highlighted"] stretchableImageWithLeftCapWidth:self.frame.size.width / 2 topCapHeight:self.frame.size.height / 2]];
    
    unsigned long btnCount = self.btnArray.count;
    CGFloat width = ([[UIScreen mainScreen] bounds].size.width - 0) / btnCount;
    for(int i = 0; i < btnCount; i ++)
    {
        UIButton *btn = self.btnArray[i];
        btn.frame = CGRectMake(i * width, 0, width, self.frame.size.height);
    }
    unsigned long lineCount = self.lineArray.count;
    for(int i = 0; i < lineCount; i ++)
    {
        UIImageView *view = self.lineArray[i];
        view.frame = CGRectMake((i + 1) * width, 0, 1, self.frame.size.height);
    }
}

@end
