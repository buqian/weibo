//
//  ViewController.m
//  test
//
//  Created by zhangfuqiang on 15/11/12.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "ViewController.h"
#import "HYTabbar.h"
#import "HYHomeController.h"
#import "HYMessageController.h"
#import "HYDiscoverController.h"
#import "HYMeController.h"
#import "HyNavigationController.h"



@interface ViewController () <HYTabbarDeletage>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"ViewController.viewDidLoad");
    
    [self.tabBar removeFromSuperview];
    
    [self setupTabbar];
    [self setupChildControllers];
}

-(UIBarButtonItem *)getBarButtonItemWithTitle:(NSString *)title imageNamed:(NSString *)imageNamed highlightedImageNamed:(NSString *)highlightedImageNamed
{
    UIButton *btn;
    if(title) {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn setTitleColor:HYColor(77, 77, 77) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        btn.frame = CGRectMake(0, 0, 100, 40);
    } else {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:imageNamed] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:highlightedImageNamed] forState:UIControlStateHighlighted];
        btn.frame = CGRectMake(0, 0, btn.currentBackgroundImage.size.width, btn.currentBackgroundImage.size.        height);
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

-(void)hideTabbar
{
//    self.tabBar.hidden = YES;
    for (UIView *view in [self.view subviews]) {
        if([view isKindOfClass:NSClassFromString(@"HYTabbar")])
        {
            view.hidden = YES;
        }
    }
}

-(void)showTabbar
{
    for (UIView *view in [self.view subviews]) {
        if([view isKindOfClass:NSClassFromString(@"HYTabbar")])
        {
            view.hidden = NO;
        }
    }
}

-(void)setupChildControllers
{
    // home -------------
//    UIButton *homeLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [homeLeftBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_friendattention"] forState:UIControlStateNormal];
//    [homeLeftBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_friendattention_highlighted"] forState:UIControlStateHighlighted];
//    homeLeftBtn.frame = CGRectMake(0, 0, homeLeftBtn.currentBackgroundImage.size.width, homeLeftBtn.currentBackgroundImage.size.height);
    UIBarButtonItem *homeLeft = [self getBarButtonItemWithTitle:nil imageNamed:
                                 @"navigationbar_friendattention" highlightedImageNamed:@"navigationbar_friendattention_highlighted"];
    
//    UIButton *homeRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [homeRightBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_icon_radar"] forState:UIControlStateNormal];
//    [homeRightBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_icon_radar_highlighted"] forState:UIControlStateHighlighted];
//    homeRightBtn.frame = CGRectMake(0, 0, homeRightBtn.currentBackgroundImage.size.width, homeRightBtn.currentBackgroundImage.size.height);
    UIBarButtonItem *homeRight = [self getBarButtonItemWithTitle:nil imageNamed:@"navigationbar_icon_radar" highlightedImageNamed:@"navigationbar_icon_radar_highlighted"];
    
    HYHomeController *homeVc = [[HYHomeController alloc] initWithTitle:@"首页" leftBarButtonItem:homeLeft rightBarButtonItem:homeRight];
    HyNavigationController *homeNV = [[HyNavigationController alloc] initWithRootViewController:homeVc];
    [self addChildViewController:homeNV];
    
    // 消息 ---------------------
//    UIButton *messageLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [messageLeftBtn setTitle:@"发现群" forState:UIControlStateNormal];
//    [messageLeftBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
//    [messageLeftBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [messageLeftBtn setTitleColor:HYColor(77, 77, 77) forState:UIControlStateNormal];
//    [messageLeftBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
//    messageLeftBtn.frame = CGRectMake(0, 0, 100, 40);
    UIBarButtonItem *messageLeft = [self getBarButtonItemWithTitle:@"发现群" imageNamed:nil highlightedImageNamed:nil];
    
//    UIButton *messageRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [messageRightBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_icon_newchat"] forState:UIControlStateNormal];
//    [messageRightBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_icon_newchat_highlight"] forState:UIControlStateHighlighted];
//    messageRightBtn.frame = CGRectMake(0, 0, messageRightBtn.currentBackgroundImage.size.width, messageRightBtn.currentBackgroundImage.size.height);
    UIBarButtonItem *messageRight = [self getBarButtonItemWithTitle:nil imageNamed:@"navigationbar_icon_newchat" highlightedImageNamed:@"navigationbar_icon_newchat_highlight"];
    
    HYMessageController *messageVc = [[HYMessageController alloc] initWithTitle:@"消息" leftBarButtonItem:messageLeft rightBarButtonItem:messageRight];
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:messageVc]];
    
    // 发现 -----------
    CGRect searchRect = CGRectMake(0, 0, self.view.bounds.size.width - 30, 50);
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:searchRect];
    [searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    searchBar.placeholder = @"大家都在搜： 李晨";
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    UIBarButtonItem *searchLeft = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    HYDiscoverController *discover = [[HYDiscoverController alloc] initWithTitle:nil leftBarButtonItem:searchLeft rightBarButtonItem:nil];
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:discover]];
    
    HYMeController *me = [[HYMeController alloc] init];
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:me]];

}

-(void)setupTabbar
{
    HYTabbar * tabbar = [HYTabbar tabbar];
    tabbar.delegate = self;
    [self.view addSubview:tabbar];

    
    
    UITabBarItem *home = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageNamed:@"tabbar_home_selected"]];
    [tabbar addTabbarItem:home];
    
    UITabBarItem *message = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageNamed:@"tabbar_message_center_selected"]];
    [tabbar addTabbarItem:message];
    
    UITabBarItem * discover = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageNamed:@"tabbar_discover_selected"]];
    [tabbar addTabbarItem:discover];
    
    UITabBarItem * me = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageNamed:@"tabbar_profile_selected"]];
    [tabbar addTabbarItem:me];
}

-(void)tabbar:(HYTabbar *)tabbar tabbarItemClickFrom:(long)from to:(long)to
{
//    NSLog(@"from %ld to %ld", from, to);
    self.selectedIndex = to;
}

@end
