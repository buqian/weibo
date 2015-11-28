//
//  HYLotteryView.m
//  weibo
//
//  Created by bala on 27/11/15.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYLotteryView.h"
#import "UIImage+ColorAtPixel.h"

#define LineWidth 10

#define kAlphaVisibleThreshold (0.1f)

@interface HYLotteryView ()

@property (nonatomic, strong) NSMutableArray<UIBezierPath *> *pathArray;

@property (nonatomic, strong) NSMutableArray *rectArray;

@property (nonatomic, strong) dispatch_queue_t queue;

@property (nonatomic, assign) unsigned long count;

@end

@implementation HYLotteryView

-(dispatch_queue_t)queue
{
    if(_queue == nil)
    {
        _queue = dispatch_queue_create("com.weibo.lottery", DISPATCH_QUEUE_SERIAL);
    }
    return _queue;
}

-(NSMutableArray<UIBezierPath *> *)pathArray
{
    if(nil == _pathArray)
    {
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}

-(NSMutableArray *)rectArray
{
    if(nil == _rectArray)
    {
        _rectArray = [NSMutableArray array];
    }
    return _rectArray;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    int x = 0;
    int y = 0;
    
    while (YES) {
        CGFloat h = LineWidth;
        if(y + h > height)
        {
            h = height - y;
        }
        while (YES) {
            CGFloat w = LineWidth;
            if(x + w > width)
            {
                w = width - x;
            }
            CGRect rect = CGRectMake(x, y, w, h);
            [self.rectArray addObject:[NSValue valueWithCGRect:rect]];
            x += LineWidth;
            if(x >= width)
            {
                break;
            }
        }
        x = 0;
        y += LineWidth;
        if(y >= height)
        {
            break;
        }
    }
    
    self.count = self.rectArray.count;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
    }
    return self;
}

-(void)checkRemoveWithPoint:(CGPoint)point
{
    CGFloat x = (int)point.x;
    CGFloat y = (int)point.y;

    if(((int)point.x % LineWidth) != 0)
    {
        x = (int)point.x / LineWidth * LineWidth;
    }
    if(((int)point.y % LineWidth) != 0)
    {
        y = (int)point.y / LineWidth * LineWidth;
    }
    [self.rectArray removeObject:[NSValue valueWithCGRect:CGRectMake(x, y, LineWidth, LineWidth)]];
    
    [self changeLabelText];
}

-(void)checkRemoveAlphaRect
{
        //获取图像
    __block UIImage *image;
    dispatch_sync(dispatch_get_main_queue(), ^{
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.imageView.image = image;
    });
    
    
    NSMutableArray *array = [NSMutableArray array];
    NSEnumerator *en = [self.rectArray objectEnumerator];
    NSValue *value;
    while (value = [en nextObject]) {
        CGRect rect = [value CGRectValue];
        CGPoint point = CGPointMake(rect.origin.x + LineWidth * 0.5, rect.origin.y + LineWidth * 0.5);
        if([self isAlphaVisibleAtPoint:point forImage:image])
        {
            [array addObject:value];
        }
    }
    
    [self.rectArray removeObjectsInArray:array];
    
    [self changeLabelText];
}

-(void)changeLabelText
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        self.label.text = [NSString stringWithFormat:@"%ld - %ld - %.2f%%", self.count, self.rectArray.count, self.rectArray.count * 100.f / self.count];
    });
}

- (BOOL)isAlphaVisibleAtPoint:(CGPoint)point forImage:(UIImage *)image
{
    UIColor *pixelColor = [image colorAtPixel:point];
    CGFloat alpha = 0.0;
    if ([pixelColor respondsToSelector:@selector(getRed:green:blue:alpha:)])
    {
        [pixelColor getRed:NULL green:NULL blue:NULL alpha:&alpha];
    }
    else
    {
        CGColorRef cgPixelColor = [pixelColor CGColor];
        alpha = CGColorGetAlpha(cgPixelColor);
    }
    return alpha < kAlphaVisibleThreshold;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint point = [touch locationInView:touch.view];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = LineWidth;
    [path moveToPoint:point];
    
    [self.pathArray addObject:path];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
 
    UITouch *touch = touches.anyObject;
    
    CGPoint point = [touch locationInView:touch.view];
    
    UIBezierPath *path = self.pathArray.lastObject;

    [path addLineToPoint:point];

    
    [self setNeedsDisplay];

    dispatch_async(self.queue, ^{
        [self checkRemoveWithPoint:point];
    });
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
    
    dispatch_async(self.queue, ^{
        [self checkRemoveAlphaRect];
    });
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor colorWithRed:0.855 green:0.840 blue:0.849 alpha:1.000] set];
    CGContextFillRect(context, self.bounds);

    CGContextSetBlendMode(context, kCGBlendModeClear);
    
    for (UIBezierPath *path in self.pathArray) {
        [path stroke];
    }
    
}

@end
