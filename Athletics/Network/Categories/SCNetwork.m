//
//  SCNetwork.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNetwork.h"
#import "SCUrlWrapper.h"
#import "SCParamsWrapper.h"

#import "SCGameListModel.h"
#import "SCLoginModel.h"
#import "SCUserInfoModel.h"
#import "SCUploadTokenModel.h"
#import "SCAppUpdateModel.h"
#import "SCGameListModel.h"
#import "SCNewsBannerListModel.h"
#import "SCMatchListModel.h"

@implementation SCNetwork
#pragma mark - 注册
/**
 *  注册
 *
 *  @param phone    手机号
 *  @param password 密码
 *  @param code     验证码
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)registerWithPhone:(NSString *)phone
                                   password:(NSString *)password
                                       code:(NSString *)code
                                    success:(void(^)(SCLoginModel *model))success
                                    message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper registerUrl] params:[SCParamsWrapper registerParamsWithMobile:phone password:password code:code] success:^(NSDictionary *result) {
        NSError *error;
        SCLoginModel *model = [[SCLoginModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

#pragma mark - 登录
/**
 *  登录
 *
 *  @param phone    手机号
 *  @param password 密码
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)loginWithPhone:(NSString *)phone
                                password:(NSString *)password
                                 success:(void(^)(SCLoginModel *model))success
                                 message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper loginUrl] params:[SCParamsWrapper loginParamsWithMobile:phone password:password] success:^(NSDictionary *result) {
        NSError *error;
        SCLoginModel *model = [[SCLoginModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

#pragma mark - 登出
/**
 *  登出
 *
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)logoutSuccess:(void(^)(SCResponseModel *model))success
                                message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper logoutUrl] params:[SCParamsWrapper logoutParams] success:^(NSDictionary *result) {
        NSError *error;
        SCResponseModel *model = [[SCResponseModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

#pragma mark - userInfo
/**
 *  userInfo
 *
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)userInfoSuccess:(void(^)(SCUserInfoModel *model))success
                                  message:(SCMessageBlock)message {
    return [SCNetworkHelper getWithUrl:[SCUrlWrapper userInfoUrl] params:[SCParamsWrapper userInfoParams] success:^(NSDictionary *result) {
        NSError *error;
        SCUserInfoModel *model = [[SCUserInfoModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

#pragma mark - 发送验证码
/**
 *  发送验证码
 *
 *  @param phone   手机号
 *  @param type    1注册, 2忘记密码
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)smsCodeWithPhone:(NSString *)phone
                                      type:(int)type
                                   success:(void(^)(SCResponseModel *model))success
                                   message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper smsCodeUrl] params:[SCParamsWrapper smsCodeParamsWithMobile:phone type:type] success:^(NSDictionary *result) {
        NSError *error;
        SCResponseModel *model = [[SCResponseModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

#pragma mark - 忘记密码
/**
 *  忘记密码
 *
 *  @param phone      手机号
 *  @param newPwd     新密码
 *  @param confirmPwd 确认密码
 *  @param code       验证码
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)userForgetPwdWithPhone:(NSString *)phone
                                          newPwd:(NSString *)newPwd
                                        authCode:(NSString *)code
                                         success:(void(^)(SCLoginModel *model))success
                                         message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper userForgetPasswordUrl] params:[SCParamsWrapper userForgetPasswordParamsWithMobile:phone code:code newPassword:newPwd] success:^(NSDictionary *result) {
        NSError *error;
        SCLoginModel *model = [[SCLoginModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

#pragma mark - 修改密码
/**
 *  修改密码
 *
 *  @param oldPwd     旧密码
 *  @param newPwd     新密码
 *  @param confirmPwd 确认密码
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)userUpdatePwdWithOldPwd:(NSString *)oldPwd
                                           newPwd:(NSString *)newPwd
                                       confirmPwd:(NSString *)confirmPwd
                                          success:(void(^)(SCLoginModel *model))success
                                          message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper userUpdatePasswordUrl] params:[SCParamsWrapper userUpdatePasswordParamsWithOldPassword:oldPwd newPassword:newPwd confirmPwd:confirmPwd] success:^(NSDictionary *result) {
        NSError *error;
        SCLoginModel *model = [[SCLoginModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

#pragma mark - 更新头像和昵称
/**
 *  更新头像和昵称
 *
 *  @param avatar   头像
 *  @param nickName 昵称
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)userUpdateWithAvatar:(NSString *)avatar
                                      nickname:(NSString *)nickName
                                       success:(void(^)(SCResponseModel *model))success
                                       message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper userUpdateInfoUrl] params:[SCParamsWrapper userUpdateInfoParamsWithAvatar:avatar nickName:nickName] success:^(NSDictionary *result) {
        NSError *error;
        SCResponseModel *model = [[SCResponseModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

#pragma mark - 举报
/**
 *  举报
 *
 *  @param commentId 评论的id
 *  @param type      类型
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)userReportWithCommentId:(NSString *)commentId
                                             type:(int)type
                                          success:(void(^)(SCResponseModel *model))success
                                          message:(SCMessageBlock)message; {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper userReportUrl] params:[SCParamsWrapper userReportParamsWithCommentId:commentId type:type] success:^(NSDictionary *result) {
        NSError *error;
        SCResponseModel *model = [[SCResponseModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

#pragma mark - 上传图片
/**
 *  上传图片
 *
 *  @param image   图片
 *  @param type    上传图片type
 *  @param success
 *  @param message
 */
