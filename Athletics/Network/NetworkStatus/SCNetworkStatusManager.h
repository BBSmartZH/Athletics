//
//  SCNetworkStatusManager.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/21.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"

typedef NS_ENUM(NSInteger, SCNetworkStatus) {
    SCNetworkStatusUnkonw = -1,
    SCNetworkStatusNotReachable = 0,
    SCNetworkStatusReachableViaWWAN = 1,
    SCNetworkStatusReachableViaWiFi = 2,
};

@interface SCNetworkStatusManager : NSObject

+ (instancetype)sharedInstance;
- (instancetype)sharedInstance;

+ (SCNetworkStatus)networkStatus;

+ (void)startMonitorNetworkStatus;

+ (BOOL)isNetWorkAvailable;

@end
