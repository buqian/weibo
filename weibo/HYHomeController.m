//
//  HYHomeController.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/13.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYHomeController.h"
#import "HYWeibo.h"
#import "HYUser.h"
#import "HYTableViewCell.h"
#import "HYWeiboFrame.h"

@interface HYHomeController ()

@property (nonatomic, strong) NSArray *statusesArray;
@end

@implementation HYHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.backgroundColor = HYColor(226, 226, 226);
    
    
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
    NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    [self parseData:dict];
}

-(void)parseData:(NSDictionary *)dict
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for(NSDictionary *d in dict[@"statuses"])
    {
        HYWeibo *weibo = [[HYWeibo alloc] init];
        HYUser *user = [[HYUser alloc] init];
        NSString *timeStr = d[@"created_at"];
//        NSLog(@"%@", timeStr);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"EEE MMM dd H:mm:ss Z yyyy"];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        NSDate *date = [formatter dateFromString:timeStr];
        [formatter setDateFormat:@"yyyy-MM-dd H:mm:ss"];
//        NSLog(@"%@", [formatter stringFromDate:date]);
        weibo.created_at = date;
        weibo.text = d[@"text"];
        weibo.idstr = d[@"idstr"];
        weibo.source = d[@"source"];
        weibo.thumbnail_pic = d[@"thumbnail_pic"];
        weibo.reposts_count = (int)d[@"reposts_count"];
        weibo.comments_count = (int)d[@"comments_count"];
        weibo.attitudes_count = (int)d[@"attitudes_count"];
        weibo.pic_urls = d[@"pic_urls"];
        
        NSDictionary *dictUser = d[@"user"];
        user.profile_image_url = dictUser[@"profile_image_url"];
        user.avatar_large = dictUser[@"avatar_large"];
        user.name = dictUser[@"name"];
        user.idstr = dictUser[@"idstr"];
        user.mbtype = dictUser[@"mbtype"];
        user.star = dictUser[@"star"];
        
        weibo.user = user;
        
        HYWeiboFrame *frame = [[HYWeiboFrame alloc] initWithHYWeibo:weibo];
        
        weibo.frame = frame;
        
        [mutableArray addObject:weibo];
    }
    self.statusesArray = mutableArray;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"statusesArray.count = %ld, section = %d", self.statusesArray.count, section);
    return self.statusesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"cellForRowAtIndexPath = %d", indexPath.row);
//    HYTableViewCell *cell = [HYTableViewCell cellWithTableView:tableView];
    HYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cess"];
    if(cell == nil) {
        cell = [[HYTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cess"];
    }
    HYWeibo *weibo = self.statusesArray[indexPath.row];
    cell.weibo = weibo;
//    cell.textLabel.text = weibo.text;
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYWeibo *weibo = self.statusesArray[indexPath.row];
    return weibo.frame.height;
}
@end
