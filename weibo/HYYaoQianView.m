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
            
//            [self addSubview:view];
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
    }
    return self;
}

- (void)yqBtnClick
{
    [self startYaoAnimation];
}

-(void)startYaoAnimation
{
    [self startFanAnimation];
//    if(self.index > 5)
//    {
//        self.index = 0;
//        return;
//    }
//    [UIView animateWithDuration:5 animations:^{
////        CGRect frame = self.yqBtn.frame;
////        if(self.index %2 == 0)
////        {
////            frame.origin.y += 15;
////        }
////        else
////        {
////            frame.origin.y -= 15;
////        }
////        self.yqBtn.frame = frame;
////        CGFloat angle;
////        if(self.index %2 == 0)
////        {
////            angle = -M_PI_4 * 0.5;
////        }
////        else
////        {
////            angle = M_PI_4 * 0.5;
////        }
////        self.yqBtn.layer.transform = CATransform3DRotate(self.yqBtn.layer.transform, M_2_PI, 0, 0, 1);
////        self.index ++;
//    } completion:^(BOOL finished) {
//        [self startYaoAnimation];
//    }];
}

- (void)startFanAnimation
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.x"];
    NSNumber *avalue1 = [NSNumber numberWithFloat:0];
    NSNumber *avalue2 = [NSNumber numberWithFloat:-M_PI_4 * 0.5];
    NSNumber *avalue3 = [NSNumber numberWithFloat:0];
    anim.values = @[avalue1, avalue2, avalue3];
//    anim.duration = 0.5;
//    anim.repeatCount = 5;
    
    CAKeyframeAnimation *anim2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *a2value1 = [NSValue valueWithCGPoint:self.yqBtn.layer.position];
    NSValue *a2value2 = [NSValue valueWithCGPoint:CGPointMake(self.yqBtn.layer.position.x, self.yqBtn.layer.position.y + 20)];
    NSValue *a2value3 = [NSValue valueWithCGPoint:self.yqBtn.layer.position];
    anim2.values = @[a2value1, a2value2, a2value3];
//    anim2.duration = 0.5;
//    anim2.repeatCount = 5;
    
    CAKeyframeAnimation *anim3 = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    NSValue *a3value1 = [NSNumber numberWithFloat:1];
    NSValue *a3value2 = [NSNumber numberWithFloat:1.05];
    NSValue *a3value3 = [NSNumber numberWithFloat:1];
    anim3.values = @[a3value1, a3value2, a3value3];
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[anim, anim2, anim3];
    group.duration = 0.5;
    group.repeatCount = 5;
    [self.yqBtn.layer addAnimation:group forKey:nil];
}

@end
