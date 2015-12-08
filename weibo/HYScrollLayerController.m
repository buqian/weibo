//
//  HYScrollLayerController.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/8.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYScrollLayerController.h"
#import "HYScrollView.h"

@interface HYScrollLayerController ()
- (IBAction)goBack:(id)sender;
@property (weak, nonatomic) IBOutlet HYScrollView *scrollView;

@end

@implementation HYScrollLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
