//
//  HYYaoQianView.m
//  weibo
//
//  Created by bala on 1/12/15.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYYaoQianView.h"
#import "HYYaoQianButton.h"
#import "HYQianImageView.h"

@interface HYYaoQianView ()

@property (nonatomic, strong) NSArray *imageViewArray;

@property (nonatomic, strong) HYYaoQianButton *yqBtn;

@property (nonatomic, assign) int index;

@end

@implementation HYYaoQianView

-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
    
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSMutableArray *array = [NSMutableArray array];
        CGFloat mid = self.frame.size.width * 0.5;
        for (int i = 0; i < 50; i ++) {
            HYQianImageView *view = [[HYQianImageView alloc] initWithImage:[UIImage imageNamed:@"lucky_lots_singlelot"]];
            view.frame = CGRectMake([self getRandomNumber:mid - 45 to:mid + 25], self.frame.size.height - 175 - [self getRandomNumber:30 to:50], 31, 175);
            
            view.transform = CGAffineTransformMakeRotation(M_PI / 180 * ([self getRandomNumber:-10 to:10]));
            
            view.layer.zPosition = -1;
            
            [self addSubview:view];
            [array addObject:view];
        }
        self.imageViewArray = array;
        
        HYYaoQianButton *btn = [HYYaoQianButton buttonWithType:UIButtonTypeCustom];
        CGFloat btnH = 180;
        btn.frame = CGRectMake(0, self.frame.size.height - btnH, self.frame.size.width, btnH);
        [btn setBackgroundImage:[UIImage imageNamed:@"lucky_lots_bucket_hands"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(yqBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        self.yqBtn = btn;
        self.yqBtn.layer.zPosition = 100;
    }
    return self;
}

- (void)yqBtnClick
{
    [self startYaoAnimation];
}

-(void)startYaoAnimation
{
    [self startQianAnimation];
    [self startFanAnimation];
}

- (void)startQianAnimation
{
    unsigned long count = self.imageViewArray.count;
    for (int i = 0; i < count; i ++) {
        UIImageView *view = self.imageViewArray[i];
        int num1 = [self getRandomNumber:5 to:10];
        CGFloat position = view.layer.position.y;
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
        anim.values = @[
                         [NSNumber numberWithFloat:position],
                         [NSNumber numberWithFloat:position - num1],
                         [NSNumber numberWithFloat:position + num1],
                         [NSNumber numberWithFloat:position]
                         ];
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        anim.calculationMode = kCAAnimationPaced;
        anim.duration = 0.5;
        anim.repeatCount = 5;
        anim.removedOnCompletion = NO;
        anim.fillMode = kCAFillModeForwards;

        CAKeyframeAnimation *anim2 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        num1 = [self getRandomNumber:5 to:10];
        int num2 = [self getRandomNumber:-10 to:-5];
        CATransform3D transform = CATransform3DMakeAffineTransform(view.transform);
        anim2.values = @[
                         [NSValue valueWithCATransform3D:transform],
                         [NSValue valueWithCATransform3D:CATransform3DRotate(transform, M_PI / 180 * num1, 0, 0, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DRotate(transform, M_PI / 180 * num2, 0, 0, 1)],
                         [NSValue valueWithCATransform3D:transform]
                        ];
        anim2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        anim2.calculationMode = kCAAnimationPaced;
        anim2.duration = 0.5;
        anim2.repeatCount = 5;
        anim2.removedOnCompletion = NO;
        anim2.fillMode = kCAFillModeForwards;
        
        CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
        group.animations = @[anim, anim2];
        group.duration = 0.5;
        group.repeatCount = 5;
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeForwards;
        
        [view.layer addAnimation:group forKey:nil];
    }
}

- (void)startFanAnimation
{
 
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D o = self.yqBtn.layer.transform;
    anim.values = @[
                    [NSValue valueWithCATransform3D:o],
                    [NSValue valueWithCATransform3D:[self CATransform3DPerspect:CATransform3DMakeRotation(-M_PI / 9, 1, 0, 0) point:CGPointMake(0, 0) dis:500]],
                    [NSValue valueWithCATransform3D:[self CATransform3DPerspect:CATransform3DMakeRotation(M_PI / 18, 1, 0, 0) point:CGPointMake(0, 0) dis:500]],
                    [NSValue valueWithCATransform3D:o]
                    ];
    anim.duration = 0.5;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anim.calculationMode = kCAAnimationPaced;
    anim.repeatCount = 5;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    CAKeyframeAnimation *anim2 = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    CGFloat position = self.yqBtn.layer.position.y;
    anim2.values = @[
                     [NSNumber numberWithFloat:position],
                     [NSNumber numberWithFloat:position + 20],
                     [NSNumber numberWithFloat:position]
                     ];
    anim2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anim2.calculationMode = kCAAnimationPaced;
    anim2.duration = 0.5;
    anim2.repeatCount = 5;
    anim2.removedOnCompletion = NO;
    anim2.fillMode = kCAFillModeForwards;

    //
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.duration = 0.5;
    group.repeatCount = 5;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    group.animations = @[anim, anim2];
    
    [self.yqBtn.layer addAnimation:group forKey:nil];
}

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

//CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
//{
//    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
//    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
//    CATransform3D scale = CATransform3DIdentity;
//    scale.m34 = -1.0f/disZ;
//    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
//}
//
//CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
//{
//    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
//}

@end
