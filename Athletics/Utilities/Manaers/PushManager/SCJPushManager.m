//
//  SCJPushManager.m
//  MrzjExpert
//
//  Created by mrzj_sc on 15/8/24.
//  Copyright (c) 2015年 shenchuang. All rights reserved.
//

#import "SCJPushManager.h"
#import "JPUSHService.h"
#import "LWUMMacro.h"
#import "AppDelegate.h"


@implementation SCJPushManager


//开启推送服务
+ (void)startWithOptions:(NSDictionary *)launchOptions {
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        //register remoteNotification types （iOS 8.0及其以上版本）
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        [JPUSHService registerForRemoteNotificationTypes:UIUserNotificationTypeBadge
         |UIUserNotificationTypeSound
         |UIUserNotificationTypeAlert categories:[NSSet setWithObject:categorys]];
        
        
    } else{
        //register remoteNotification types (iOS 8.0以下)
        [JPUSHService registerForRemoteNotificationTypes:UIUserNotificationTypeBadge
         |UIUserNotificationTypeSound
         |UIUserNotificationTypeAlert categories:nil];
    }
#else
    //register remoteNotification types (iOS 8.0以下)
    [JPUSHService registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert categories:nil];
    
#endif
    
    
#if DEBUG
    [JPUSHService setupWithOption:launchOptions appKey:k_JPushDebugKey channel:@"AppStore" apsForProduction:NO];
#else
    [JPUSHService setupWithOption:launchOptions appKey:k_JPushReleaseKey channel:@"AppStore" apsForProduction:YES];
#endif
    
}

/** 向友盟注册该设备的deviceToken，便于发送Push消息
 @param deviceToken APNs返回的deviceToken
 */
+ (void)registerDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
    [self setAlias];
}

/** 应用处于运行时（前台、后台）的消息处理
 @param userInfo 消息参数
 */
+ (void)didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [self p_andleaffairs:userInfo];
}

+ (void)p_andleaffairs:(NSDictionary *)userInfo {
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        if ([SCUserInfoManager isLogin]) {
//            NSString *cancelTitle = @"暂不";
//            NSString *okTitle = @"立即查看";
//            NSString *message = @"您有一条新的消息";
//            
//            NSString *category = [userInfo objectForKey:@"category"];
//            NSString *type = [userInfo objectForKey:@"type"];
//            NSString *key = [userInfo objectForKey:@"key"];
//            
//            UIViewController *firstVC = [SCGlobaUtil getCurrentViewController];
//            int cate = [SCGlobaUtil getInt:category];
//            if (cate == 1) {
//                
//            }
        }
    }else {
        if ([SCUserInfoManager isLogin]) {
//            NSString *category = [userInfo objectForKey:@"category"];
//            NSString *type = [userInfo objectForKey:@"type"];
//            NSString *key = [userInfo objectForKey:@"key"];
//            
//            UIViewController *firstVC = [SCGlobaUtil getCurrentViewController];
        }
    }
}

//设置别名
+ (void)setAlias {
    [JPUSHService setAlias:[SCUserInfoManager uid] ? [SCUserInfoManager uid] : @"" callbackSelector:nil object:nil];
}

//解除别名
+ (void)relieveAlias {
    [JPUSHService setAlias:@"" callbackSelector:nil object:nil];
}

// 显示本地通知在最前面
+ (void)showLocalNotificationAtFront:(UILocalNotification *)notification {
    
}

@end
