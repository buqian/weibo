//
//  HYStateBarShowHideController.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/3.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYStateBarShowHideController.h"
#import "HYGIFImageView.h"

@interface HYStateBarShowHideController ()
@property (weak, nonatomic) IBOutlet HYGIFImageView *gifView;
- (IBAction)returnClick:(id)sender;
- (IBAction)showClick:(id)sender;
- (IBAction)hideClick:(id)sender;
@property (nonatomic, assign) BOOL isShow;

@end

@implementation HYStateBarShowHideController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gifView.gifPath = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"gif"];
    self.gifView.layer.borderColor = [UIColor blackColor].CGColor;
    self.gifView.layer.borderWidth = 2;
    self.gifView.layer.cornerRadius = 5;
    
    
    self.isShow = NO;
    [self setNeedsStatusBarAppearanceUpdate];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (IBAction)returnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)prefersStatusBarHidden
{
    return self.isShow;
}

- (IBAction)showClick:(id)sender {
    self.isShow = NO;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (IBAction)hideClick:(id)sender {
    self.isShow = YES;
    [self setNeedsStatusBarAppearanceUpdate];
}
@end
