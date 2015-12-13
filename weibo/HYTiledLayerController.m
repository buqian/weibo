//
//  HYTiledLayerController.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/8.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYTiledLayerController.h"
#import "HYTiledLayer.h"
#import "HYPrintObject.h"
#import <objc/runtime.h>

@interface HYTiledLayerController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, weak) HYTiledLayer *tileLayer;

- (IBAction)goBack:(id)sender;

@end

@implementation HYTiledLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    HYTiledLayer *tileLayer = [HYTiledLayer layer];
    CGFloat scale = [UIScreen mainScreen].scale;
    tileLayer.frame = CGRectMake(0, 0, 5120 / scale, 2880 / scale);
    tileLayer.delegate = self;
    tileLayer.contentsScale = scale;
    [self.scrollView.layer addSublayer:tileLayer];
    
    //configure the scroll view
    self.scrollView.contentSize = tileLayer.frame.size;
    
    //draw layer
    [tileLayer setNeedsDisplay];
    
    _tileLayer = tileLayer;
    
    [HYPrintObject print:[UIDevice currentDevice] ];
}

- (void)dealloc
{
    _tileLayer.delegate = nil;
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)drawLayer:(CATiledLayer *)layer inContext:(CGContextRef)ctx
{
    
    //determine tile coordinate
    CGRect bounds = CGContextGetClipBoundingBox(ctx);
    NSInteger x = floor(bounds.origin.x / (layer.tileSize.width / layer.contentsScale));
    NSInteger y = floor(bounds.origin.y / (layer.tileSize.height / layer.contentsScale));
    //load tile image
    NSString *imageName = [NSString stringWithFormat: @"House-in-Snow_%02li_%02li", (long)x, (long)y];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg" inDirectory:@"tiledlayer-image"];
    UIImage *tileImage = [UIImage imageWithContentsOfFile:imagePath];
    
    //draw tile
    UIGraphicsPushContext(ctx);
    [tileImage drawInRect:bounds];
    UIGraphicsPopContext();
}
@end
