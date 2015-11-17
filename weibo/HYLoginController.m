//
//  HYLoginController.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/13.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYLoginController.h"
#import "HYLoginLogoView.h"
#import "ViewController.h"

@interface HYLoginController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation HYLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.submitBtn.layer setCornerRadius:2];
    self.submitBtn.layer.masksToBounds = YES;
    [self.logoView.layer setCornerRadius:self.logoView.frame.size.width * 0.5];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize"]];
    NSString *params = [NSString stringWithFormat:@"client_id=%@&redirect_uri=%@", client_id, redirect_uri];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
    request.allHTTPHeaderFields = nil;
    
    self.webView.delegate = self;
    [self.webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *url = request.URL.absoluteString;
    NSString *search = @"?code=";
    if([url containsString:search]) {
        NSString *code = [url substringFromIndex:[url rangeOfString:search].location + search.length];
        NSLog(@"code= %@", code);
        [HYHelper setCode:code];
        
        [self getAccessToken];
        
        ViewController *viewController = [[ViewController alloc] init];
        [self presentViewController:viewController animated:YES completion:nil];
        return NO;
    }
//    NSLog(@"shouldStartLoadWithRequest,%@", request);
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    NSLog(@"didFailLoadWithError, %@", error);
}

/**
 *  添加shadow圆角无效
 */
-(void)test
{
//    [self.logoView.layer setCornerRadius:self.logoView.frame.size.width * 0.5];
    //    self.logoView.layer.masksToBounds = YES;
    //    [self.logoView.layer setShadowOffset:CGSizeMake(3, 3)];
    //    [self.logoView.layer setShadowRadius:3];
    //    [self.logoView.layer setShadowOpacity:0.5];
    //    [self.logoView.layer setShadowColor:[UIColor redColor].CGColor];
}

-(void)getAccessToken
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@access_token", weibo_url]];
    NSString *params = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=%@&code=%@&redirect_uri=%@", client_id, client_secret, grant_type, [HYHelper getCode], redirect_uri];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
    request.allHTTPHeaderFields = nil;
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionTask * task =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [HYHelper setAccess_token:dict[@"access_token"]];
        NSLog(@"result:%@", dict);
        NSLog(@"access_token:%@", [HYHelper getAccess_token]);
        
    }];
    [task resume];
    
}

@end
