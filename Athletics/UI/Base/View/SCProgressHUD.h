//
//  SCProgressHUD.h
//  Link
//
//  Created by 李宛 on 16/3/10.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface SCProgressHUD : UIView
+ (MBProgressHUD *)MBHudWithText:(NSString *)text showAddTo:(UIView *)view delay:(BOOL)delay;
+ (MBProgressHUD *)MBHudShowAddTo:(UIView *)view delay:(BOOL)delay;

+ (void)postAlertWithMessage:(NSString *)message;
+ (void)postErrorAlertMessage:(NSString *)message;
+ (void)postSuccessAlertMessage:(NSString *)message;
@end
