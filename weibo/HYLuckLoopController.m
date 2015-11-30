//
//  HYLuckLoopController.m
//  weibo
//
//  Created by bala on 30/11/15.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYLuckLoopController.h"
#import "HYLuckLoopView.h"

@interface HYLuckLoopController ()

@property (weak, nonatomic) IBOutlet HYLuckLoopView *luckyView;

- (IBAction)btnClick:(id)sender;

@end

@implementation HYLuckLoopController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnClick:(id)sender {
    [self.luckyView startChoose];
}
@end
