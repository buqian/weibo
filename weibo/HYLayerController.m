//
//  HYLayerController.m
//  weibo
//
//  Created by bala on 6/12/15.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYLayerController.h"

@interface HYLayerController ()
@property (weak, nonatomic) IBOutlet UIView *layerView1;
@property (weak, nonatomic) IBOutlet UIView *layerView2;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;

@property (nonatomic, strong) CALayer *layer;
@property (nonatomic, strong) CALayer *doorLayer;

- (IBAction)view2Click:(id)sender;

@end

@implementation HYLayerController

@synthesize layerView1;
@synthesize layerView2;
@synthesize imageView;
@synthesize layer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.layerView1.layer.cornerRadius = 20.0f;
    self.layerView2.layer.cornerRadius = 20.0f;
    
    //add a border to our layers
    self.layerView1.layer.borderWidth = 5.0f;
    self.layerView2.layer.borderWidth = 5.0f;
    
    //add a shadow to layerView1
    self.layerView1.layer.shadowOpacity = 0.5f;
    self.layerView1.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.layerView1.layer.shadowRadius = 5.0f;
    
    //add same shadow to shadowView (not layerView2)
    self.shadowView.layer.shadowOpacity = 0.5f;
    self.shadowView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.shadowView.layer.shadowRadius = 5.0f;
    self.shadowView.layer.cornerRadius = self.layerView2.layer.cornerRadius;
    
    //enable clipping on the second layer
    self.layerView2.layer.masksToBounds = YES;
    
    imageView.layer.cornerRadius = self.imageView.frame.size.width * 0.5;
    imageView.layer.shadowOpacity = 0.5;
    imageView.layer.shadowOffset = CGSizeZero;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectInset(self.imageView.bounds, -5, -5));
    imageView.layer.shadowPath = path;
    CGPathRelease(path);
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.imageView2.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"lucky_lots_tab_highlighted0"];
    maskLayer.contentsGravity = kCAGravityResizeAspect;
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    
    //apply mask to image layer￼
    self.imageView2.layer.mask = maskLayer;
    
    UIImage *image = [UIImage imageNamed:@"LuckyMidPressed"];
    self.view1.layer.contents = (__bridge id _Nullable)(image.CGImage);
//    self.view1.layer.contentsGravity = kCAGravityCenter;
//    maskLayer.contentsScale = [UIScreen mainScreen].scale;
//    self.view1.layer.contentsCenter = CGRectMake(0.3, 0.3, 0.4, 0.4);
    CGAffineTransform transfrom = CGAffineTransformIdentity;
    transfrom.c = 2;
    transfrom.b = 0;
    transfrom.a = 1;
    transfrom.d = 1;
//    transfrom.tx = 100;
    self.view1.layer.affineTransform = transfrom;
    
    for (int i = 0; i < 10; i ++) {
        u_int32_t a = arc4random();
        u_int32_t b = INT_MAX;
//        NSLog(@"%u -- %u -- %f", a, b, a / (float)b);
    }
    
//    [layer.presentationLayer ?: layer valueForKeyPath:animation.keyPath];
//    [self.layerView1.layer.presentationLayer ? nil : layerView1.layer valueForKeyPath:@""];
    
    layer = [CALayer layer];
    layer.frame = self.view2.bounds;
    layer.backgroundColor = [UIColor blueColor].CGColor;
    
    [self.view2.layer addSublayer:layer];
    
