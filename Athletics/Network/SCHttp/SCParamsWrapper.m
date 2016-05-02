//
//  SCParamsWrapper.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/21.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCParamsWrapper.h"

@implementation SCParamsWrapper



#pragma mark - **************************************************************

#pragma mark - app版本更新
/**
 *  app版本更新
 *
 *  @return
 */
+ (NSDictionary *)appUpdateParams {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"version":@([SCGlobaUtil getFloat:version]), @"appId":@"1", @"platform":@"ios"} isDynamic:NO];
    }
    
    return [self salt:@{@"userId":[SCUserInfoManager uid], @"appId":@"", @"platform":@""} isDynamic:NO];}

#pragma mark - 获取游戏列表
/**
 *  获取游戏列表
 *
 *  @return
 */
+ (NSDictionary *)gameListParams {
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return nil;
    }
    return [self salt:@{@"uid":[SCUserInfoManager uid]} isDynamic:NO];
}

#pragma mark - 上传apnsToken
/**
 *  上传apnsToken
 *
 *  @return
 */
+ (NSDictionary *)uploadApnsTokenParamsWithToken:(NSString *)token {
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"token":token, @"idfa":[SCGlobaUtil getIDFA], @"uuid":[SCGlobaUtil getUUID]} isDynamic:NO];
    }
    
    return [self salt:@{@"userId":[SCUserInfoManager uid], @"token":token, @"idfa":[SCGlobaUtil getIDFA], @"uuid":[SCGlobaUtil getUUID]} isDynamic:NO];
}

#pragma mark - 获取banner
/**
 *  获取banner
 *
 *  @return
 */
+ (NSDictionary *)newsBannerListParamsWithChannelId:(NSString *)channelId
                                               type:(int)type {
    if ([SCGlobaUtil isEmpty:channelId]) {
        return nil;
    }
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"channelId":channelId, @"type":@(type)} isDynamic:NO];
    }
    return [self salt:@{@"uid":[SCUserInfoManager uid], @"channelId":channelId, @"type":@(type)} isDynamic:NO];
}

#pragma mark - 我的预约
/**
 *  我的预约
 *
 *  @return
 */
+ (NSDictionary *)appointmentListParamsWithPage:(int)page {
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return nil;
    }
    return [self salt:@{@"uid":[SCUserInfoManager uid],@"page":@(page)} isDynamic:NO];
}

#pragma mark -  *******************    登录找回密码    *********************************
#pragma mark - 注册
/**
 *  注册
 *
 *  @return
 */
+ (NSDictionary *)registerParamsWithMobile:(NSString *)mobile
                                  password:(NSString *)password
                                      code:(NSString *)code {
    if ([SCGlobaUtil isEmpty:mobile] || [SCGlobaUtil isEmpty:password] || [SCGlobaUtil isEmpty:code]) {
        return nil;
    }
    return [self salt:@{@"phone":mobile, @"pwd":password, @"code":code} isDynamic:NO];
}

#pragma mark - 登录
/**
 *  登录
 *
 *  @return
 */
+ (NSDictionary *)loginParamsWithMobile:(NSString *)mobile
                               password:(NSString *)password {
    if ([SCGlobaUtil isEmpty:mobile] || [SCGlobaUtil isEmpty:password]) {
        return nil;
    }
    return [self salt:@{@"mobile":mobile, @"password":password} isDynamic:NO];
}

#pragma mark - 登出
/**
 *  登出
 *
 *  @return
 */
+ (NSDictionary *)logoutParams {
    NSString *uid = [SCUserInfoManager uid];
    if ([SCGlobaUtil isEmpty:uid]) {
        return nil;
    }
    return [self salt:@{@"uid":uid} isDynamic:NO];
}

#pragma mark - userInfo
/**
 *  userInfo
 *
 *  @return
 */
+ (NSDictionary *)userInfoParams {
    NSString *uid = [SCUserInfoManager uid];
    if ([SCGlobaUtil isEmpty:uid]) {
        return nil;
    }
    return [self salt:@{@"uid":uid} isDynamic:NO];
}

