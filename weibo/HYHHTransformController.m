//
//  HYHHTransformController.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/8.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYHHTransformController.h"

@interface HYHHTransformController ()
@property (weak, nonatomic) IBOutlet UIView *redView;
- (IBAction)goBack:(id)sender;
- (IBAction)transformClick:(id)sender;

@end

@implementation HYHHTransformController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)transformClick:(id)sender {
    CGAffineTransform transform = CGAffineTransformIdentity; //create a new transform
    transform = CGAffineTransformScale(transform, 0.5, 0.5); //scale by 50%
    transform = CGAffineTransformRotate(transform, M_PI / 180.0 * 30.0); //rotate by 30 degrees
    transform = CGAffineTransformTranslate(transform, 200, 0);
    self.redView.layer.affineTransform = transform;
}
@end
