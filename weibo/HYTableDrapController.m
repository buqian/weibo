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
@property (weak, nonatomic) IBOutlet HYDrapBackgroundView *eyeView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) BOOL isDrap;

@property (nonatomic, assign) CGPoint lastPoint;

@end

@implementation HYTableDrapController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognizer:)];
    [self.view addGestureRecognizer:recognizer];
    
    self.isDrap = YES;
}

- (void)panRecognizer:(UIPanGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer translationInView:recognizer.view];
    CGPoint locationPoint = [recognizer locationInView:recognizer.view];
    if(recognizer.state == UIGestureRecognizerStateChanged) {
        self.tableView.alpha = (1 / 200.0) * fabs(point.y) + 0.3;
        CGFloat y;
        if((self.view.bounds.size.height - self.tableView.frame.origin.y) < 60 && (self.view.bounds.size.height - self.tableView.frame.origin.y) > 40)
        {
            if(self.lastPoint.y > point.y)
            {
                y = self.tableView.frame.origin.y - 0.5;
            }
            else
            {
                y = self.tableView.frame.origin.y + 0.5;
            }
        }
        else if((self.view.bounds.size.height - self.tableView.frame.origin.y) > 60 && self.tableView.frame.origin.y > locationPoint.y)
        {
            y = self.view.frame.size.height + point.y;
        }
        else
        {
            if(self.lastPoint.y > point.y)
            {
                y = self.tableView.frame.origin.y - fabs(fabs(self.lastPoint.y) - fabs(point.y));
            }
            else
            {
                y = self.tableView.frame.origin.y + fabs(fabs(self.lastPoint.y) - fabs(point.y));
            }
        }
        self.tableView.frame = CGRectMake(0, y, self.tableView.bounds.size.width, self.tableView.bounds.size.height);
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        if(self.tableView.frame.origin.y < self.view.frame.size.height - 60)
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.tableView.frame = CGRectMake(0, 64, self.tableView.bounds.size.width, self.tableView.bounds.size.height);
                self.tableView.alpha = 1.0;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.tableView.frame = CGRectMake(0, self.view.frame.size.height, self.tableView.bounds.size.width, self.tableView.bounds.size.height);
            }];
        }
    }
    self.lastPoint = point;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(self.eyeView.isOK)
    {
        self.isDrap = NO;
        self.tableView.bounces = NO;
        self.tableView.frame = CGRectMake(0, fabs(scrollView.contentOffset.y) + 64, self.tableView.frame.size.width, self.tableView.frame.size.height);
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame), self.tableView.frame.size.width, self.tableView.frame.size.height);
        } completion:^(BOOL finished) {
            self.tableView.bounces = YES;
            self.isDrap = YES;
            self.eyeView.isOK = NO;
        }];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.isDrap)
    {
        self.eyeView.offsetY = scrollView.contentOffset.y;
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
        cell.textLabel.text = [NSString stringWithFormat:@"%ld 往下拉 %ld", indexPath.section, indexPath.row];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

@end
