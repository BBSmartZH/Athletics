//
//  SCUserInfoManager.m
//  MrzjExpert
//
//  Created by mrzj_sc on 15/8/20.
//  Copyright (c) 2015年 shenchuang. All rights reserved.
//

#import "SCUserInfoManager.h"
//#import "SCShopInfoModel.h"

#define kUserDefaults ([NSUserDefaults standardUserDefaults])

static NSString *k_login             = @"k_login_key";
static NSString *k_user_token        = @"k_user_token_key";
static NSString *k_user_sid          = @"k_user_sid_key";
static NSString *k_user_city         = @"k_user_city_key";
static NSString *k_user_cityId       = @"k_user_cityId_key";
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

/**
 *  @property (nonatomic, copy) NSString<Optional>         *mid;
    @property (nonatomic, copy) NSString<Optional>         *avatar;
    @property (nonatomic, copy) NSString<Optional>         *name;
    @property (nonatomic, copy) NSString<Optional>         *level;
    @property (nonatomic, copy) NSString<Optional>         *token;
    @property (nonatomic, copy) NSString<Optional>         *workAddress;
 
    @property (nonatomic, copy) NSString<Optional>         *shareUrl;
    @property (nonatomic, copy) NSString<Optional>         *inviteUrl;
    @property (nonatomic, copy) NSString<Optional>         *city;
    @property (nonatomic, copy) NSString<Optional>         *cityId;
 *
 */

//+ (void)setUserInfo:(SCShopInfoDataModel *)model {
//
//    NSData *userInfo = [NSKeyedArchiver archivedDataWithRootObject:model];
//    [kUserDefaults setObject:userInfo forKey:k_user_info];
//    
//    NSString *token = @"";
//    if (![SCGlobaUtil isEmpty:model.token])
//        token = model.token;
//    NSString *mid = @"";
//    if (![SCGlobaUtil isEmpty:model.sid]) {
//        mid = model.sid;
//    }
//    NSString *city = @"";
//    if (![SCGlobaUtil isEmpty:model.city]) {
//        city = model.city;
//    }
//    NSString *cityId = @"";
//    if (![SCGlobaUtil isEmpty:model.cityId]) {
//        cityId = model.cityId;
//    }
//    [kUserDefaults setObject:token forKey:k_user_token];
//    [kUserDefaults setObject:mid forKey:k_user_sid];
//    [kUserDefaults setObject:city forKey:k_user_city];
//    [kUserDefaults setObject:cityId forKey:k_user_cityId];
//    [kUserDefaults synchronize];
//}
//+ (SCShopInfoDataModel *)userInfo {
//    SCShopInfoDataModel *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:k_user_info]];
//    return userInfo;
//}
//
//+ (void)updateUserInfo:(SCShopInfoDataModel *)model {
//
//    SCShopInfoDataModel *localModel = [self userInfo];
//    if (![SCGlobaUtil isEmpty:model.sid]) {
//        localModel.sid = model.sid;
//    }
//    if (![SCGlobaUtil isEmpty:model.avatar]) {
//        localModel.avatar = model.avatar;
//    }
//    if (![SCGlobaUtil isEmpty:model.name]) {
//        localModel.name = model.name;
//    }
//    if (![SCGlobaUtil isEmpty:model.mobile]) {
//        localModel.mobile = model.mobile;
//    }
//    if (![SCGlobaUtil isEmpty:model.servicePhone]) {
//        localModel.servicePhone = model.servicePhone;
//    }
//    if (![SCGlobaUtil isEmpty:model.token]) {
//        localModel.token = model.token;
//    }
//    if (![SCGlobaUtil isEmpty:model.workAddress]) {
//        localModel.workAddress = model.workAddress;
//    }
//    if (![SCGlobaUtil isEmpty:model.shareUrl]) {
//        localModel.shareUrl = model.shareUrl;
//    }
//    if (![SCGlobaUtil isEmpty:model.city]) {
//        localModel.city = model.city;
//    }
//    if (![SCGlobaUtil isEmpty:model.cityId]) {
//        localModel.cityId = model.cityId;
//    }
//    if (![SCGlobaUtil isEmpty:model.pro]) {
//        localModel.pro = model.pro;
//    }
//    if (![SCGlobaUtil isEmpty:model.server]) {
//        localModel.server = model.server;
//    }
//    if (![SCGlobaUtil isEmpty:model.skill]) {
//        localModel.skill = model.skill;
//    }
//    if (![SCGlobaUtil isEmpty:model.status]) {
//        localModel.status = model.status;
//    }
//    if (![SCGlobaUtil isEmpty:model.todayOrderAmout]) {
//        localModel.todayOrderAmout = model.todayOrderAmout;
//    }
//    if (![SCGlobaUtil isEmpty:model.todayOrderNumber]) {
//        localModel.todayOrderNumber = model.todayOrderNumber;
//    }
//    [self setUserInfo:localModel];
//    
//}

+ (NSString *)userToken {
    return [kUserDefaults objectForKey:k_user_token];
}

+ (NSString *)sid {
    return [kUserDefaults objectForKey:k_user_sid];
}

+ (NSString *)city {
    return [kUserDefaults objectForKey:k_user_city];
}

+ (NSString *)cityId {
    return [kUserDefaults objectForKey:k_user_cityId];
}

+ (void)p_clearUserInfo {
    [kUserDefaults removeObjectForKey:k_user_token];
    [kUserDefaults removeObjectForKey:k_user_sid];
    [kUserDefaults removeObjectForKey:k_user_info];
    [kUserDefaults removeObjectForKey:k_user_city];
    [kUserDefaults removeObjectForKey:k_user_cityId];
}

@end




@implementation SCState

+ (NSString *)stringForOrderState:(int)state {
    switch (state) {
        case 0:
            return @"待付款";
            break;
        case 1:
            return @"等待美容师确认";
            break;
        case 2:
            return @"美容师已确认";
            break;
        case 3:
            return @"美容师已出发";
            break;
        case 4:
            return @"服务开始";
            break;
        case 5:
            return @"服务已完成";
            break;
        case 6:
            return @"服务已完成";
            break;
        case 7:
            return @"服务已完成";
            break;
        case 8:
            return @"服务已完成";
            break;
        case 9:
            return @"已取消";
            break;
        case 10:
            return @"待预约";
            break;
        case 11:
            return @"冻结中";
            break;
        default:
            break;
    }
    return @"";
}

//0－未支付 1-已支付，等待出库 2-已出库 3-交易完成（美容师已确认） 9-取消订单
+ (NSString *)stringForCargoOrderState:(int)state {
    switch (state) {
        case 0:
            return @"待付款";
            break;
        case 1:
            return @"等待出库";
            break;
        case 2:
            return @"已出库";
            break;
        case 3:
            return @"交易完成";
            break;
        case 9:
            return @"已取消";
            break;
        default:
            break;
    }
    return @"";
}

@end




