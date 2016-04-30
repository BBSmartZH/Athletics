//
//  AppDelegate.m
//  Athletics
//
//  Created by 李宛 on 16/4/9.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "AppDelegate.h"
#import "LWTabBarVC_iPhone.h"

#import "SCAnalyticsManager.h"
#import "SCShareManager.h"
#import "SCNetworkStatusManager.h"
#import "SCJPushManager.h"

#import "SCGameListModel.h"
#import "SCAppUpdateModel.h"
#import "UIAlertView+Blocks.h"

@interface AppDelegate ()
{
    UIAlertView *_updateAlert;
    BOOL _isSetupCommonFinished;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([UIDevice currentDevice].systemVersion.floatValue < 9.0) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [SCNetworkStatusManager startMonitorNetworkStatus];
    
    //开启远程推送
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [SCJPushManager startWithOptions:launchOptions];
    /**
     *  统计分析
     */
    [SCAnalyticsManager startAnalyticsManager];
    /**
     *  分享
     */
    [SCAnalyticsManager startAnalyticsManager];
    [SCShareManager startSocialShare];
    
    // 开启键盘自适应管理功能
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
        
    
    //首次启动时
    NSArray *channel = [SCChannelManager newsChannel];
    
    if (!channel) {
        [SCNetwork gameListSuccess:^(SCGameListModel *model) {
            [self handleChannelWith:model];
            _isSetupCommonFinished = YES;
        } message:^(NSString *resultMsg) {}];
        
        while (!_isSetupCommonFinished) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        
    }else {
        [SCNetwork gameListSuccess:^(SCGameListModel *model) {
            [self handleChannelWith:model];
        } message:^(NSString *resultMsg) {}];
    }
    
    LWTabBarVC_iPhone *rootVC = [[LWTabBarVC_iPhone alloc] init];
    self.window.rootViewController = rootVC;
    
    
    
    //app后台打开时推送处理
    NSDictionary *pushDic = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (pushDic) {
        [SCJPushManager didReceiveRemoteNotification:pushDic];
    }
    
    
    
    return YES;
}

- (void)handleChannelWith:(SCGameListModel *)model {
    [SCChannelManager updateChannelWith:model];
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
    
    [SCNetwork gameListSuccess:^(SCGameListModel *model) {
        [self handleChannelWith:model];
    } message:^(NSString *resultMsg) {}];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [SCShareManager applicationDidBecomeActive];
    
    //版本更新
    [SCNetwork appUpdateWithSuccess:^(SCAppUpdateModel *model) {
        [self handleAppUpdateWith:model.data];
    } message:^(NSString *resultMsg) {}];
    
}

- (void)handleAppUpdateWith:(SCAppUpdateDataModel *)model {
    NSString *title = @"发现新版本";
    if ([SCGlobaUtil getInt:model.type] == 3) {
        //强制更新
        if (![_updateAlert isVisible]) {
            _updateAlert = [UIAlertView showWithTitle:title message:model.title cancelButtonTitle:nil otherButtonTitles:@[@"立即更新"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex == 0) {
                    NSURL *url = [NSURL URLWithString:model.url];
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
        }
    }else if ([SCGlobaUtil getInt:model.type] == 2) {
        //普通更新
        _updateAlert = [UIAlertView showWithTitle:title message:model.title cancelButtonTitle:@"暂不更新" otherButtonTitles:@[@"立即更新"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                NSURL *url = [NSURL URLWithString:model.url];
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
    }else {
        //不更新
        
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [SCShareManager handleOpenURL:url];
}

#pragma mark - PUSH

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [SCJPushManager registerDeviceToken:deviceToken];
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    NSLog(@"++token++ %@", token);
    [SCNetwork uploadApnsTokenWithToken:token success:^(SCResponseModel *model) {} message:^(NSString *resultMsg) {}];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [SCJPushManager didReceiveRemoteNotification:userInfo];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
//如果需要支持 iOS8,请加上这些代码
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}
#endif

@end
