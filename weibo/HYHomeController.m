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
//    NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    [self parseData:dict];
}

/**
 *
 @property (nonatomic, strong) HYUser *user;
 @property (nonatomic, copy) NSString *idstr;
 @property (nonatomic, copy) NSString *created_at;
 @property (nonatomic, copy) NSString *text;
 @property (nonatomic, copy) NSString *source;
 @property (nonatomic, strong) NSArray *pic_urls;
 @property (nonatomic, copy) NSString *thumbnail_pic;
 @property (nonatomic, assign) int reposts_count;
 @property (nonatomic, assign) int comments_count;
 @property (nonatomic, assign) int attitudes_count;
 
 
 @property (nonatomic, copy) NSString *profile_image_url;
 @property (nonatomic, copy) NSString *avatar_large;
 @property (nonatomic, copy) NSString *name;
 @property (nonatomic, copy) NSString *idstr;
 @property (nonatomic, copy) NSString *mbtype;
 @property (nonatomic, copy) NSString *star;
 *
 *  @param dict <#dict description#>
 */
-(void)parseData:(NSDictionary *)dict
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for(NSDictionary *d in dict[@"statuses"])
    {
        HYWeibo *weibo = [[HYWeibo alloc] init];
        HYUser *user = [[HYUser alloc] init];
        weibo.created_at = d[@"created_at"];
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
    return self.statusesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYTableViewCell *cell = [HYTableViewCell cellWithTableView:tableView];
    HYWeibo *weibo = self.statusesArray[indexPath.row];
    cell.weibo = weibo;
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
    return 200;
}
@end
