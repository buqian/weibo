//
//  HYCollectionViewFlowLayout.m
//  weibo
//
//  Created by bala on 11/12/15.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYCollectionViewFlowLayout.h"

@implementation HYCollectionViewFlowLayout



- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 获得super已经计算好的布局属性
    NSArray *array = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    // 计算collectionView最中心点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
//    NSLog(@"%ld", ((UICollectionViewLayoutAttributes *)array[0]).indexPath.row);
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:array.count];
    // 在原有布局属性的基础上，进行微调
    for (UICollectionViewLayoutAttributes *attrs in array) {
        
//        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:attrs.indexPath];

//        NSLog(@"%f", centerX);

//        HYLogObj(NSStringFromCGRect(attrs.frame));
        UICollectionViewLayoutAttributes *nAttrs = attrs.copy;
        
        CGFloat delta = ABS(nAttrs.center.x - centerX);
        
        // 根据间距值 计算 cell的缩放比例
        CGFloat scale = 1.2 - delta / self.collectionView.frame.size.width;
        
        // 设置缩放比例
        nAttrs.transform = CGAffineTransformMakeScale(scale, scale);
        [mArray addObject:nAttrs];
    }
    
    return mArray;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    
    // 获得super已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 计算collectionView最中心点的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 存放最小的间距值
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    
    // 修改原有的偏移量
    NSLog(@"%f --- %f", proposedContentOffset.x, proposedContentOffset.x + minDelta);
    proposedContentOffset.x += minDelta;
    return proposedContentOffset;
}

@end
