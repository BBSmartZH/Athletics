//
//  SCUrlWrapper.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/21.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCUrlWrapper : NSObject

#pragma mark - **************************************************************

#pragma mark - 登录
/**
 *  登录
 *
 *  @return
 */
+ (NSString *)loginUrl;

#pragma mark - 登出
/**
 *  登出
 *
 *  @return
 */
+ (NSString *)logoutUrl;

#pragma mark - 发送验证码
/**
 *  发送验证码
 *
 *  @return
 */
+ (NSString *)smsCodeUrl;

#pragma mark - 忘记密码
/**
 *  忘记密码
 *
 *  @return
 */
+ (NSString *)userForgetPasswordUrl;

#pragma mark - 修改密码
/**
 *  修改密码
 *
 *  @return
 */
+ (NSString *)userUpdatePasswordUrl;

#pragma mark - **************************************************************


@end
