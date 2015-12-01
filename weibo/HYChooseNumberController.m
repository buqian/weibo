//
//  HYChooseNumberController.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/1.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYChooseNumberController.h"

@interface HYChooseNumberController ()
@property (weak, nonatomic) IBOutlet UIImageView *right;
@property (weak, nonatomic) IBOutlet UIImageView *mid;
@property (weak, nonatomic) IBOutlet UIImageView *left;
- (IBAction)chooseClick:(id)sender;

@end
@implementation HYChooseNumberController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)chooseClick:(id)sender {
    
    [self addAnimation];
}

- (void) addAnimation
{

    CABasicAnimation *anima=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    //1.1设置动画执行时间
    anima.duration=2.0;
    //1.2修改属性，执行动画
    anima.toValue=[NSNumber numberWithFloat:M_PI * 12];
    //1.3设置动画执行完毕后不删除动画
    anima.removedOnCompletion=NO;
    //1.4设置保存动画的最新状态
    anima.fillMode=kCAFillModeForwards;
    //2.添加动画到layer
    [self.left.layer addAnimation:anima forKey:nil];
    [self.mid.layer addAnimation:anima forKey:nil];
    [self.right.layer addAnimation:anima forKey:nil];
}
@end
