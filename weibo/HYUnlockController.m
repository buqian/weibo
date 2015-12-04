//
//  HYUnlockController.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/4.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYUnlockController.h"
#import "HYUnlockButton.h"
#import "HYUnlockView.h"



@interface HYUnlockController () <HYUnlockViewDelegate>
@property (strong, nonatomic) IBOutlet HYUnlockView *unlockView;

@end

@implementation HYUnlockController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.unlockView.delegate = self;
}

-(void)unlockViewCancel:(HYUnlockView *)unlockView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
