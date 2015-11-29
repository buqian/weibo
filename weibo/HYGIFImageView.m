//
//  HYGIFImageView.m
//  weibo
//
//  Created by bala on 29/11/15.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYGIFImageView.h"
#import <ImageIO/ImageIO.h>

@interface HYGIFImageView ()

@property (nonatomic, assign) size_t index;

@property (nonatomic, assign) size_t frameCount;

@property (nonatomic, assign) CGImageSourceRef sourceRef;

@property (nonatomic, assign) double timestamp;

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation HYGIFImageView

-(CADisplayLink *)displayLink
{
    if(nil == _displayLink)
    {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(play)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        _displayLink.paused = YES;
    }
    return _displayLink;
}

-(void)dealloc
{
    if (self.sourceRef)
    {
        CFRelease(self.sourceRef);
        self.sourceRef = nil;
    }
    if(self.displayLink)
    {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

-(void)setGifPath:(NSString *)gifPath
{
    _gifPath = gifPath;
    [self setupGIF];
    [self startGIF];
}

-(void)setGifData:(NSData *)gifData
{
    _gifData = gifData;
    [self setupGIF];
    [self startGIF];
}

- (void)setupGIF
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            if ((self.gifData || self.gifPath)) {
                CGImageSourceRef gifSourceRef;
                if (self.gifData) {
                    gifSourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)(self.gifData), NULL);
                }else{
                    gifSourceRef = CGImageSourceCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:self.gifPath], NULL);
                }
                if (!gifSourceRef) {
                    return;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.sourceRef = gifSourceRef;
                    self.frameCount = CGImageSourceGetCount(gifSourceRef);
                });
            }
    });
}

- (void)startGIF
{
    self.displayLink.paused = NO;
}

- (void)stopGIF
{
    self.displayLink.paused = YES;
}

-(BOOL)isPlaying
{
    return !self.displayLink.paused;
}

-(CGSize)imageSize
{
    if(!self.sourceRef)
    {
        return CGSizeZero;
    }
    CGSize size;
    CGImageRef ref = CGImageSourceCreateImageAtIndex(self.sourceRef, 0, NULL);
    size.width = CGImageGetWidth(ref);
    size.height = CGImageGetHeight(ref);
    CGImageRelease(ref);
    return size;
}

- (void)play{
    float nextFrameDuration = [self frameDurationAtIndex:self.index == self.frameCount - 1? 0 : self.index];
    if (self.timestamp < nextFrameDuration) {
        self.timestamp += self.displayLink.duration;
        return;
    }
    self.index ++;
    self.index = self.index % self.frameCount;
    CGImageRef ref = CGImageSourceCreateImageAtIndex(self.sourceRef, self.index, NULL);
    self.layer.contents = (__bridge id)(ref);
    CGImageRelease(ref);
    self.timestamp = 0;
}

- (float)frameDurationAtIndex:(size_t)index{
    CFDictionaryRef dictRef = CGImageSourceCopyPropertiesAtIndex(self.sourceRef, index, NULL);
    NSDictionary *dict = (__bridge NSDictionary *)dictRef;
    NSDictionary *gifDict = (dict[(NSString *)kCGImagePropertyGIFDictionary]);
    NSNumber *unclampedDelayTime = gifDict[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    NSNumber *delayTime = gifDict[(NSString *)kCGImagePropertyGIFDelayTime];
    CFRelease(dictRef);
    if (unclampedDelayTime.floatValue) {
        return unclampedDelayTime.floatValue;
    }else if (delayTime.floatValue) {
        return delayTime.floatValue;
    }else{
        return 0.1f;
    }
}

@end
