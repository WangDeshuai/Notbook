//
//  AppDelegate.m
//  Notepad
//
//  Created by Mac on 2017/11/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabbarController.h"
#import "WHC_GestureUnlockScreenVC.h"
#import "ViewController.h"
#import "JPUSHService.h"
#import <UserNotifications/UserNotifications.h>
#import <BmobSDK/Bmob.h>
#import "MsgVC.h"
#import "SGPagingView.h"
#import "BaseNavigationController.h"
@interface AppDelegate ()
{
    BOOL _isShowWebView;
}
@property (strong, nonatomic) DDMenuController *menuController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
   
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone *GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    [formatter setTimeZone:GTMzone];
    NSDate* inputDate = [formatter dateFromString:@"2017-12-21"];
    NSTimeInterval interval = [date timeIntervalSinceDate:inputDate];
    _isShowWebView = interval < 0 ? false : true;
    [Bmob registerWithAppKey:@"40c24d4443e06886bf6c6be8fba31da9"];
    
    if (_isShowWebView) {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        MsgVC * vc = [[MsgVC alloc]init];
        self.window.rootViewController = vc;
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
    }else{
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        BaseTabbarController * vc = [[BaseTabbarController alloc]init];
        self.window.rootViewController = vc;
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
    }
   
//    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
//    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
//
//    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//
//
//
//
//
//    [JPUSHService setupWithOption:launchOptions appKey:appKey
//                          channel:channel
//                 apsForProduction:isProduction
//            advertisingIdentifier:nil];
//
//
//
//
//    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
//        if(resCode == 0){
//            //            NSLog(@"registrationID获取成功：%@",registrationID);
//
//        }
//        else{
//            //            NSLog(@"registrationID获取失败，code：%d",resCode);
//        }
//    }];
//
    
   
    return YES;
}

//- (void)application:(UIApplication *)application
//didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    // rootViewController.deviceTokenValueLabel.text =
//    // [NSString stringWithFormat:@"%@", deviceToken];
//    // rootViewController.deviceTokenValueLabel.textColor =
//    [UIColor colorWithRed:0.0 / 255
//                    green:122.0 / 255
//                     blue:255.0 / 255
//                    alpha:1];
//    //    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
//    [JPUSHService registerDeviceToken:deviceToken];
//}
//
//- (void)application:(UIApplication *)application
//didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    //    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
//}
//
//#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
//- (void)application:(UIApplication *)application
//didRegisterUserNotificationSettings:
//(UIUserNotificationSettings *)notificationSettings {
//}
//
//// Called when your app has been activated by the user selecting an action from
//// a local notification.
//// A nil action identifier indicates the default action.
//// You should call the completion handler as soon as you've finished handling
//// the action.
//- (void)application:(UIApplication *)application
//handleActionWithIdentifier:(NSString *)identifier
//forLocalNotification:(UILocalNotification *)notification
//  completionHandler:(void (^)())completionHandler {
//}
//
//// Called when your app has been activated by the user selecting an action from
//// a remote notification.
//// A nil action identifier indicates the default action.
//// You should call the completion handler as soon as you've finished handling
//// the action.
//- (void)application:(UIApplication *)application
//handleActionWithIdentifier:(NSString *)identifier
//forRemoteNotification:(NSDictionary *)userInfo
//  completionHandler:(void (^)())completionHandler {
//}
//#endif
//
//- (void)application:(UIApplication *)application
//didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    [JPUSHService handleRemoteNotification:userInfo];
//    //    NSLog(@"2222收到通知:%@", [self logDic:userInfo]);
//    
//    //[[NSNotificationCenter defaultCenter]postNotificationName:@"tongzhi" object:nil] ;
//    
//    
//    // [rootViewController addNotificationCount];
//}
//
//- (void)application:(UIApplication *)application
//didReceiveRemoteNotification:(NSDictionary *)userInfo
//fetchCompletionHandler:
//(void (^)(UIBackgroundFetchResult))completionHandler {
//    [JPUSHService handleRemoteNotification:userInfo];
//    //    NSLog(@"1111收到通知:%@", [self logDic:userInfo]);
//    // [rootViewController addNotificationCount];
//    //[[NSNotificationCenter defaultCenter]postNotificationName:@"tongzhi" object:nil] ;
//    completionHandler(UIBackgroundFetchResultNewData);
//}
//
//- (void)application:(UIApplication *)application
//didReceiveLocalNotification:(UILocalNotification *)notification {
//    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
//}
//
//// log NSSet with UTF8
//// if not ,log will be \Uxxx
//- (NSString *)logDic:(NSDictionary *)dic {
//    if (![dic count]) {
//        return nil;
//    }
//    NSString *tempStr1 =
//    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
//                                                 withString:@"\\U"];
//    NSString *tempStr2 =
//    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
//    NSString *tempStr3 =
//    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
//    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *str =
//    [NSPropertyListSerialization propertyListFromData:tempData
//                                     mutabilityOption:NSPropertyListImmutable
//                                               format:NULL
//                                     errorDescription:NULL];
//    return str;
//}
//
//
//
//
//








- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     [WHC_GestureUnlockScreenVC setUnlockScreen];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
