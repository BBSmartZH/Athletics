//
//  SCNetworkStatusManager.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/21.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNetworkStatusManager.h"

static BOOL sc_currentNetworkAvailable = NO;
static SCNetworkStatus sc_status;

@implementation SCNetworkStatusManager


+ (instancetype)sharedInstance {
    static SCNetworkStatusManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SCNetworkStatusManager alloc] init];
    });
    return manager;
}

- (instancetype)sharedInstance {
    return [[self class] sharedInstance];
}

+ (SCNetworkStatus)networkStatus {
    return sc_status;
}

+ (void)startMonitorNetworkStatus {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sc_currentNetworkAvailable = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                switch (status) {
                    case AFNetworkReachabilityStatusUnknown:
                        sc_status = SCNetworkStatusUnkonw;
                        break;
                    case AFNetworkReachabilityStatusNotReachable:
                        sc_status = SCNetworkStatusNotReachable;
                        break;
                    case AFNetworkReachabilityStatusReachableViaWWAN:
                        sc_status = SCNetworkStatusReachableViaWWAN;
                        break;
                    case AFNetworkReachabilityStatusReachableViaWiFi:
                        sc_status = SCNetworkStatusReachableViaWiFi;
                        break;
                    default:
                        break;
                }
            }];
        });
    });
}

+ (BOOL)isNetWorkAvailable {
    if (sc_status == SCNetworkStatusNotReachable) {
        return NO;
    }
    return YES;
}

@end
