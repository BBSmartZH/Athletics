//
//  SCUrlWrapper.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/21.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCUrlWrapper.h"

@implementation SCUrlWrapper

#pragma mark - **************************************************************

#pragma mark - 登录
/**
 *  登录
 *
 *  @return
 */
+ (NSString *)loginUrl {
    return [self p_wrap:@"/account/master/login"];
}

#pragma mark - 登出
/**
 *  登出
 *
 *  @return
 */
+ (NSString *)logoutUrl {
    return [self p_wrap:@"/account/master/logout"];
}

#pragma mark - 发送验证码
/**
 *  发送验证码
 *
 *  @return
 */
+ (NSString *)smsCodeUrl {
    return [self p_wrap:@"/account/master/password/msg"];
}

#pragma mark - 忘记密码
/**
 *  忘记密码
 *
 *  @return
 */
+ (NSString *)userForgetPasswordUrl {
    return [self p_wrap:@"/account/master/password/reset"];
}

#pragma mark - 修改密码
/**
 *  修改密码
 *
 *  @return
 */
+ (NSString *)userUpdatePasswordUrl {
    return [self p_wrap:@"/account/master/password/update"];
}

#pragma mark - **************************************************************



#pragma mark - Private
+ (NSString *)p_wrap:(NSString *)url {
    return url;
}

@end
