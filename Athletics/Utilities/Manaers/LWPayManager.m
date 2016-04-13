//
//  LWPayManager.m
//  Link
//
//  Created by 李宛 on 16/3/8.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWPayManager.h"
#import "LWUMMacro.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "UPPaymentControl.h"

@interface LWPayManager ()<WXApiDelegate>

@property(nonatomic,copy)LWPayResultBlock resultBlock;

@end

@implementation LWPayManager
-(instancetype)shared{
    return [[self class]shared];
    
}

+(instancetype)shared
{
    static LWPayManager  *__singleton__ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        __singleton__ = [[self alloc]init];
        
    });
    return __singleton__;
}

+(void)registerWXPay
{
    [WXApi registerApp:k_wechatAppId withDescription:@"美链客户端"];
    
}

#pragma mark 支付宝支付

-(void)aliPayWithPaysign:(NSString *)paysign completion:(LWPayResultBlock)completion{
    
    [[self class]aliPayWithPaysign:paysign completion:completion];
}

+(void)aliPayWithPaysign:(NSString *)paysign completion:(LWPayResultBlock)completion
{
    [[self shared]setResultBlock:completion];
    if (![SCGlobaUtil isEmpty:paysign]) {
        [[AlipaySDK defaultService]payOrder:paysign fromScheme:@"XiaoYaoUserUrlSchemes" callback:^(NSDictionary *resultDic) {
            [self aliPayResult:resultDic];
        }];
    }else{
        if (completion) {
            completion(LWPayResultError);
        }
        return;
    }
    
}
+ (void)aliPayResult:(NSDictionary *)info {
    [[self shared] aliPayResult:info];
}


#pragma mark 微信支付
-(void)wxPayWithWXPayModel:(LWWXPayModel *)model completion:(LWPayResultBlock)completion
{
    [[self class]wxPayWithWXPayModel:model completion:completion];
}

+(void)wxPayWithWXPayModel:(LWWXPayModel *)model completion:(LWPayResultBlock)completion
{
    [[self shared]setResultBlock:completion];
    if (![WXApi isWXAppInstalled]) {
        if (completion) {
            completion(LWPayResultNoapp);
        }
        return;
    }else if (![WXApi isWXAppSupportApi]){
        if (completion) {
            completion(LWPayResultNonsupport);
        }
        return;
    }else if (!(model && [model isMemberOfClass:[LWWXPayModel class]]) ){
        if (completion) {
            completion(LWPayResultError);
        }
        return;
        
    }else if (![SCGlobaUtil isEmpty:model.sign]){
        if (completion) {
            completion(LWPayResultError);
        }
        return;
    }
    
    PayReq *request = [[PayReq alloc]init];
    request.openID = model.openId;
    request.package = ![SCGlobaUtil isEmpty:model.packageInfo] ?model.packageInfo:@"Sign=WXPay";
    request.partnerId = model.partnerId;
    request.nonceStr = model.nonce_str;
    request.prepayId = model.prepayId;
    request.timeStamp = model.timeStamp;
    
    BOOL result = [WXApi sendReq:request];
    if (!result) {
        if (completion) {
            completion(LWPayResultFail);
        }
    }
}

#pragma mark 银联支付
-(void)upPayWithTn:(NSString *)tn viewController:(UIViewController *)viewcontroller completion:(LWPayResultBlock)completion
{
    [[self class]upPayWithTn:tn viewController:viewcontroller completion:completion];
}

+(void)upPayWithTn:(NSString *)tn viewController:(UIViewController *)viewcontroller completion:(LWPayResultBlock)completion
{
    [[self shared] setResultBlock:completion];
    NSString *payModel = @"00";
    BOOL result = [[UPPaymentControl defaultControl]startPay:tn fromScheme:@"XiaoYaoUserUrlSchemes" mode:payModel viewController:viewcontroller];
    if (!result) {
        if (completion) {
            completion(LWPayResultFail);
        }
    }
    
}


#pragma mark --PayResult
+(BOOL)payResultUrl:(NSURL *)openUrl payType:(LWPay)payType
{
    if (payType == LWPayTypeWX) {
        return [WXApi handleOpenURL:openUrl delegate:[self shared]];
    }else if (payType == LWPayTypeAli){
         [[AlipaySDK defaultService]processOrderWithPaymentResult:openUrl standbyCallback:^(NSDictionary *resultDic) {
             [self aliPayResult:resultDic];
         }];
        return YES;
    }else if (payType == LWPayTypeUP){
        [[UPPaymentControl defaultControl]handlePaymentResult:openUrl completeBlock:^(NSString *code, NSDictionary *data) {
            [[self shared]UPPayPluginResult:code];
        }];
        return YES;
    }
    return NO;
}
#pragma mark - AliPayResult

- (void)aliPayResult:(NSDictionary *)info{
 
    NSString *resultCode = [info objectForKey:@"resultStatus"];
    if (self.resultBlock) {
        if ([resultCode isEqualToString:@"9000"]) {
            //成功
            self.resultBlock(LWPayResultSuccess);
        }else if ([resultCode isEqualToString:@"8000"]){
            //正在处理
            self.resultBlock(LWPayResultHandling);
        }else if ([resultCode isEqualToString:@"4000"]){
            //失败
            self.resultBlock(LWPayResultFail);
        }else if ([resultCode isEqualToString:@"6001"]){
            //取消
            self.resultBlock(LWPayResultCancle);
        }else{
            //错误
            self.resultBlock(LWPayResultError);
        }
    }
}


#pragma mark --WXAPIDelegate 
//微信代理执行的方法
- (void)onReq:(BaseReq *)req {
    if ([req isMemberOfClass:[PayReq class]]) {
        
        
    }
}
/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */

- (void)onResp:(BaseResp *)resp {
    
    if ([resp isMemberOfClass:[PayResp class]]) {
        if ([self shared].resultBlock) {
            switch (resp.errCode) {
                case WXSuccess:
                    self.resultBlock(LWPayResultSuccess);
                    break;
                    case WXErrCodeCommon:
                    self.resultBlock(LWPayResultError);
                    break;
                    case WXErrCodeUnsupport:
                    self.resultBlock(LWPayResultNonsupport);
                    break;
                    case WXErrCodeUserCancel:
                    self.resultBlock(LWPayResultCancle);
                    break;
                    case WXErrCodeSentFail:
                    self.resultBlock(LWPayResultFail);
                default:
                    self.resultBlock(LWPayResultError);
                    break;
            }
        }
    }
    
}
    

#pragma mark -UPPay

-(void)UPPayPluginResult:(NSString *)result{
    
    if (self.resultBlock) {
        if ([result isEqualToString:@"success"]) {
            self.resultBlock(LWPayResultSuccess);
        }else if ([result isEqualToString:@"cancle"]){
            self.resultBlock(LWPayResultCancle);
        }else if ([result isEqualToString:@"fail"]){
            self.resultBlock(LWPayResultFail);
        }else{
            self.resultBlock(LWPayResultFail);
        }
    }
    
}


@end


#pragma mark - LWWXPayModel

@implementation LWWXPayModel


@end

