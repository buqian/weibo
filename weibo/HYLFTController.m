//
//  HYLFTController.m
//  weibo
//
//  Created by bala on 2/12/15.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYLFTController.h"

@interface HYLFTController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
- (IBAction)click:(id)sender;

@end

@implementation HYLFTController

@synthesize imageView1;
@synthesize imageView2;
@synthesize imageView3;
@synthesize imageView4;

- (CATransform3D)CATransform3DMakePerspective:(CGPoint )center dis:(float)disZ
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

- (CATransform3D)CATransform3DPerspect:(CATransform3D)t point:(CGPoint)center dis:(float)disZ
{
    return CATransform3DConcat(t, [self CATransform3DMakePerspective:center dis:disZ]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.imageView1.hidden = YES;
    self.imageView2.hidden = YES;
    self.imageView3.hidden = YES;
    self.imageView4.hidden = YES;
    

}



- (IBAction)click:(id)sender {
    
    static float angle = 0;
    angle += 0.05f;
    NSLog(@"%f", angle / M_PI * 180);
    CATransform3D transloate = CATransform3DMakeTranslation(0, 0, 0);
    CATransform3D rotate = CATransform3DMakeRotation(angle, 0, 1, 0);
    CATransform3D mat = CATransform3DConcat(rotate, transloate);
    imageView1.layer.transform = [self CATransform3DPerspect:mat point:CGPointZero dis:500];
    
//        CGFloat angle = -90;
    
//        CATransform3D move = CATransform3DMakeTranslation(0, 0, 160);
//        CATransform3D back = CATransform3DMakeTranslation(0, 0, -160);
//    
//        CATransform3D rotate0 = CATransform3DMakeRotation(-angle, 0, 1, 0);
//        CATransform3D rotate1 = CATransform3DMakeRotation(M_PI_2-angle, 0, 1, 0);
//        CATransform3D rotate2 = CATransform3DMakeRotation(M_PI_2*2-angle, 0, 1, 0);
//        CATransform3D rotate3 = CATransform3DMakeRotation(M_PI_2*3-angle, 0, 1, 0);
//    
//        CATransform3D mat0 = CATransform3DConcat(CATransform3DConcat(move, rotate0), back);
//        CATransform3D mat1 = CATransform3DConcat(CATransform3DConcat(move, rotate1), back);
//        CATransform3D mat2 = CATransform3DConcat(CATransform3DConcat(move, rotate2), back);
//        CATransform3D mat3 = CATransform3DConcat(CATransform3DConcat(move, rotate3), back);
//    
//        imageView1.layer.transform = [self CATransform3DPerspect:mat0 point:CGPointZero dis:500];
//        imageView2.layer.transform = [self CATransform3DPerspect:mat1 point:CGPointZero dis:500];
//        imageView3.layer.transform = [self CATransform3DPerspect:mat2 point:CGPointZero dis:500];
//        imageView4.layer.transform = [self CATransform3DPerspect:mat3 point:CGPointZero dis:500];
}
@end
