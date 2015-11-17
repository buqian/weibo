//
//  HYMessageController.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/13.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYMessageController.h"

@interface HYMessageController ()

@end

@implementation HYMessageController

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
