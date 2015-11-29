//
//  HYImageLoopController.m
//  weibo
//
//  Created by bala on 29/11/15.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYImageLoopController.h"

@interface HYImageLoopController () <UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *collectionPc;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSTimer *scrollTimer;
@property (nonatomic, strong) NSTimer *collectionTimer;

@property (nonatomic, assign) int row;

@property (nonatomic, assign) CGFloat offset;

@end

@implementation HYImageLoopController

-(NSArray *)imageArray
{
    if(_imageArray == nil)
    {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 1; i <6; i ++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"g-%d.jpg", i]];
            [array addObject:image];
        }
        _imageArray = array;
    }
    return _imageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScrollView];
    
    [self setupCollectionView];
}

#pragma mark collectionView
-(void)setupCollectionView
{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:NSClassFromString(@"UICollectionViewCell") forCellWithReuseIdentifier:@"com.imageloop.collectionview"];
    self.collectionPc.numberOfPages = self.imageArray.count;
    NSIndexPath *path = [NSIndexPath indexPathForItem:2500 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    self.collectionTimer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(changeCollectionImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.collectionTimer forMode:NSDefaultRunLoopMode];
}


-(void)changeCollectionImage
{
    int index = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width;
    NSIndexPath *path = [NSIndexPath indexPathForItem:index + 1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"com.imageloop.collectionview" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    imageView.image = self.imageArray[indexPath.row % self.imageArray.count];
    [cell.contentView addSubview:imageView];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark scrollView
-(void)setupScrollView
{
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    
    CGFloat scrollWidth = self.scrollView.bounds.size.width;
    CGFloat scrollHeight = self.scrollView.bounds.size.height;
    unsigned long count = self.imageArray.count;
    self.scrollView.contentSize = CGSizeMake(scrollWidth * count, scrollHeight);
    for (int i = 0; i < count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.imageArray[i]];
        imageView.frame = CGRectMake(i * scrollWidth, 0, scrollWidth, scrollHeight);
        [self.scrollView addSubview:imageView];
    }
    
    self.pageControl.numberOfPages = count;
    
    _scrollTimer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.scrollTimer forMode:NSDefaultRunLoopMode];
}

-(void)changeImage
{
    CGFloat scrollWidth = self.scrollView.bounds.size.width;
    self.offset += scrollWidth;
    if(self.offset >= self.scrollView.contentSize.width)
    {
        self.offset = 0;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentOffset = CGPointMake(self.offset, 0);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([scrollView isKindOfClass:[UICollectionView class]])
    {
        CGFloat scrollWidth = self.collectionView.bounds.size.width;
        self.collectionPc.currentPage = lround(self.collectionView.contentOffset.x / scrollWidth) % self.imageArray.count;
    }
    else
    {
        CGFloat scrollWidth = self.scrollView.bounds.size.width;
        self.pageControl.currentPage = lround(self.scrollView.contentOffset.x / scrollWidth);
    }
}

@end
