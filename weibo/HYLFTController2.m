//
//  HYLFTController2.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/3.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYLFTController2.h"

@interface HYLFTController2 ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;

@property (nonatomic, assign) CGFloat angle;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) BOOL isStart;


- (IBAction)click:(id)sender;
- (IBAction)hide1:(id)sender;
- (IBAction)hide2:(id)sender;
- (IBAction)hide3:(id)sender;
- (IBAction)hide4:(id)sender;
- (IBAction)stop:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)goback:(id)sender;

@end

@implementation HYLFTController2

@synthesize imageView1;
@synthesize imageView2;
@synthesize imageView3;
@synthesize imageView4;
@synthesize angle;

- (CATransform3D)CATransform3DMakePerspective:(CGPoint )center dis:(float)disZ
{
    //    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    //    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    //    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
    return scale;
}

- (CATransform3D)CATransform3DPerspect:(CATransform3D)t point:(CGPoint)center dis:(float)disZ
{
    return CATransform3DConcat(t, [self CATransform3DMakePerspective:center dis:disZ]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.imageView1.hidden = YES;
    //    self.imageView2.hidden = YES;
    //    self.imageView3.hidden = YES;
    //    self.imageView4.hidden = YES;
    
    self.isStart = NO;
}

- (void)loop
{
    angle += 5 / 180.0 * M_PI;
    //    NSLog(@"%f", angle / M_PI * 180);
    //    CATransform3D transloate = CATransform3DMakeTranslation(0, 0, 0);
    //    CATransform3D rotate = CATransform3DMakeRotation(angle, 0, 1, 0);
    //    CATransform3D mat = CATransform3DConcat(rotate, transloate);
    //    imageView1.layer.transform = [self CATransform3DPerspect:mat point:CGPointZero dis:500];
    
    //        CGFloat angle = -90;
    
    self.label.text = [NSString stringWithFormat:@"%.1f", (angle / M_PI * 180)];
    
    CATransform3D move = CATransform3DMakeTranslation(0, 0, 160);
    CATransform3D back = CATransform3DMakeTranslation(0, 0, -160);
    
    CATransform3D move25 = CATransform3DMakeTranslation(0, 0, 160);
    CATransform3D back25 = CATransform3DMakeTranslation(0, 0, -160);
    
    CATransform3D rotate0 = CATransform3DMakeRotation(-angle, 0, 1, 0);
    CATransform3D rotate1 = CATransform3DMakeRotation(M_PI_2-angle, 0, 1, 0);
    CATransform3D rotate2 = CATransform3DMakeRotation(M_PI_2*2-angle, 0, 1, 0);
    CATransform3D rotate3 = CATransform3DMakeRotation(M_PI_2*3-angle, 0, 1, 0);
    
    CATransform3D mat0 = CATransform3DConcat(CATransform3DConcat(CATransform3DMakeTranslation(0, 0, 25), rotate0), CATransform3DMakeTranslation(0, 0, -25));
    CATransform3D mat1 = CATransform3DConcat(CATransform3DConcat(move, rotate1), back);
    CATransform3D mat2 = CATransform3DConcat(CATransform3DConcat(move25, rotate2), back25);
    CATransform3D mat3 = CATransform3DConcat(CATransform3DConcat(move, rotate3), back);
    
    imageView1.layer.transform = [self CATransform3DPerspect:mat0 point:CGPointZero dis:500];
    imageView2.layer.transform = [self CATransform3DPerspect:mat1 point:CGPointZero dis:500];
    imageView3.layer.transform = [self CATransform3DPerspect:mat2 point:CGPointZero dis:500];
    imageView4.layer.transform = [self CATransform3DPerspect:mat3 point:CGPointZero dis:100];
    
}

- (IBAction)click:(id)sender {
    [self loop];
//    if(!self.isStart)
//    {
//        self.timer = [NSTimer timerWithTimeInterval:0.05 target:self selector:@selector(loop) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
//    self.isStart = YES;
//    }
}

- (IBAction)stop:(id)sender {
    if(self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
        self.isStart = NO;
    }
}

- (IBAction)hide1:(id)sender {
    self.imageView1.hidden = !self.imageView1.hidden;
}

- (IBAction)hide2:(id)sender {
    self.imageView2.hidden = !self.imageView2.hidden;
}

- (IBAction)hide3:(id)sender {
    self.imageView3.hidden = !self.imageView3.hidden;
}

- (IBAction)hide4:(id)sender {
    self.imageView4.hidden = !self.imageView4.hidden;
}



- (IBAction)goback:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self stop:nil];
    }];
}
@end
