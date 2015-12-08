//
//  HYGradientLayerController.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/8.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYGradientLayerController.h"

@interface HYGradientLayerController ()
- (IBAction)goBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation HYGradientLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:gradientLayer];
    
    //set gradient colors
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id) [UIColor yellowColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
    
    //set locations
    gradientLayer.locations = @[@0.0, @0.25, @0.5];
    
    //set gradient start and end points
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
