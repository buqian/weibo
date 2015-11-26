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
#import "HYRefreshHeaderView.h"
#import "HYRefreshFooterView.h"

@interface HYHomeController ()

@property (nonatomic, strong) NSArray *statusesArray;

@end

@implementation HYHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.backgroundColor = HYColor(240, 240, 240);
    
    [self getWeiboPublicList];
    
    HYRefreshHeaderView *headerView = [[HYRefreshHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    self.tableView.tableHeaderView = headerView;
    headerView.tableView = self.tableView;
    
    HYRefreshFooterView *footerView = [[HYRefreshFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    self.tableView.tableFooterView = footerView;
    footerView.tableView = self.tableView;
    
//    NSLog(@"%@", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    HYRefreshHeaderView *headerView = (HYRefreshHeaderView *)self.tableView.tableHeaderView;
    [headerView refreshDidEndDragging:self.tableView scrollView:scrollView];
    
    HYRefreshFooterView *footerView = (HYRefreshFooterView *)self.tableView.tableFooterView;
    [footerView refreshDidEndDragging:self.tableView scrollView:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    HYRefreshHeaderView *headerView = (HYRefreshHeaderView *)self.tableView.tableHeaderView;
    [headerView refreshWithTableView:self.tableView scrollView:scrollView];
    
    HYRefreshFooterView *footerView = (HYRefreshFooterView *)self.tableView.tableFooterView;
    [footerView refreshWithTableView:self.tableView scrollView:scrollView];
}

-(void)getWeiboPublicList
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@statuses/home_timeline.json?access_token=%@&count=3", weibo_url2, [HYHelper getAccess_token]]];
//    NSString *param = [NSString stringWithFormat:@"access_token=%@", [HYHelper getAccess_token]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    request.timeoutInterval = 30;
    request.HTTPMethod = @"GET";
//    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    NSURLResponse *resp;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&error];
//    NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
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
        
        NSDictionary *retweetDict = d[@"retweeted_status"];
        if(nil != retweetDict)
        {
            
            HYWeibo *retweet = [[HYWeibo alloc] init];
            HYUser *retweetUser = [[HYUser alloc] init];
            
            retweet.text = retweetDict[@"text"];
            retweet.idstr = retweetDict[@"idstr"];
            retweet.thumbnail_pic = retweetDict[@"thumbnail_pic"];
            retweet.pic_urls = retweetDict[@"pic_urls"];
            
            NSDictionary *retweetUserDuct = retweetDict[@"user"];
            retweetUser.profile_image_url = retweetUserDuct[@"profile_image_url"];
            retweetUser.avatar_large = retweetUserDuct[@"avatar_large"];
            retweetUser.name = retweetUserDuct[@"name"];
            retweetUser.idstr = retweetUserDuct[@"idstr"];
            retweetUser.mbtype = retweetUserDuct[@"mbtype"];
            retweetUser.star = retweetUserDuct[@"star"];
            
            retweet.user = retweetUser;
            
            HYWeiboFrame *retweetFrame = [[HYWeiboFrame alloc] initWithHYWeibo:retweet];
            retweet.frame = retweetFrame;
            
            weibo.retweet = retweet;
        }
        
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
    if(indexPath.row == (self.statusesArray.count - 1))
    {
        return weibo.frame.height - margin;
    }
    else
    {
        return weibo.frame.height;
    }
//    NSLog(@"%f", weibo.frame.height);
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSelector:@selector(unSelectTableViewCell:) withObject:indexPath afterDelay:1];
}

-(void)unSelectTableViewCell:(id)sender
{
    [self.tableView deselectRowAtIndexPath:sender animated:YES];
}

@end
