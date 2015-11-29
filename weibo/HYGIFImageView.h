//
//  HYGIFImageView.h
//  weibo
//
//  Created by bala on 29/11/15.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYGIFImageView : UIImageView

@property (nonatomic, copy) NSString *gifPath;
@property (nonatomic, strong) NSData *gifData;

- (void)startGIF;
- (void)stopGIF;
-(BOOL)isPlaying;
-(CGSize)imageSize;
@end
