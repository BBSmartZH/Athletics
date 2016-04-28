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


@interface SCShareManager ()<UMSocialUIDelegate>
{
    SCShareComplation _complation;
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
    [UMSocialWechatHandler setWXAppId:k_wechatAppId
                            appSecret:k_wechatAppSecret
                                  url:@"http://liusui/"];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:k_wechatAppId
                            appSecret:k_wechatAppSecret
                                  url:@"http://liushui/"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:k_qqAppId
                               appKey:k_qqAppSecret
                                  url:@"http://liushui/"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
                                              secret:@"04b48b094faeb16683c32669824ebdad"
                                         RedirectURL:@"http://liushui/"];
}

- (void)shareIn:(UIViewController *)controller
          title:(NSString *)title
       imageUrl:(NSString *)imageUrl
           desc:(NSString *)desc
       shareUrl:(NSString *)shareUrl {
    [self shareIn:controller title:title imageUrl:imageUrl desc:desc shareUrl:shareUrl complation:nil];
}


- (void)shareIn:(UIViewController *)controller
          title:(NSString *)title
       imageUrl:(NSString *)imageUrl
           desc:(NSString *)desc
       shareUrl:(NSString *)shareUrl
     complation:(SCShareComplation)complation {
    
#if DEBUG
    NSString *appKey = k_UMAppDebugKey;
#else
    NSString *appKey = k_UMAppReleaseKey;
#endif
    
    _complation = complation;
    
    [UMSocialSnsService presentSnsIconSheetView:controller appKey:appKey shareText:desc shareImage:nil shareToSnsNames:@[UMShareToWechatSession, UMShareToWechatTimeline, UMShareToQQ, UMShareToSina, UMShareToQzone] delegate:self];
    
    [UMSocialData defaultData].extConfig.title = title;
    
    //微信好友
    [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = shareUrl;
    [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = desc;
    UMSocialUrlResource *wechatSessionImage = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:imageUrl];
    [UMSocialData defaultData].extConfig.wechatSessionData.urlResource = wechatSessionImage;
    
    //微信朋友圈
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = desc;
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    UMSocialUrlResource *wechatTimelineImage = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:imageUrl];
    [UMSocialData defaultData].extConfig.wechatTimelineData.urlResource = wechatTimelineImage;
    
    /*设置QQ*/
    [UMSocialData defaultData].extConfig.qqData.title = title;
    [UMSocialData defaultData].extConfig.qqData.url = shareUrl;
    [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
    [UMSocialData defaultData].extConfig.qqData.shareText = desc;
    UMSocialUrlResource *qqImage = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:imageUrl];
    [UMSocialData defaultData].extConfig.qqData.urlResource = qqImage;
    
    /*设置QQ空间*/
    [UMSocialData defaultData].extConfig.qzoneData.url = shareUrl;
    [UMSocialData defaultData].extConfig.qzoneData.shareText = desc;
    UMSocialUrlResource *qzoneImage = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:imageUrl];
    [UMSocialData defaultData].extConfig.qzoneData.urlResource = qzoneImage;
    
    /*设置微博*/
    [UMSocialData defaultData].extConfig.sinaData.shareText = desc;
    UMSocialUrlResource *sinaImage = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:imageUrl];
    [UMSocialData defaultData].extConfig.sinaData.urlResource = sinaImage;
    
}

#pragma mark - UMSocialUIDelegate
/**
 各个页面执行授权完成、分享完成、或者评论完成时的回调函数
 
 @param response 返回`UMSocialResponseEntity`对象，`UMSocialResponseEntity`里面的viewControllerType属性可以获得页面类型
 */
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
    switch (response.responseCode) {
        case 200:
            //200  成功
            if (_complation) {
                _complation(SCShareResultSuccess);
            }
            break;
        case 510:
            //510  失败
            if (_complation) {
                _complation(SCShareResultFail);
            }
            break;
        case 5052:
            //5052 用户取消
            if (_complation) {
                _complation(SCShareResultCancel);
            }
            break;
        default:
            //其他情况  失败
            if (_complation) {
                _complation(SCShareResultFail);
            }
            break;
            break;
    }
}

+(void)applicationDidBecomeActive {
    [UMSocialSnsService applicationDidBecomeActive];
}

+ (BOOL)handleOpenURL:(NSURL *)openUrl {
    return [UMSocialSnsService handleOpenURL:openUrl];
}

@end
