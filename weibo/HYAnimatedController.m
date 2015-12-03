//
//  HYAnimatedController.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/3.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYAnimatedController.h"
#import "HYGIFImageView.h"
#import "FLAnimatedImageView.h"

@interface HYAnimatedController ()
@property (weak, nonatomic) IBOutlet HYGIFImageView *gifView;
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *animatedView;
- (IBAction)goback:(id)sender;

@end

@implementation HYAnimatedController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)goback:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
