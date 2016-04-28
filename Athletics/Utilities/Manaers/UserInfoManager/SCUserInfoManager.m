//
//  SCUserInfoManager.m
//  MrzjExpert
//
//  Created by mrzj_sc on 15/8/20.
//  Copyright (c) 2015年 shenchuang. All rights reserved.
//

#import "SCUserInfoManager.h"
#import "SCUserModel.h"


static NSString *k_login             = @"k_login_key";
static NSString *k_user_name        = @"k_user_name_key";
static NSString *k_user_uid          = @"k_user_uid_key";
static NSString *k_user_avatar         = @"k_user_avatar_key";
static NSString *k_user_mobile       = @"k_user_mobile_key";
static NSString *k_user_info         = @"k_user_info_key";


@implementation SCUserInfoManager

+ (void)setIsLogin:(BOOL)isLogin {
    [kUserDefaults setObject:[NSNumber numberWithBool:isLogin] forKey:k_login];
    [kUserDefaults synchronize];
    if (!isLogin) {
        [self p_clearUserInfo];
    }
}

+ (BOOL)isLogin {
    NSNumber *login = [kUserDefaults objectForKey:k_login];
    return login.boolValue;
}

+ (void)setUserInfo:(SCUserModel *)model {

    NSData *userInfo = [NSKeyedArchiver archivedDataWithRootObject:model];
    [kUserDefaults setObject:userInfo forKey:k_user_info];
    
    NSString *name = @"";
    if (![SCGlobaUtil isEmpty:model.name])
        name = model.name;
    NSString *uid = @"";
    if (![SCGlobaUtil isEmpty:model.uid]) {
        uid = model.uid;
    }
    NSString *avatar = @"";
    if (![SCGlobaUtil isEmpty:model.avatar]) {
        avatar = model.avatar;
    }
    NSString *mobile = @"";
    if (![SCGlobaUtil isEmpty:model.mobile]) {
        mobile = model.mobile;
    }
    [kUserDefaults setObject:name forKey:k_user_name];
    [kUserDefaults setObject:uid forKey:k_user_uid];
    [kUserDefaults setObject:avatar forKey:k_user_avatar];
    [kUserDefaults setObject:mobile forKey:k_user_mobile];
    [kUserDefaults synchronize];
}
+ (SCUserModel *)userInfo {
    SCUserModel *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:k_user_info]];
    return userInfo;
}

+ (void)updateUserInfo:(SCUserModel *)model {

    SCUserModel *localModel = [self userInfo];
    if (![SCGlobaUtil isEmpty:model.uid]) {
        localModel.uid = model.uid;
    }
    if (![SCGlobaUtil isEmpty:model.avatar]) {
        localModel.avatar = model.avatar;
    }
    if (![SCGlobaUtil isEmpty:model.name]) {
        localModel.name = model.name;
    }
    if (![SCGlobaUtil isEmpty:model.mobile]) {
        localModel.mobile = model.mobile;
    }
    if (![SCGlobaUtil isEmpty:model.gender]) {
        localModel.gender = model.gender;
    }
    [self setUserInfo:localModel];
    
}

+ (NSString *)userName {
    return [kUserDefaults objectForKey:k_user_name];
}

+ (NSString *)uid {
    return [kUserDefaults objectForKey:k_user_uid];
}

+ (NSString *)avatar {
    return [kUserDefaults objectForKey:k_user_avatar];
}

+ (NSString *)mobile {
    return [kUserDefaults objectForKey:k_user_mobile];
}

+ (void)p_clearUserInfo {
    [kUserDefaults removeObjectForKey:k_user_name];
    [kUserDefaults removeObjectForKey:k_user_uid];
    [kUserDefaults removeObjectForKey:k_user_info];
    [kUserDefaults removeObjectForKey:k_user_avatar];
    [kUserDefaults removeObjectForKey:k_user_mobile];
}

@end






