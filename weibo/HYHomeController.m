//
//  HYHomeController.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/13.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYHomeController.h"

@interface HYHomeController ()

@end

@implementation HYHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(instancetype)initWithTitle:(NSString *)title leftBarButtonItem:(UIBarButtonItem *)left rightBarButtonItem:(UIBarButtonItem *)right
{
    if(self = [super initWithStyle:UITableViewStylePlain])
    {
        self.title = title;
        self.navigationItem.leftBarButtonItem = left;
        self.navigationItem.rightBarButtonItem = right;

    }
    return self;
}

@end