- (NSURLSessionDataTask *)uploadImageWithImage:(UIImage *)image
                                          type:(NSString *)type
                                       success:(void (^)(SCResponseModel *model))success
                                       message:(SCMessageBlock)message {
    return [SCNetworkHelper uploadImageWithUrl:[SCUrlWrapper uploadImageUrl] image:image imageType:type success:^(NSDictionary *result) {
        NSError *error;
        SCResponseModel *model = [[SCResponseModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

#pragma mark - 获取game列表
/**
 *  获取game列表
 *
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)gameListSuccess:(void(^)(SCGameListModel *model))success
                                  message:(SCMessageBlock)message {
    return [SCNetworkHelper getWithUrl:[SCUrlWrapper gameListUrl] params:[SCParamsWrapper gameListParams] success:^(NSDictionary *result) {
        NSError *error;
        SCGameListModel *model = [[SCGameListModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

#pragma mark - 获取七牛云上传token
/**
 *  获取七牛云上传token
 *
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)getUploadTokenWithSuccess:(void(^)(SCUploadTokenModel *model))success
                                            message:(SCMessageBlock)message {
    return [SCNetworkHelper getWithUrl:[SCUrlWrapper qiNiuTokenUrl] params:[SCParamsWrapper qiNiuTokenParams] success:^(NSDictionary *result) {
        NSError *error;
        SCUploadTokenModel *model = [[SCUploadTokenModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

#pragma mark - app版本更新
/**
 *  app版本更新
 *
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)appUpdateWithSuccess:(void(^)(SCAppUpdateModel *model))success
                                       message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper appUpdateUrl] params:[SCParamsWrapper appUpdateParams] success:^(NSDictionary *result) {
        NSError *error;
        SCAppUpdateModel *model = [[SCAppUpdateModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

#pragma mark - 获取游戏列表
/**
 *  获取游戏列表
 *
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)gameListWithSuccess:(void(^)(SCGameListModel *model))success
                                      message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper gameListUrl] params:[SCParamsWrapper gameListParams] success:^(NSDictionary *result) {
        NSError *error;
        SCGameListModel *model = [[SCGameListModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

#pragma mark - 上传apnsToken
/**
 *  上传apnsToken
 *
 *  @param token   token
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)uploadApnsTokenWithToken:(NSString *)token
                                           success:(void(^)(SCResponseModel *model))success
                                             message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper uploadApnsTokenUrl] params:[SCParamsWrapper uploadApnsTokenParamsWithToken:token] success:^(NSDictionary *result) {
        NSError *error;
        SCResponseModel *model = [[SCResponseModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

#pragma mark - 获取banner
/**
 *  获取banner
 *
 *  @param channelId 频道列表
 *  @param type      类型   1.资讯  2.帖子   3.赛事    4.视频
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)newsBannerListWithChannelId:(NSString *)channelId
                                                 type:(int)type
                                              success:(void(^)(SCNewsBannerListModel *model))success
                                              message:(SCMessageBlock)message {
    return [SCNetworkHelper getWithUrl:[SCUrlWrapper newsBannerListUrl] params:[SCParamsWrapper newsBannerListParamsWithChannelId:channelId type:type] success:^(NSDictionary *result) {
        NSError *error;
        SCNewsBannerListModel *model = [[SCNewsBannerListModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

#pragma mark - 我的预约
/**
 *  我的预约
 *
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)appointmentListWithSuccess:(void(^)(SCMatchListModel *model))success
                                                      message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper appointmentListUrl] params:[SCParamsWrapper appointmentListParams] success:^(NSDictionary *result) {
        NSError *error;
        SCMatchListModel *model = [[SCMatchListModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}


@end
