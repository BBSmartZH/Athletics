//
//  LWPayManager.h
//  Link
//
//  Created by 李宛 on 16/3/8.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int,LWPay){
    LWPayTypeAli = 1,//支付宝
    LWPayTypeWX = 2,//微信
    LWPayTypeUP = 3,//银联
};

typedef NS_ENUM(NSInteger,LWPayResult) {
    LWPayResultCancle = 1,//取消
    LWPayResultHandling = 2,//正在处理
    LWPayResultFail = 3,//支付失败
    LWPayResultSuccess = 4,//支付成功
    LWPayResultError = 5,//网络错误、普通错误
    LWPayResultNonsupport = 6,//版本过低不支持
    LWPayResultNoapp = 7,//没有客户端
    
};

typedef void(^LWPayResultBlock)(LWPayResult result);

@class LWWXPayModel;

@interface LWPayManager : NSObject

-(instancetype)shared;
+(instancetype)shared;


+(void)registerWXPay;

+(BOOL)payResultUrl:(NSURL *)openUrl  payType:(LWPay)payType;

+(void)aliPayWithPaysign:(NSString*)paysign
              completion:(LWPayResultBlock)completion;

+(void)wxPayWithWXPayModel:(LWWXPayModel *)model
                completion:(LWPayResultBlock)completion;

+(void)upPayWithTn:(NSString*)tn viewController:(UIViewController*)viewcontroller completion:(LWPayResultBlock)completion;


@end


#pragma mark -LWWXPayModel

@interface LWWXPayModel : NSObject

@property (nonatomic, copy) NSString *openId;
@property (nonatomic, copy) NSString *packageInfo;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, copy) NSString *prepayId;
@property (nonatomic, copy) NSString *nonce_str;
@property (nonatomic, copy) NSString *partnerId;
@property (nonatomic, assign) UInt32 timeStamp;

@end






















