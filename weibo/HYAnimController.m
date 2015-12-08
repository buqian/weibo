//
//  HYAnimController.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/8.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYAnimController.h"

@interface HYAnimController ()

@property (nonatomic, strong) NSArray *array;

@end

@implementation HYAnimController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"anim.plist" ofType:nil];
    _array = [NSArray arrayWithContentsOfFile:path];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ID = @"com.buqian.anim.cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = _array[indexPath.row][@"name"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *clazz = _array[indexPath.row][@"clazz"];
    UIViewController *vc = [[NSClassFromString(clazz) alloc] initWithNibName:clazz bundle:nil];
    
    [self presentViewController:vc animated:YES completion:nil];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
}

@end
