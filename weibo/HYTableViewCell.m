//
//  HYTableViewCell.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/18.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYTableViewCell.h"
#import "HYWeiboFrame.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "SDWebImage/UIButton+WebCache.h"
#import "HYWeiboTopView.h"
#import "HYPhotoView.h"
#import "HYWeiboToolbar.h"

@interface HYTableViewCell ()

@property (nonatomic, weak) HYWeiboTopView *topView;
@property (nonatomic, weak) HYWeiboToolbar *toolbar;

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
        
        HYWeiboTopView *topView = [[HYWeiboTopView alloc] init];
        [self addSubview:topView];
        self.topView = topView;
        
        HYWeiboToolbar *toolbar = [[HYWeiboToolbar alloc] init];
        [self addSubview:toolbar];
        self.toolbar = toolbar;
        
//        self.layer.shadowColor = [[UIColor grayColor] CGColor];
//        self.layer.shadowOffset = CGSizeMake(0, 1);
//        self.layer.shadowRadius = 1;
//        self.layer.shadowOpacity = 0.2;
//
//        self.layer.borderWidth = 2;
//        self.layer.borderColor = [[UIColor whiteColor] CGColor];
//
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableview_sectionheader_background"]];
//        self.selectionStyle = UITableViewCellSelectionStyleDefault;
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
    
    self.topView.weibo = weibo;
    self.topView.frame = weibo.frame.topViewFrame;
    
    self.toolbar.weibo = weibo;
    self.toolbar.frame = weibo.frame.toolbarFrame;
}

//-(void)layoutSubviews
//{
//    
//    
//}

@end
