//
//  SCProgressHUD.m
//  Link
//
//  Created by 李宛 on 16/3/10.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCProgressHUD.h"
@implementation SCProgressHUD

+ (MBProgressHUD *)MBHudWithText:(NSString *)text showAddTo:(UIView *)view delay:(BOOL)delay
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    if (![self isEmpty:text]) {
        HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        HUD.bezelView.layer.opacity = 0.7;
        HUD.contentColor = [UIColor whiteColor];
        HUD.bezelView.color = [UIColor blackColor];
        HUD.margin = 10.0f;
        HUD.userInteractionEnabled = NO;
        HUD.mode = MBProgressHUDModeText;
        HUD.label.text = text;
        HUD.bezelView.color = [UIColor blackColor];
        HUD.margin = 10;
    }
    //延迟一秒出现,在请求完成的时候设为NO;
    if (delay) {
        HUD.graceTime = 1.0f;
        HUD.minShowTime = 1.0f;
    }else
    {
        HUD.graceTime = 0.0f;
        HUD.minShowTime = 1.0f;
    }
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    return HUD;
}

+ (MBProgressHUD *)MBHudShowAddTo:(UIView *)view delay:(BOOL)delay
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.bezelView.layer.opacity = 0.7;
    HUD.contentColor = [UIColor whiteColor];
    HUD.bezelView.color = [UIColor blackColor];
    //延迟一秒出现,在请求完成的时候设为NO;
    if (delay) {
        HUD.graceTime = 1.0f;
        HUD.minShowTime = 1.0f;
    }else
    {
        HUD.graceTime = 0.0f;
        HUD.minShowTime = 1.0f;
    }
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    return HUD;
}

+ (BOOL)isEmpty:(NSString*)str
{
    if ([str isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if (str == nil || [str length] == 0) {
        return YES;
    } else {
        return NO;
    }
}


@end
