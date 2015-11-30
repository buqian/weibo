//
//  HYTableDrapController.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/30.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYTableDrapController.h"
#import "HYDrapBackgroundView.h"

@interface HYTableDrapController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) BOOL isDrap;

@end

@implementation HYTableDrapController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognizer:)];
    [self.view addGestureRecognizer:recognizer];
    
    self.isDrap = YES;
}

- (void)panRecognizer:(UIPanGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer translationInView:recognizer.view];
    CGPoint locationPoint = [recognizer locationInView:recognizer.view];
    NSLog(@"%@", NSStringFromCGPoint(point));
    if(recognizer.state == UIGestureRecognizerStateChanged) {
        if(point.y <= 0)
        {
            self.tableView.alpha = (1 / 200.0) * fabs(point.y);
            CGFloat y;
            if((self.view.bounds.size.height - self.tableView.frame.origin.y) < 60 && (self.view.bounds.size.height - self.tableView.frame.origin.y) > 40)
            {
                y = self.tableView.frame.origin.y - 0.5;
            }
//            else if(fabs(point.y) < 50)
//            {
//                y = self.view.frame.size.height + point.y;
//            }
//            else if(fabs(point.y) > 55 && self.tableView.frame.origin.y < locationPoint.y)
//            {
//                y = point.y + 5;
//            }
//            else if(self.tableView.frame.origin.y >= locationPoint.y)
//            {
//                y = self.view.frame.size.height + point.y;
//            }
            else
            {
                y = self.view.frame.size.height + point.y;
            }
            self.tableView.frame = CGRectMake(0, y, self.tableView.bounds.size.width, self.tableView.bounds.size.height);
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        if(self.tableView.frame.origin.y < self.view.frame.size.height - 200)
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.tableView.frame = CGRectMake(0, 64, self.tableView.bounds.size.width, self.tableView.bounds.size.height);
            }];
        }
        else
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.tableView.frame = CGRectMake(0, self.view.frame.size.height, self.tableView.bounds.size.width, self.tableView.bounds.size.height);
            }];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    HYDrapBackgroundView *view = (HYDrapBackgroundView *)self.view;
    if(view.isOK)
    {
        self.isDrap = NO;
        self.tableView.bounces = NO;
        self.tableView.frame = CGRectMake(0, fabs(scrollView.contentOffset.y) + 64, self.tableView.frame.size.width, self.tableView.frame.size.height);
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.frame = CGRectMake(0, CGRectGetMaxY(view.frame), self.tableView.frame.size.width, self.tableView.frame.size.height);
        } completion:^(BOOL finished) {
            self.tableView.bounces = YES;
            self.isDrap = YES;
            view.isOK = NO;
        }];
    }
//    self.tableView.contentInset = UIEdgeInsetsMake(scrollView.contentOffset.y, 0, 0, 0);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.isDrap)
    {
        HYDrapBackgroundView *view = (HYDrapBackgroundView *)self.view;
        view.offsetY = scrollView.contentOffset.y;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = @"com.weibo.table.drawstyle";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld --- %ld", indexPath.section, indexPath.row];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

@end
