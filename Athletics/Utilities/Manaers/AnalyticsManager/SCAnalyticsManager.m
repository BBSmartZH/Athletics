//
//  SCAnalyticsManager.m
//  MrzjExpert
//
//  Created by shenchuang on 15/8/5.
//  Copyright (c) 2015年 shenchuang. All rights reserved.
//

#import "SCAnalyticsManager.h"
#import "MobClick.h"
#import "LWUMMacro.h"

@interface SCAnalyticsManager ()
{
    UIAlertView *_updateAlert;
}
@end

@implementation SCAnalyticsManager

+ (instancetype)shared {
    static SCAnalyticsManager *__singleton__ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __singleton__ = [[self alloc] init];
    });
    return __singleton__;
}

- (instancetype)shared {
    return [[self class] shared];
}

/**
 *  开启统计
 */
+ (void)startAnalyticsManager {
    // version标识  CFBundleShortVersionString
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
#if DEBUG
    // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick startWithAppkey:k_UMAppDebugKey reportPolicy:BATCH channelId:@"Athletics_inhouse"];
    [MobClick setAppVersion:version];
    [MobClick setLogEnabled:YES];
#else
    
    [MobClick startWithAppkey:k_UMAppReleaseKey reportPolicy:BATCH channelId:@"Athletics_inhouse"];
    [MobClick setAppVersion:version];
    [MobClick updateOnlineConfig];
#endif
    
}

/**
 *  页面统计
 */
+ (void)beginLogPageViewClass:(__unsafe_unretained Class)pageViewClass {
    [MobClick beginLogPageView:NSStringFromClass(pageViewClass)];
}
+ (void)endLogPageViewClass:(__unsafe_unretained Class)pageViewClass {
    [MobClick endLogPageView:NSStringFromClass(pageViewClass)];
}

+ (void)beginLogPageView:(NSString *)pageView {
    [MobClick beginLogPageView:pageView];
}
+ (void)endLogPageView:(NSString *)pageView {
    [MobClick endLogPageView:pageView];
}

/**
 *  时间统计
 */
+ (void)event:(NSString *)event {
    [MobClick event:event];
}
+ (void)event:(NSString *)event label:(NSString *)label {
    [MobClick event:event label:label];
}






@end