#pragma mark - 更新头像和昵称
/**
 *  更新头像和昵称
 *
 *  @return
 */
+ (NSDictionary *)userUpdateInfoParamsWithAvatar:(NSString *)avatar
                                        nickName:(NSString *)nickName {
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return nil;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"uid":[SCUserInfoManager uid]}];
    if (![SCGlobaUtil isEmpty:avatar]) {
        [dict setObject:avatar forKey:@"avatar"];
    }
    if (![SCGlobaUtil isEmpty:nickName]) {
        [dict setObject:nickName forKey:@"name"];
    }
    return [self salt:dict isDynamic:NO];
}

#pragma mark - 举报
/**
 *  举报
 *
 *  @return
 */
+ (NSDictionary *)userReportParamsWithCommentId:(NSString *)commentId
                                           type:(int)type {
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]] || [SCGlobaUtil isEmpty:commentId]) {
        return nil;
    }
    return [self salt:@{@"uid":[SCUserInfoManager uid], @"commentId":commentId, @"type":@(type)} isDynamic:NO];
}

#pragma mark - 发送验证码
/**
 *  发送验证码
 *
 *  @return
 */
+ (NSDictionary *)smsCodeParamsWithMobile:(NSString *)mobile
                                     type:(int)type {
    if ([SCGlobaUtil isEmpty:mobile]) {
        return nil;
    }
    return [self salt:@{@"mobile":mobile, @"funType":@(type)} isDynamic:NO];
}

#pragma mark - 忘记密码
/**
 *  忘记密码
 *
 *  @return
 */
+ (NSDictionary *)userForgetPasswordParamsWithMobile:(NSString *)mobile
                                                code:(NSString *)code
                                         newPassword:(NSString *)newPassword {
    if ([SCGlobaUtil isEmpty:mobile] || [SCGlobaUtil isEmpty:newPassword] || [SCGlobaUtil isEmpty:code]) {
        return nil;
    }
    return [self salt:@{@"mobile":mobile, @"code":code, @"pwd":newPassword} isDynamic:NO];
}

#pragma mark - 修改密码
/**
 *  修改密码
 *
 *  @return
 */
+ (NSDictionary *)userUpdatePasswordParamsWithOldPassword:(NSString *)oldPassword
                                              newPassword:(NSString *)newPassword
                                               confirmPwd:(NSString *)confirmPwd {
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]] || [SCGlobaUtil isEmpty:oldPassword] || [SCGlobaUtil isEmpty:newPassword] || [SCGlobaUtil isEmpty:confirmPwd]) {
        return nil;
    }
    
    return [self salt:@{@"uid":[SCUserInfoManager uid], @"oldPwd":oldPassword, @"newPwd":newPassword, @"confirmedPwd":confirmPwd} isDynamic:NO];
}

#pragma mark - 上传图片
/**
 *  上传图片
 *
 *  @return
 */
+ (NSDictionary *)uploadImageParams {
    return @{};
}

#pragma mark - 获取七牛云上传token
/**
 *  获取七牛云上传token
 *
 *  @return
 */
+ (NSDictionary *)qiNiuTokenParams {
    if (![SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"uid":[SCUserInfoManager uid]} isDynamic:NO];
    }
    return nil;
}

#pragma mark - **************************************************************

#pragma mark - 资讯列表
/**
 *  资讯列表
 *
 *  @return
 */
+ (NSDictionary *)newsListParamsWithChannelId:(NSString *)channelId
                                         page:(int)page {
    if ([SCGlobaUtil isEmpty:channelId]) {
        return nil;
    }
    if (![SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"uid":[SCUserInfoManager uid], @"channelId":channelId, @"page":@(page)} isDynamic:NO];
    }
    return [self salt:@{@"channelId":channelId, @"page":@(page)} isDynamic:NO];
}

#pragma mark - 资讯详情
/**
 *  资讯详情
 *
 *  @return
 */