//    
//    self.doorLayer = [CALayer layer];
//    self.doorLayer.frame = CGRectMake(0, 0, 128, 256);
//    self.doorLayer.position = CGPointMake(150 - 64, 150);
//    self.doorLayer.anchorPoint = CGPointMake(0, 0.5);
////    self.doorLayer.contents = (__bridge id)[UIImage imageNamed:@"Door.png"].CGImage;
//    self.doorLayer.backgroundColor = [UIColor blueColor].CGColor;
//    [self.view2.layer addSublayer:self.doorLayer];
//    //apply perspective transform
//    CATransform3D perspective = CATransform3DIdentity;
//    perspective.m34 = -1.0 / 500.0;
//    self.view2.layer.sublayerTransform = perspective;
//    //add pan gesture recognizer to handle swipes
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
//    [pan addTarget:self action:@selector(pan:)];
//    [self.view addGestureRecognizer:pan];
//    //pause all layer animations
//    self.doorLayer.speed = 0.0;
//    //apply swinging animation (which won't play because layer is paused)
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"transform.rotation.y";
//    animation.toValue = @(-M_PI_2);
//    animation.duration = 1.0;
//    [self.doorLayer addAnimation:animation forKey:nil];
    
//    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
//    function = [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.75 :1];
//    //get control points
//    CGPoint controlPoint1, controlPoint2;
//    float c1[2];
//    float c2[2];
//    
//    [function getControlPointAtIndex:1 values:c1];
//    [function getControlPointAtIndex:2 values:c2];
//    HYLogObj(NSStringFromCGPoint(controlPoint1));
//    HYLogObj(NSStringFromCGPoint(controlPoint2));
//    
//    UIBezierPath *path1 = [[UIBezierPath alloc] init];
//    [path1 moveToPoint:CGPointZero];
////    [path1 addCurveToPoint:CGPointMake(1, 1)
////            controlPoint1:controlPoint1 controlPoint2:controlPoint2];
//    [path1 addCurveToPoint:CGPointMake(1, 1)
//             controlPoint1:CGPointMake(c1[0], c1[1]) controlPoint2:CGPointMake(c2[0], c2[1])];
//    //scale the path up to a reasonable size for display
//    [path1 applyTransform:CGAffineTransformMakeScale(200, 200)];
//    //create shape layer
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.strokeColor = [UIColor redColor].CGColor;
//    shapeLayer.fillColor = [UIColor clearColor].CGColor;
//    shapeLayer.lineWidth = 4.0f;
//    shapeLayer.path = path1.CGPath;
//    [self.view2.layer addSublayer:shapeLayer];
//    //flip geometry so that 0,0 is in the bottom-left
//    self.view2.layer.geometryFlipped = YES;
    
    for (int j = 0; j < 10; j ++) {
        double i = rand();
        double b = INT_MAX;
        NSLog(@"%f, %f, %f", i, b, i / b);

    
    }
}
- (void)pan:(UIPanGestureRecognizer *)pan
{
    //get horizontal component of pan gesture
    CGFloat x = [pan translationInView:self.view].x;
    //convert from points to animation duration //using a reasonable scale factor
    x /= 200.0f;
    //update timeOffset and clamp result
    CFTimeInterval timeOffset = self.doorLayer.timeOffset;
    timeOffset = MIN(0.999, MAX(0.0, timeOffset - x));
    self.doorLayer.timeOffset = timeOffset;
    //reset pan gesture
    [pan setTranslation:CGPointZero inView:self.view];
}


- (IBAction)view2Click:(id)sender {
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
//    
//    anim.toValue = (__bridge id _Nullable)([UIColor redColor].CGColor);
//    anim.duration = 1;
//    anim.delegate = self;
//    [layer addAnimation:anim forKey:nil];
    
    self.view2.center = CGPointMake(150, 32);
    //create keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 2.0;
    animation.delegate = self;
    animation.values = @[
                         [NSValue valueWithCGPoint:CGPointMake(150, 32)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 140)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 220)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 250)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)]
                         ];
    
    animation.timingFunctions = @[
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]
                                  ];
    
    animation.keyTimes = @[@0.0, @0.3, @0.5, @0.7, @0.8, @0.9, @0.95, @1.0];
    //apply animation
    self.view2.layer.position = CGPointMake(150, 268);
    [self.view2.layer addAnimation:animation forKey:nil];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
    layer.backgroundColor = [UIColor redColor].CGColor;
    [CATransaction commit];
}
@end
