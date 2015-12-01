//
//  HYChooseNumView.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/1.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYChooseNumView.h"

#define Stap 10

@interface HYChooseNumView ()

@property (nonatomic, strong) UIBezierPath *path;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) CAShapeLayer *shapeLayer2;

@property (nonatomic, strong) CAShapeLayer *currentShapeLayer;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HYChooseNumView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lucky_birthday_yellowcircle"]];
        view.bounds = CGRectMake(0, 0, 15, 18);
        view.center = CGPointMake(57, 21.5);
        [self addSubview:view];
        self.imageView = view;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(57, 21.5)];
        [path addLineToPoint:CGPointMake(262, 21.5)];
        [path addLineToPoint:CGPointMake(277.5, 40)];
        [path addLineToPoint:CGPointMake(263, 58)];
        [path addLineToPoint:CGPointMake(57, 58)];
        [path addLineToPoint:CGPointMake(42, 40)];
        [path closePath];
        self.path = path;
        
        //创建出CAShapeLayer
        CAShapeLayer *shapeLayer = [self createShapeLayerWithPath:path];
        //添加并显示
        [self.layer addSublayer:shapeLayer];
        self.shapeLayer = shapeLayer;
        
        self.currentShapeLayer = self.shapeLayer;
        
        shapeLayer = [self createShapeLayerWithPath:path];
        [self.layer addSublayer:shapeLayer];
        self.shapeLayer2 = shapeLayer;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(run) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
    return self;
}

- (CAShapeLayer *)createShapeLayerWithPath:(UIBezierPath *)path
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;//设置shapeLayer的尺寸和位置
    shapeLayer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    
    //设置线条的宽度和颜色
    shapeLayer.lineWidth = 3.0f;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.strokeColor = HYColor(252, 255, 155).CGColor;
    shapeLayer.opacity = 0.4;
    
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 0;
    
    shapeLayer.path = path.CGPath;
    
    return shapeLayer;
}

- (void)run
{
    CAShapeLayer *shapeLayer = self.currentShapeLayer;
    CAShapeLayer *shapeLayer2 = self.currentShapeLayer == self.shapeLayer ? self.shapeLayer2 : self.shapeLayer;
    if(shapeLayer.strokeEnd > 0.02 && ![self.imageView.layer.animationKeys containsObject:@"yellowrun"])
    {
        [self.imageView.layer addAnimation:[self getAnimation] forKey:@"yellowrun"];
    }
    if(shapeLayer.strokeEnd - shapeLayer.strokeStart < 0.15)
    {
        shapeLayer.strokeEnd = shapeLayer.strokeEnd + (0.1 / Stap);
        return;
    }
    
    shapeLayer.strokeStart = shapeLayer.strokeStart + (0.1 / Stap);
    shapeLayer.strokeEnd = shapeLayer.strokeEnd + (0.1 / Stap);
    
    if(shapeLayer.strokeEnd >= 1 && shapeLayer.strokeStart >= 1)
    {
        self.currentShapeLayer = shapeLayer2;
        shapeLayer.strokeStart = 0;
        shapeLayer.strokeEnd = 0;
        [shapeLayer removeFromSuperlayer];
        shapeLayer2.strokeEnd = shapeLayer2.strokeStart + 0.15;
    }
    else if(shapeLayer.strokeEnd >= 1.0)
    {
        if(shapeLayer2.superlayer == nil)
        {
            [self.layer addSublayer:shapeLayer2];
        }
        shapeLayer2.strokeEnd = shapeLayer.strokeEnd - 1;
    }
}

- (CAAnimation *)getAnimation
{
    
    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animation];
    keyAnima.keyPath = @"position";

    keyAnima.path = [self.path CGPath];
    
    keyAnima.calculationMode = kCAAnimationPaced;
    keyAnima.removedOnCompletion=NO;
    keyAnima.fillMode=kCAFillModeForwards;
    keyAnima.duration=5.0;
    keyAnima.repeatCount = MAXFLOAT;

    return keyAnima;
}

- (void)stopAnimationChangeImage
{
    [self.imageView.layer removeAllAnimations];
    self.imageView.image = nil;
    [self.timer invalidate];
    self.timer = nil;
    self.shapeLayer.lineWidth = 0;
    self.shapeLayer2.lineWidth = 0;
    
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 0;
    
    self.shapeLayer2.strokeStart = 0;
    self.shapeLayer2.strokeEnd = 0;
}

- (void)startAnimationChangeImage
{
    self.imageView.image = [UIImage imageNamed:@"lucky_birthday_yellowcircle"];
    self.imageView.center = CGPointMake(57, 21.5);
    
    self.shapeLayer.lineWidth = 3.0;
    self.shapeLayer2.lineWidth = 3.0;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(run) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

@end
