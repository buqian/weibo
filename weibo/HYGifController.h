//
//  HYGifController.h
//  weibo
//
//  Created by bala on 29/11/15.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYGIFImageView.h"

@interface HYGifController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet HYGIFImageView *gifImageView;


@end
