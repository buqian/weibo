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
#import "FLAnimatedImage.h"

@interface HYAnimatedController ()
@property (weak, nonatomic) IBOutlet HYGIFImageView *gifView;
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *animatedView;
@property (weak, nonatomic) IBOutlet HYGIFImageView *gifView2;
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *animatedView2;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)goback:(id)sender;

@end

@implementation HYAnimatedController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gifView.gifPath = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"gif"];
    
    self.animatedView.contentMode = UIViewContentModeScaleAspectFill;
    self.animatedView.clipsToBounds = YES;
    
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"dog" withExtension:@"gif"];
    NSData *data1 = [NSData dataWithContentsOfURL:url1];
    FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
    self.animatedView.animatedImage = animatedImage1;
    
    FLAnimatedImageView *animatedView2 = [[FLAnimatedImageView alloc] init];
    animatedView2.frame = CGRectMake(self.gifView2.frame.origin.x, CGRectGetMaxY(self.gifView2.frame) + 10, self.gifView2.frame.size.width, self.gifView2.frame.size.height);
    [self.scrollView addSubview:animatedView2];
    self.animatedView2 = animatedView2;
    
    self.gifView2.gifPath = [[NSBundle mainBundle] pathForResource:@"rock" ofType:@"gif"];
    self.gifView2.contentMode = UIViewContentModeScaleAspectFit;
    self.gifView2.clipsToBounds = YES;
    
    self.animatedView2.contentMode = UIViewContentModeScaleAspectFit;
    self.animatedView2.clipsToBounds = YES;
    
    NSURL *url2 = [[NSBundle mainBundle] URLForResource:@"rock" withExtension:@"gif"];
    NSData *data2 = [NSData dataWithContentsOfURL:url2];
    FLAnimatedImage *animatedImage2 = [FLAnimatedImage animatedImageWithGIFData:data2];
    self.animatedView2.animatedImage = animatedImage2;
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(self.animatedView2.frame) + 200);
}

- (IBAction)goback:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
