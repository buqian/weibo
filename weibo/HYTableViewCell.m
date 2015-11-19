//
//  HYTableViewCell.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/18.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYTableViewCell.h"
#import "HYWeiboFrame.h"
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
        sourceLable.font = HYTimeFont;
        [self addSubview:sourceLable];
        self.sourceLable = sourceLable;
        
        UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [arrowBtn setImage:[UIImage imageNamed:@"detail_wares_icon_more"] forState:UIControlStateNormal];
        [arrowBtn setImage:[UIImage imageNamed:@"detail_wares_icon_more"] forState:UIControlStateHighlighted];
        [self addSubview:arrowBtn];
        self.arrowBtn = arrowBtn;
        
        UILabel *textLable = [[UILabel alloc] init];
        [textLable setFont:HYTextFont];
        textLable.numberOfLines = 0;
        [self addSubview:textLable];
        self.textLable = textLable;
        
        self.layer.shadowColor = [[UIColor grayColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(0, 1);
        self.layer.shadowRadius = 1;
        self.layer.shadowOpacity = 0.2;
//        
//        self.layer.borderWidth = 2;
//        self.layer.borderColor = [[UIColor redColor] CGColor];
//
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableview_sectionheader_background"]];
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= margin;
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
    [self.timeLable setText:[weibo getCreateTime]];
    
    [self.sourceLable setText:weibo.source];
    //    self.sourceLable.attributedText = [[NSAttributedString alloc] initWithData:[weibo.source dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    [self.textLable setText:weibo.text];
}

-(void)layoutSubviews
{
    HYWeiboFrame *frame = _weibo.frame;
    self.headBtn.frame = frame.headFrame;
    self.headBtn.layer.cornerRadius = frame.headFrame.size.width * 0.5;
    self.headBtn.layer.masksToBounds = YES;
    self.headBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.nameBtn.frame = frame.nameFrame;
    
    self.timeLable.frame = frame.timeFrame;
    
    self.sourceLable.frame = frame.sourceFrame;
    
    self.arrowBtn.frame = frame.arrowFrame;
    
    self.textLable.frame = frame.textFrame;

}

@end
