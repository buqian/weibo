//
//  HYHCollectionController.m
//  weibo
//
//  Created by bala on 11/12/15.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYHCollectionController.h"
#import "HYCollectionViewFlowLayout.h"

@interface HYHCollectionController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) HYCollectionViewFlowLayout *layout;

@end

@implementation HYHCollectionController

@synthesize collectionView;
@synthesize layout;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    layout = (HYCollectionViewFlowLayout *)collectionView.collectionViewLayout;
    collectionView.showsHorizontalScrollIndicator = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = YES;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

@end
