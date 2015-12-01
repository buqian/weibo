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
    CABasicAnimation * anim = [CABasicAnimation animationWithKeyPath:@"transform"];
//    anim.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-M_PI_4, 1, 0, 0)];
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_4 * 0.5, 1, 0, 0)];
    anim.duration = 0.5;
    anim.autoreverses = YES;
    anim.repeatCount = 5;
    
    [self.yqBtn.layer addAnimation:anim forKey:nil];
}

@end