+ (NSDictionary *)newsInfoParamsWithNewsId:(NSString *)newsId {
    if ([SCGlobaUtil isEmpty:newsId]) {
        return nil;
    }
    if (![SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"uid":[SCUserInfoManager uid], @"nid":newsId} isDynamic:NO];
    }
    return [self salt:@{@"nid":newsId} isDynamic:NO];
}

#pragma mark - 资讯的评论
/**
 *  资讯的评论
 *
 *  @return
 */
+ (NSDictionary *)newsCommentListParamsWithNewsId:(NSString *)newsId
                                             page:(int)page {
    if ([SCGlobaUtil isEmpty:newsId]) {
        return nil;
    }
    if (![SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"uid":[SCUserInfoManager uid], @"nid":newsId, @"page":@(page)} isDynamic:NO];
    }
    return [self salt:@{@"nid":newsId, @"page":@(page)} isDynamic:NO];
}

#pragma mark - 资讯添加评论
/**
 *  资讯添加评论
 *
 *  @return
 */
+ (NSDictionary *)newsCommentAddParamsWithNewsId:(NSString *)newsId
                                         comment:(NSString *)comment {
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]] || [SCGlobaUtil isEmpty:newsId] || [SCGlobaUtil isEmpty:newsId]) {
        return nil;
    }
    return [self salt:@{@"uid":[SCUserInfoManager uid], @"nid":newsId, @"comment":comment} isDynamic:NO];
}

#pragma mark - 为资讯评论点赞
/**
 *  为资讯评论点赞
 *
 *  @return
 */
+ (NSDictionary *)newsCommentClickedParamsWithNewsCommentId:(NSString *)newsCommentId {
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]] || [SCGlobaUtil isEmpty:newsCommentId]) {
        return nil;
    }
    return [self salt:@{@"uid":[SCUserInfoManager uid], @"commentId":newsCommentId} isDynamic:NO];
}

#pragma mark - **************************************************************

#pragma mark - 帖子列表
/**
 *  帖子列表
 *
 *  @return
 */
+ (NSDictionary *)topicListParamsWithChannelId:(NSString *)channelId
                                          type:(int)type
                                          page:(int)page {
    if ([SCGlobaUtil isEmpty:channelId]) {
        return nil;
    }
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"channelId":channelId, @"type":@(type), @"page":@(page)} isDynamic:NO];
    }
    return [self salt:@{@"uid":[SCUserInfoManager uid], @"channelId":channelId, @"type":@(type), @"page":@(page)} isDynamic:NO];
}

#pragma mark - 我的帖子
/**
 *  我的帖子
 *
 *  @return
 */
+ (NSDictionary *)userTopicListParamsWithPage:(int)page {
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return nil;
    }
    return [self salt:@{@"uid":[SCUserInfoManager uid],@"page":@(page)} isDynamic:NO];
}

#pragma mark - 帖子详情
/**
 *  帖子详情
 *
 *  @return
 */
+ (NSDictionary *)topicInfoParamsWithTopicId:(NSString *)topicId {
    if ([SCGlobaUtil isEmpty:topicId]) {
        return nil;
    }
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"topicId":topicId} isDynamic:NO];
    }
    return [self salt:@{@"uid":[SCUserInfoManager uid], @"topicId":topicId} isDynamic:NO];
}

#pragma mark - 帖子评论列表
/**
 *  帖子评论列表
 *
 *  @return
 */
+ (NSDictionary *)topicCommentListParamsWithTopicId:(NSString *)topicId
                                               page:(int)page {
    if ([SCGlobaUtil isEmpty:topicId]) {
        return nil;
    }
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"topicId":topicId, @"num":@(page)} isDynamic:NO];
    }
    return [self salt:@{@"uid":[SCUserInfoManager uid], @"topicId":topicId, @"num":@(page)} isDynamic:NO];
}

#pragma mark - 增加评论
/**
 *  增加评论
 *
 *  @return
 */
