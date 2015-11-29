//
//  HYGifController.m
//  weibo
//
//  Created by bala on 29/11/15.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYGifController.h"
#import "UIImage+GIF.h"

@interface HYGifController () <UIScrollViewDelegate>

@end

@implementation HYGifController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.webView.scrollView.scrollEnabled = NO;
//    self.webView.scrollView.contentInset = UIEdgeInsetsMake(-64, 0, -50, 0);
    self.webView.scrollView.delegate = self;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"sleep" withExtension:@"jpg"];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    [self showGif];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
    
    self.gifImageView.gifPath = [[NSBundle mainBundle] pathForResource:@"sleep" ofType:@"jpg"];
    [self.gifImageView addGestureRecognizer:recognizer];
    
}

-(void)imageViewTap:(UITapGestureRecognizer *)recognizer
{
    if(self.gifImageView.isPlaying)
    {
        [self.gifImageView stopGIF];
    }
    else
    {
        [self.gifImageView startGIF];
    }
}

-(void)showGif
{
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sleep" ofType:@"jpg"]];
    UIImage *image = [UIImage sd_animatedGIFWithData:data];
    self.imageView.image = image;
    
//    [self.imageView setAnimationImages:images];
//    
//    [self.imageView setAnimationDuration:duration];
//    [self.imageView setAnimationRepeatCount:0];
//    [self.imageView startAnimating];
}

@end
