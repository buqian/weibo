//
//  HYJKCController.m
//  weibo
//
//  Created by bala on 27/11/15.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYJKCController.h"
#import "HYLotteryView.h"

@interface HYJKCController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet HYLotteryView *planView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation HYJKCController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"即开彩票";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(sure)];
    
    self.planView.imageView = self.imageView;
    
    self.planView.label = self.label;
    
//    NSMutableArray *array = [NSMutableArray array];
//    [array addObject:[NSValue valueWithCGRect:CGRectMake(10, 10, 10, 10)]];
//    NSLog(@"%ld", array.count);
//    [array removeObject:[NSValue valueWithCGRect:CGRectMake(10, 10, 10, 10)]];
//    NSLog(@"%ld", array.count);
}

-(void)sure
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