+ (NSDictionary *)topicCommentAddParamsWithTopicId:(NSString *)topicId
                                          parentId:(NSString *)parentId
                                           comment:(NSString *)comment
                                         floorSort:(int)floorSort {
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]] || [SCGlobaUtil isEmpty:topicId] ||  [SCGlobaUtil isEmpty:comment] || [SCGlobaUtil isEmpty:topicId]) {
        return nil;
    }
    if (!parentId) {
        return [self salt:@{@"uid":[SCUserInfoManager uid], @"topicId":topicId, @"topicId":topicId,  @"comment":comment, @"floorSort":@(floorSort)} isDynamic:NO];
    }

    return [self salt:@{@"uid":[SCUserInfoManager uid], @"topicId":topicId, @"topicId":topicId, @"provId":parentId, @"comment":comment, @"floorSort":@(floorSort)} isDynamic:NO];
}

#pragma mark - 支持该帖
/**
 *  支持该帖
 *
 *  @return
 */
+ (NSDictionary *)topicLikeAddParamsWithTopicId:(NSString *)topicId {
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]] || [SCGlobaUtil isEmpty:topicId]) {
        return nil;
    }
    
    return [self salt:@{@"uid":[SCUserInfoManager uid], @"topicId":topicId} isDynamic:NO];
}

#pragma mark - 发帖
/**
 *  发帖
 *
 *  @return
 */
+ (NSDictionary *)topicAddParamsWithTitle:(NSString *)title
                                channelId:(NSString *)channelId
                                  content:(NSString *)content
                             imageJsonStr:(NSString *)imageJsonStr {
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]] || [SCGlobaUtil isEmpty:title] || [SCGlobaUtil isEmpty:content]) {
        return nil;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"uid":[SCUserInfoManager uid], @"content":content, @"title":title}];
    if (![SCGlobaUtil isEmpty:imageJsonStr]) {
        [dict setObject:imageJsonStr forKey:@"image"];
    }
    if (![SCGlobaUtil isEmpty:channelId]) {
        [dict setObject:channelId forKey:@"channelId"];
    }
    
    return [self salt:dict isDynamic:NO];
}

#pragma mark - **************************************************************

#pragma mark - 查询赛事
/**
 *  查询赛事
 *
 *  @return
 */
+ (NSDictionary *)matchLiveListParamsWithChannelId:(NSString *)channelId
                                              page:(int)page {
    if ([SCGlobaUtil isEmpty:channelId]) {
        return nil;
    }
    if (![SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"uid":[SCUserInfoManager uid], @"channelId":channelId, @"page":@(page)} isDynamic:NO];
    }
    return [self salt:@{@"channelId":channelId, @"page":@(page)} isDynamic:NO];
}

#pragma mark - 赛事赛程
/**
 *  赛事赛程
 *
 *  @return
 */
+ (NSDictionary *)matchCourseListParamsWithMatchId:(NSString *)matchId
                                              page:(int)page {
    if ([SCGlobaUtil isEmpty:matchId]) {
        return nil;
    }
    if (![SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"uid":[SCUserInfoManager uid], @"matchId":matchId, @"page":@(page)} isDynamic:NO];
    }
    return [self salt:@{@"matchId":matchId, @"page":@(page)} isDynamic:NO];
}

#pragma mark - 查询比赛
/**
 *  查询比赛
 *
 *  @return
 */
+ (NSDictionary *)matchUnitQuaryParamsWithMatchUnitId:(NSString *)matchUnitId {
    if ([SCGlobaUtil isEmpty:matchUnitId]) {
        return nil;
    }
    if (![SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"uid":[SCUserInfoManager uid], @"matchUnitId":matchUnitId} isDynamic:NO];
    }
    return [self salt:@{@"matchUnitId":matchUnitId} isDynamic:NO];
}

#pragma mark - 查询赛况（图文直播）
/**
 *  查询赛况（图文直播）
 *
 *  @return
 */
