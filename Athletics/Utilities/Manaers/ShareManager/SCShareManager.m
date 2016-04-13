//
//  SCShareManager.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCShareManager.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"

#import "LWUMMacro.h"
#import "WXApi.h"

#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"


@interface SCShareManager ()<TencentSessionDelegate>
{
    TencentOAuth *_tencentOAuth;
}

@end

@implementation SCShareManager

+ (instancetype)shared {
    static SCShareManager *__singleton__ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __singleton__ = [[self alloc] init];
    });
    return __singleton__;
}
- (instancetype)shared {
    return [[self class] shared];
}

+ (void)startSocialShare {
    //设置友盟社会化组件appkey
#if DEBUG
    [UMSocialData setAppKey:k_UMAppDebugKey];
#else
    [UMSocialData setAppKey:k_UMAppReleaseKey];
#endif
    
    [UMSocialConfig showNotInstallPlatforms:nil];
    [UMSocialWechatHandler setWXAppId:k_wechatAppId appSecret:k_wechatAppSecret url:@"http://liusui/"];
    
    
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:k_wechatAppId appSecret:k_wechatAppSecret url:@"http://liushui/"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:k_qqAppId appKey:k_qqAppSecret url:@"http://liushui/"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
//                                              secret:@"04b48b094faeb16683c32669824ebdad"
//                                         RedirectURL:@""];
    
    
}

- (void)qqLoginAuth {
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:k_qqAppId andDelegate:self];
    
    [_tencentOAuth authorize:@[@"get_user_info"] inSafari:NO];
    
    
    
    
    
    
}

- (void)tencentDidLogin {
    if (_tencentOAuth.accessToken && [_tencentOAuth.accessToken length] != 0) {
        
    }else {
        
    }
}// 登录成功
- (void)tencentDidLogout {
    
}// 已退出
- (void)tencentDidNotLogin:(BOOL)cancelled {
    
}// 登录失败，一种为用户单击了取消按钮。

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork {
    
}


+ (BOOL)handleOpenURL:(NSURL *)openUrl {
    return [UMSocialSnsService handleOpenURL:openUrl];
}

@end
