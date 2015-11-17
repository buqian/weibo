//
//  HYTabbar.m
//  test
//
//  Created by zhangfuqiang on 15/11/12.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYTabbar.h"
#import "HYButton.h"

@interface HYTabbar()
@property (nonatomic, strong) NSMutableArray * btnArray;
@property (nonatomic, weak) HYButton *selectedBtn;
@property (nonatomic, weak) UIButton *composeBtn;
@end

@implementation HYTabbar

-(NSArray *)btnArray
{
    if(nil == _btnArray)
    {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

+(instancetype)tabbar
{
    
    HYTabbar *tabbar = [[HYTabbar alloc] init];
    return tabbar;
}

-(instancetype)init
{
    CGFloat tabbarH = 44;
    CGRect frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - tabbarH, [[UIScreen mainScreen] bounds].size.width, tabbarH);
    if(self = [super initWithFrame:frame])
    {
        self.alpha = 0.99f;
        [self setBackgroundColor:HYColor(250, 250, 250)];
        
        UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_compose_below_background"]];
        backImage.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:backImage];
        UIButton *composeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [composeBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [composeBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [composeBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [composeBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        composeBtn.bounds = CGRectMake(0, 0, composeBtn.currentBackgroundImage.size.width, composeBtn.currentBackgroundImage.size.height);
        [self addSubview:composeBtn];
        self.composeBtn = composeBtn;
        
//        self.layer.borderWidth=1;
//        self.layer.borderColor=[[UIColor blackColor] CGColor];
        
        self.layer.shadowOffset = CGSizeMake(0, -1);
        self.layer.shadowOpacity = 0.2;
        self.layer.shadowRadius = 1;
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
    }
    return self;
}

-(void)addTabbarItem:(UITabBarItem *) item
{
    HYButton * btn = [[HYButton alloc] init];
    btn.item = item;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self.btnArray addObject:btn];
    [self addSubview:btn];
}

-(void)layoutSubviews
{
    CGFloat tabbarW = self.bounds.size.width;
    CGFloat tabbarH = self.bounds.size.height;
    self.composeBtn.center = CGPointMake(tabbarW * 0.5, tabbarH * 0.5);
    
    
    unsigned long count = self.btnArray.count;
    CGFloat btnW = self.frame.size.width / (count + 1);
    CGFloat btnY = 0;
    CGFloat btnH = self.frame.size.height;
    for(int i = 0; i < count; i ++)
    {
        CGFloat btnX = btnW * i;
        if(i > 1) {
            btnX = btnX + btnW;
        }
        HYButton *btn = self.btnArray[i];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.tag = i;
        if(0 == i) {
            [self btnClick:btn];
        }
    }
}


-(void)btnClick:(HYButton *) sender
{
    if([self.delegate respondsToSelector:@selector(tabbar:tabbarItemClickFrom:to:)])
    {
        [self.delegate tabbar:self tabbarItemClickFrom:self.selectedBtn.tag to:sender.tag];
    }
    
    self.selectedBtn.selected = false;
    sender.selected = true;
    self.selectedBtn = sender;
    
}

@end
