//
//  HYHomeController.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/13.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYHomeController.h"

@interface HYHomeController ()

@property (nonatomic, strong) NSArray *statusesArray;
@end

@implementation HYHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getWeiboPublicList];
}

-(void)getWeiboPublicList
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@statuses/home_timeline.json?access_token=%@&count=20", weibo_url2, [HYHelper getAccess_token]]];
//    NSString *param = [NSString stringWithFormat:@"access_token=%@", [HYHelper getAccess_token]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    request.timeoutInterval = 30;
    request.HTTPMethod = @"GET";
//    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    NSURLResponse *resp;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&error];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    self.statusesArray = dict[@"statuses"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = @"statuses_home";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.statusesArray[indexPath.row][@"text"];
    return cell;
}

-(instancetype)initWithTitle:(NSString *)title leftBarButtonItem:(UIBarButtonItem *)left rightBarButtonItem:(UIBarButtonItem *)right
{
    if(self = [super initWithStyle:UITableViewStylePlain])
    {
        self.title = title;
        self.navigationItem.leftBarButtonItem = left;
        self.navigationItem.rightBarButtonItem = right;

    }
    return self;
}

@end