+ (NSDictionary *)matchUnitliveListParamsWithMatchRondaId:(NSString *)matchRondaId
                                                     page:(int)page {
    if ([SCGlobaUtil isEmpty:matchRondaId]) {
        return nil;
    }
    if (![SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"uid":[SCUserInfoManager uid], @"matchRondaId":matchRondaId, @"page":@(page)} isDynamic:NO];
    }
    return [self salt:@{@"matchRondaId":matchRondaId, @"page":@(page)} isDynamic:NO];
}

#pragma mark - 查询比赛视频
/**
 *  查询比赛视频
 *
 *  @return
 */
+ (NSDictionary *)matchUnitvideoListParamsWithMatchUnitId:(NSString *)matchUnitId
                                                     page:(int)page {
    if ([SCGlobaUtil isEmpty:matchUnitId]) {
        return nil;
    }
    if (![SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"uid":[SCUserInfoManager uid], @"matchUnitId":matchUnitId, @"page":@(page)} isDynamic:NO];
    }
    return [self salt:@{@"matchUnitId":matchUnitId, @"page":@(page)} isDynamic:NO];
}

#pragma mark - 比赛的评论
/**
 *  比赛的评论
 *
 *  @return
 */
+ (NSDictionary *)matchCommentListParamsWithMatchUnitId:(NSString *)matchUnitId
                                                   page:(int)page {
    if ([SCGlobaUtil isEmpty:matchUnitId]) {
        return nil;
    }
    if (![SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"uid":[SCUserInfoManager uid], @"matchUnitId":matchUnitId, @"page":@(page)} isDynamic:NO];
    }
    return [self salt:@{@"matchUnitId":matchUnitId, @"page":@(page)} isDynamic:NO];
}

#pragma mark - 评论比赛
/**
 *  评论比赛
 *
 *  @return
 */
+ (NSDictionary *)matchCommentAddParamsWithMatchUnitId:(NSString *)matchUnitId
                                               comment:(NSString *)comment {
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]] || [SCGlobaUtil isEmpty:matchUnitId] || [SCGlobaUtil isEmpty:comment]) {
        return nil;
    }
    return [self salt:@{@"uid":[SCUserInfoManager uid], @"matchUnitId":matchUnitId, @"comment":comment} isDynamic:NO];
}

#pragma mark - 比赛评论点赞
/**
 *  比赛评论点赞
 *
 *  @return
 */
+ (NSDictionary *)matchCommentLikeParamsWithMatchUnitId:(NSString *)matchUnitId {
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]] || [SCGlobaUtil isEmpty:matchUnitId]) {
        return nil;
    }
    return [self salt:@{@"uid":[SCUserInfoManager uid], @"matchUnitId":matchUnitId} isDynamic:NO];
}

#pragma mark - 赛事预约
/**
 *  赛事预约
 *
 *  @return
 */
+ (NSDictionary *)matchAppointmentAddParamsWithMatchUnitId:(NSString *)matchUnitId
                                                      type:(int)type {
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]] || [SCGlobaUtil isEmpty:matchUnitId]) {
        return nil;
    }
    return [self salt:@{@"uid":[SCUserInfoManager uid], @"matchUnitId":matchUnitId, @"type":@(type)} isDynamic:NO];
}

#pragma mark - **************************************************************

#pragma mark - 查询赛事栏目视频
/**
 *  查询赛事栏目视频
 *
 *  @return
 */
+ (NSDictionary *)matchVideoListParamsWithChannelId:(NSString *)channelId
                                               type:(int)type
                                               page:(int)page {
    if ([SCGlobaUtil isEmpty:channelId]) {
        return nil;
    }
    if (![SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"uid":[SCUserInfoManager uid], @"channelId":channelId, @"type":@(type), @"page":@(page)} isDynamic:NO];
    }
    return [self salt:@{@"channelId":channelId, @"type":@(type), @"page":@(page)} isDynamic:NO];
}

#pragma mark - 查询赛事视频详情
/**
 *  查询赛事视频详情
 *
 *  @return
 */
