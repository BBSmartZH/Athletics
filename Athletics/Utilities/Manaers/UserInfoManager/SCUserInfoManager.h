//
//  SCUserInfoManager.h
//  MrzjExpert
//
//  Created by mrzj_sc on 15/8/20.
//  Copyright (c) 2015年 shenchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCUserModel.h"

typedef void (^SCBoolResultBlock)(BOOL result);

@interface SCUserInfoManager : NSObject

+ (void)setIsLogin:(BOOL)isLogin;
+ (BOOL)isLogin;

+ (BOOL)isMyWith:(NSString *)userId;

+ (void)setUserInfo:(SCUserModel *)model;
+ (void)updateUserInfo:(SCUserModel *)model;
+ (SCUserModel *)userInfo;

+ (NSString *)userName;
+ (NSString *)uid;
+ (NSString *)avatar;
+ (NSString *)mobile;

@end


