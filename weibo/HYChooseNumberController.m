//
//  HYChooseNumberController.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/1.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYChooseNumberController.h"
#import "HYChooseButton.h"
#import "HYChooseNumView.h"

@interface HYChooseNumberController ()
@property (weak, nonatomic) IBOutlet HYChooseNumView *luckyView;
@property (weak, nonatomic) IBOutlet HYChooseButton *chooseBtn;
@property (weak, nonatomic) IBOutlet HYChooseButton *cancelBtn;
@property (weak, nonatomic) IBOutlet HYChooseButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIImageView *right;
@property (weak, nonatomic) IBOutlet UIImageView *mid;
@property (weak, nonatomic) IBOutlet UIButton *yearBtn;
@property (weak, nonatomic) IBOutlet UIButton *monthBtn;
@property (weak, nonatomic) IBOutlet UIButton *dayBtn;
@property (weak, nonatomic) IBOutlet UIImageView *left;
- (IBAction)chooseClick:(id)sender;
- (IBAction)cancelClick:(id)sender;

@end
@implementation HYChooseNumberController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIFont *font = [UIFont fontWithName:@"329-CAI978" size:30];
    
    self.yearBtn.titleLabel.font = font;
    self.monthBtn.titleLabel.font = font;
    self.dayBtn.titleLabel.font = font;
}

- (IBAction)chooseClick:(id)sender {
    
    [self.luckyView stopAnimationChangeImage];
    [self.chooseBtn setBackgroundImage:[UIImage imageNamed:@"lucky_birthday_selectbutton_disable"] forState:UIControlStateNormal];
    [self addAnimation];
}

- (IBAction)cancelClick:(id)sender {
    [self.chooseBtn setBackgroundImage:[UIImage imageNamed:@"lucky_birthday_selectbutton_normal"] forState:UIControlStateNormal];
    [UIView animateWithDuration:1 animations:^{
        self.chooseBtn.alpha = 1;
        self.cancelBtn.alpha = 0;
        self.sureBtn.alpha = 0;
    } completion:^(BOOL finished) {
        [self.luckyView startAnimationChangeImage];
    }];
}

- (void) addAnimation
{

    CABasicAnimation *anima=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    //1.1设置动画执行时间
    anima.duration=2.0;
    //1.2修改属性，执行动画
    anima.toValue=[NSNumber numberWithFloat:M_PI * 12];
    //1.3设置动画执行完毕后不删除动画
    anima.removedOnCompletion=YES;
    //1.4设置保存动画的最新状态
//    anima.fillMode=kCAFillModeForwards;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    anima.delegate = self;
    //2.添加动画到layer
    [self.left.layer addAnimation:anima forKey:nil];
    [self.mid.layer addAnimation:anima forKey:nil];
    [self.right.layer addAnimation:anima forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [UIView animateWithDuration:1 animations:^{
        self.chooseBtn.alpha = 0;
        self.cancelBtn.alpha = 1;
        self.sureBtn.alpha = 1;
    }];
}
@end