+ (NSDictionary *)matchVideoDetailParamsWithVideoId:(NSString *)videoId {
    if ([SCGlobaUtil isEmpty:videoId]) {
        return nil;
    }
    if (![SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"uid":[SCUserInfoManager uid], @"videoId":videoId} isDynamic:NO];
    }
    return [self salt:@{@"videoId":videoId} isDynamic:NO];
}

#pragma mark - 当前视频相关视频
/**
 *  当前视频相关视频
 *
 *  @return
 */
+ (NSDictionary *)matchVideoRelatedListParamsWithVideoId:(NSString *)videoId {
    if ([SCGlobaUtil isEmpty:videoId]) {
        return nil;
    }
    if (![SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"uid":[SCUserInfoManager uid], @"videoId":videoId} isDynamic:NO];
    }
    return [self salt:@{@"videoId":videoId} isDynamic:NO];
}

#pragma mark - 当前视频评论
/**
 *  当前视频评论
 *
 *  @return
 */
+ (NSDictionary *)matchVideoCommentListParamsWithVideoId:(NSString *)videoId
                                                    page:(int)page {
    if ([SCGlobaUtil isEmpty:videoId]) {
        return nil;
    }
    if (![SCGlobaUtil isEmpty:[SCUserInfoManager uid]]) {
        return [self salt:@{@"uid":[SCUserInfoManager uid], @"videoId":videoId, @"page":@(page)} isDynamic:NO];
    }
    return [self salt:@{@"videoId":videoId, @"page":@(page)} isDynamic:NO];
}

#pragma mark - 评论当前视频
/**
 *  评论当前视频
 *
 *  @return
 */
+ (NSDictionary *)matchVideoCommentAddParamsWithVideoId:(NSString *)videoId
                                                comment:(NSString *)comment {
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]] || [SCGlobaUtil isEmpty:videoId] || [SCGlobaUtil isEmpty:comment]) {
        return nil;
    }
    return [self salt:@{@"uid":[SCUserInfoManager uid], @"videoId":videoId, @"comment":comment} isDynamic:NO];
}

#pragma mark - 对当前评论点赞
/**
 *  对当前评论点赞
 *
 *  @return
 */
+ (NSDictionary *)matchVideoCommentLikeParamsWithVideoCommentId:(NSString *)videoCommentId {
    if ([SCGlobaUtil isEmpty:[SCUserInfoManager uid]] || [SCGlobaUtil isEmpty:videoCommentId]) {
        return nil;
    }
    return [self salt:@{@"uid":[SCUserInfoManager uid], @"videoCommentId":videoCommentId} isDynamic:NO];
}






#pragma mark -  *******************    Private    *********************************

#pragma mark - Private

+ (NSDictionary *)salt:(NSDictionary *)params isDynamic:(BOOL)isDynamic {
    if (![SCGlobaUtil isInvalidDict:params]) {
        return nil;
    }
    return params;
}

+ (NSDictionary *)p_salt:(NSDictionary *)params isDynamic:(BOOL)isDynamic {
    if (![SCGlobaUtil isInvalidDict:params]) {
        return nil;
    }
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[params count]];
    for (NSString *key in params) {
        NSString *str = [NSString stringWithFormat:@"%@=%@", key, params[key]];
        [array addObject:str];
    }
    // 排序，按自然排序
    NSArray *sortedArray = [array sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    // 用&连接
    NSString *sortedString = [sortedArray componentsJoinedByString:@"&"];
    
//    if (isDynamic) {
//        NSString *dynamicSalt = [SCUserInfoManager userToken];
//        if ([SCGlobaUtil isEmpty:dynamicSalt]) {
//            NSLog(@"动态加密字符串为空，请注意！！！！");
//        } else {
//            sortedString = [NSString stringWithFormat:@"%@&%@", sortedString, dynamicSalt];
//        }
//    } else {
//        sortedString = [NSString stringWithFormat:@"%@&%@", sortedString, kFixedSalt];
//    }
    // md5加密
    sortedString = [SCGlobaUtil md5:sortedString];
    NSMutableDictionary *result = [params mutableCopy];
    [result setObject:sortedString forKey:@"salt"];
    
    return result;
}

@end
