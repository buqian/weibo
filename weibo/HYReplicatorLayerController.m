//
//  HYReplicatorLayerController.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/8.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYReplicatorLayerController.h"

@interface HYReplicatorLayerController ()
- (IBAction)goBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *containerView1;
@property (weak, nonatomic) IBOutlet UIView *containerView2;

@end

@implementation HYReplicatorLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupContainerView1];
    
    
    [self setupContainerView2];
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupContainerView2
{
//    CAReplicatorLayer *layer = [CAReplicatorLayer layer];;
//    layer.instanceCount = 2;
//    
//    //move reflection instance below original and flip vertically
//    CATransform3D transform = CATransform3DIdentity;
//    CGFloat verticalOffset = self.bounds.size.height + 2;
//    transform = CATransform3DTranslate(transform, 0, verticalOffset, 0);
//    transform = CATransform3DScale(transform, 1, -1, 0);
//    layer.instanceTransform = transform;
//    
//    //reduce alpha of reflection layer
//    layer.instanceAlphaOffset = -0.6;
}

- (void)setupContainerView1
{
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.containerView1.bounds;
    [self.containerView1.layer addSublayer:replicator];
    
    //configure the replicator
    replicator.instanceCount = 2;
    
    //apply a transform for each instance
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 100, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    //    transform = CATransform3DTranslate(transform, 0, -200, 0);
    replicator.instanceTransform = transform;
    
    //apply a color shift for each instance
    replicator.instanceBlueOffset = -0.1;
    replicator.instanceGreenOffset = -0.1;
    
    //create a sublayer and place it inside the replicator
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 100.0f, 100.0f, 100.0f);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicator addSublayer:layer];
}

@end
