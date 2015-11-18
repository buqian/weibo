//
//  HYTableViewCell.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/18.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYTableViewCell.h"
#define margin 10

@interface HYTableViewCell ()

@property (nonatomic, weak) UIButton *headBtn;
@property (nonatomic, weak) UIButton *nameBtn;
@property (nonatomic, weak) UILabel *timeLable;
@property (nonatomic, weak) UILabel *sourceLable;
@property (nonatomic, weak) UILabel *textLable;
@property (nonatomic, weak) UIButton *arrowBtn;

@end

@implementation HYTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *ID = @"statuses_home";
    HYTableViewCell *cell = (HYTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell = [[HYTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIButton *headBth = [UIButton buttonWithType:UIButtonTypeCustom];
        headBth.layer.masksToBounds = YES;
        [self addSubview:headBth];
        self.headBtn = headBth;
        
        UIButton *nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [nameBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [nameBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [nameBtn.titleLabel setFont:[UIFont systemFontOfSize:15 weight:0.5]];
        nameBtn.contentHorizontalAlignment = UIViewContentModeLeft;

        [self addSubview:nameBtn];
        self.nameBtn = nameBtn;
        
        UILabel *timeLable = [[UILabel alloc] init];
        timeLable.textColor = [UIColor orangeColor];
        timeLable.font = [UIFont systemFontOfSize:14];
        [self addSubview:timeLable];
        self.timeLable = timeLable;
        
        
        UILabel *sourceLable = [[UILabel alloc] init];
        sourceLable.font = [UIFont systemFontOfSize:14];
        [self addSubview:sourceLable];
        self.sourceLable = sourceLable;
        
        UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [arrowBtn setImage:[UIImage imageNamed:@"detail_wares_icon_more"] forState:UIControlStateNormal];
        [arrowBtn setImage:[UIImage imageNamed:@"detail_wares_icon_more"] forState:UIControlStateHighlighted];
        [self addSubview:arrowBtn];
        self.arrowBtn = arrowBtn;
        
        UILabel *textLable = [[UILabel alloc] init];
        textLable.numberOfLines = 0;
        [self addSubview:textLable];
        self.textLable = textLable;
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}


-(void)setWeibo:(HYWeibo *)weibo
{
    _weibo = weibo;
    
    HYUser *user = weibo.user;
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:user.profile_image_url]]];
    [self.headBtn setImage:image forState:UIControlStateNormal];
    [self.headBtn setImage:image forState:UIControlStateHighlighted];
    
    [self.nameBtn setTitle:user.name forState:UIControlStateNormal];
    
    //    [self.timeLable setText:[NSString stringWithFormat:@"%@", weibo.created_at]];
    [self.timeLable setText:@"刚刚"];
    
    NSRange range = [weibo.source rangeOfString:@">"];
    NSString *str = [weibo.source substringFromIndex:(range.location + range.length)];
    range = [str rangeOfString:@"<"];
    str = [str substringToIndex:range.location];
    [self.sourceLable setText:str];
    //    self.sourceLable.attributedText = [[NSAttributedString alloc] initWithData:[weibo.source dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    [self.textLable setText:weibo.text];
}

-(void)layoutSubviews
{
    self.headBtn.frame = CGRectMake(margin, margin, 35, 35);
    self.headBtn.layer.cornerRadius = self.headBtn.frame.size.width * 0.5;
    self.headBtn.layer.masksToBounds = YES;
    
    self.nameBtn.frame = CGRectMake(CGRectGetMaxX(self.headBtn.frame) + margin, margin, 100, 13);
    
    self.timeLable.frame = CGRectMake(self.nameBtn.frame.origin.x, CGRectGetMaxY(self.nameBtn.frame) + 7, 100, 12);
    
    self.sourceLable.frame = CGRectMake(CGRectGetMaxX(self.timeLable.frame), self.timeLable.frame.origin.y, 100, 12);
    CGFloat arrawW = 12;
    CGFloat arrawH = arrawW;
    self.arrowBtn.frame = CGRectMake(self.frame.size.width - margin - arrawW, margin, arrawW, arrawH);
    
    self.textLable.frame = CGRectMake(margin, CGRectGetMaxY(self.headBtn.frame) + 7, self.frame.size.width - 2 * margin, 50);
}

@end
