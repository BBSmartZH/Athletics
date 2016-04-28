//
//  SCJPushManager.h
//  MrzjExpert
//
//  Created by mrzj_sc on 15/8/24.
//  Copyright (c) 2015年 shenchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCJPushManager : NSObject

//开启推送服务
+ (void)startWithOptions:(NSDictionary *)launchOptions;

/** 向友盟注册该设备的deviceToken，便于发送Push消息
 @param deviceToken APNs返回的deviceToken
 */
+ (void)registerDeviceToken:(NSData *)deviceToken;

/** 应用处于运行时（前台、后台）的消息处理
 @param userInfo 消息参数
 */
+ (void)didReceiveRemoteNotification:(NSDictionary *)userInfo;

//设置别名
+ (void)setAlias;
//解除别名
+ (void)relieveAlias;

// 显示本地通知在最前面
+ (void)showLocalNotificationAtFront:(UILocalNotification *)notification;

@end
