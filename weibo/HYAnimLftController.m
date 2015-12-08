//
//  HYAnimLftController.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/8.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYAnimLftController.h"

@interface HYAnimLftController ()
- (IBAction)goBack:(id)sender;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *faces;
@property (weak, nonatomic) IBOutlet UIView *contanerView;
@property (nonatomic, assign) CGPoint lastPoint;
- (IBAction)threeClick:(id)sender;


@end

@implementation HYAnimLftController

- (void)addFace:(UIView *)face transform:(CATransform3D)transform
{
    [self.contanerView addSubview:face];
    CGSize size = self.contanerView.frame.size;
    face.center = CGPointMake(size.width * 0.5, size.height * 0.5);
    
    face.layer.transform = transform;
}

- (CGFloat)calcAnglePoint1:(CGPoint)p1 point2:(CGPoint)p2 point3:(CGPoint)p3
{
    CGFloat ma_x = p1.x - p2.x;
    CGFloat ma_y = p1.y - p2.y;
    CGFloat mb_x = p3.x - p2.x;
    CGFloat mb_y = p3.y - p2.y;
    CGFloat v1 = (ma_x * mb_x) + (ma_y * mb_y);
    CGFloat ma_val = sqrt(ma_x * ma_x + ma_y * ma_y);
    CGFloat mb_val = sqrt(mb_x * mb_x + mb_y * mb_y);
    CGFloat cosM = v1 / (ma_val * mb_val);
    CGFloat angle = acos(cosM) * 180 / M_PI;
    return angle;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _lastPoint = [touches.anyObject locationInView:self.view];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [touches.anyObject locationInView:self.view];
    CATransform3D pre = self.contanerView.layer.sublayerTransform;
    pre = CATransform3DRotate(pre, (_lastPoint.y - point.y) / 180 * M_PI, 1, 0, 0);
    pre = CATransform3DRotate(pre, (point.x - _lastPoint.x) / 180 * M_PI, 0, 1, 0);
    self.contanerView.layer.sublayerTransform = pre;
    _lastPoint = point;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CATransform3D pre = CATransform3DIdentity;
    pre.m34 = -1 / 500.0;
    self.contanerView.layer.sublayerTransform = pre;
    
    CATransform3D transform = CATransform3DIdentity;
    
    [self addFace:_faces[0] transform:CATransform3DMakeTranslation(0, 0, 50)];
    
    transform = CATransform3DMakeTranslation(50, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);

    [self addFace:_faces[1] transform:transform];
    
    transform = CATransform3DMakeTranslation(0, -50, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    
    [self addFace:_faces[2] transform:transform];
    
    transform = CATransform3DMakeTranslation(0, 50, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    
    [self addFace:_faces[3] transform:transform];
    
    transform = CATransform3DMakeTranslation(-50, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:_faces[4] transform:transform];
    
    transform = CATransform3DMakeTranslation(0, 0, -50);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:_faces[5] transform:transform];
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)threeClick:(id)sender {
    HYLogFun;
}
@end
