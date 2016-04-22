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

@interface AppDelegate ()

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
    
    // 开启键盘自适应管理功能
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
        
    NSObject *objc = [[NSUserDefaults standardUserDefaults] objectForKey:kAllChannelArrayKey];
    if (!objc) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSArray *titleDataArray = @[@[@"Dota 2", @"LOL", @"炉石传说"], @[@"风暴英雄", @"CS", @"超级街霸", @"魔兽争霸", @"DNF", @"CF", @"Smite", @"星际争霸2", @"Dota", @"FIFA", @"使命召唤"]];
            [[NSUserDefaults standardUserDefaults] setObject:titleDataArray forKey:kAllChannelArrayKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        });
    }
    
    [SCAnalyticsManager startAnalyticsManager];
    [SCShareManager startSocialShare];
    
    
    LWTabBarVC_iPhone *rootVC = [[LWTabBarVC_iPhone alloc] init];
    self.window.rootViewController = rootVC;
    
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

@end
