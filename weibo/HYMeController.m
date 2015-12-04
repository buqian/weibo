//
//  HYMeController.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/13.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYMeController.h"
#import "HYJKCController.h"

@interface HYMeController ()

@property (nonatomic, strong) NSArray *plistArray;

@end

@implementation HYMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.plistArray = [NSArray arrayWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"me" withExtension:@"plist"]];
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"meCell"];
    if(nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"meCell"];
    }
    cell.textLabel.text = self.plistArray[indexPath.row][@"name"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    NSString *image = self.plistArray[indexPath.row][@"image"];
    if(nil == image)
    {
        image = @"lucky_lots_taohua";
    }
    cell.imageView.image = [UIImage imageNamed:image];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.plistArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tabBarController performSelector:@selector(hideTabbar) withObject:nil];
    NSString *clazz = self.plistArray[indexPath.row][@"clazz"];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"回家" style:UIBarButtonItemStyleDone target:nil action:nil];
    UIViewController *vc = [[NSClassFromString(clazz) alloc] initWithNibName:clazz bundle:nil];
    if ([self.plistArray[indexPath.row][@"model"]  isEqual:@"model"]) {
        [self presentViewController:vc animated:YES completion:nil];
    }
    else
    {
        [self.navigationController pushViewController:vc animated:YES];
    }
    [UIView animateWithDuration:0.5 animations:^{
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
}

-(void)hideTabbar
{
}

-(void)showTabbar
{
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController performSelector:@selector(showTabbar) withObject:nil];
}
@end
