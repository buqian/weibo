//
//  AppDelegate.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/12.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "AppDelegate.h"
#import "HYJKCController.h"
#import "ViewController.h"
#import "HYGifController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    self.window.rootViewController = [[HYGifController alloc] initWithNibName:@"HYGifController" bundle:nil];
////    self.window.rootViewController = [[ViewController alloc] init];
//    [self.window makeKeyAndVisible];
    
    // ios 7
//    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
//    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];

    //ios 8
//    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
//                                                                         settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
//                                                                         categories:nil]];
//    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
//    NSString *udid = [[UIDevice currentDevice] uniqueIdentifier];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken
{
    HYLogFun;
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    HYLogObj(error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    HYLogFun;
}
@end
