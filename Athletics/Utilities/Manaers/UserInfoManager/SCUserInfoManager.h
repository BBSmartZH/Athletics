//
//  SCUserInfoManager.h
//  MrzjExpert
//
//  Created by mrzj_sc on 15/8/20.
//  Copyright (c) 2015年 shenchuang. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^SCBoolResultBlock)(BOOL result);

@class SCShopInfoDataModel;

@interface SCUserInfoManager : NSObject

+ (void)setIsLogin:(BOOL)isLogin;
+ (BOOL)isLogin;

//+ (void)setUserInfo:(SCShopInfoDataModel *)model;
//+ (void)updateUserInfo:(SCShopInfoDataModel *)model;
//+ (SCShopInfoDataModel *)userInfo;

+ (NSString *)userToken;
+ (NSString *)sid;
+ (NSString *)city;
+ (NSString *)cityId;

@end


@interface SCState : NSObject
/**
 *  用户订单状态
 *
 *  @param state
 *
 *  @return
 */
+ (NSString *)stringForOrderState:(int)state;
/**
 *  进货单状态
 *
 *  @param state
 *
 *  @return
 */
+ (NSString *)stringForCargoOrderState:(int)state;
@end

