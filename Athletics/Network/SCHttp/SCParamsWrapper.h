//
//  SCParamsWrapper.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/21.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCParamsWrapper : NSObject

#pragma mark - **************************************************************

#pragma mark - app版本更新
/**
 *  app版本更新
 *
 *  @return
 */
+ (NSDictionary *)appUpdateParams;


#pragma mark - **************************************************************
#pragma mark - 注册
/**
 *  注册
 *
 *  @return
 */
+ (NSDictionary *)registerParamsWithMobile:(NSString *)mobile
                                  password:(NSString *)password
                                      code:(NSString *)code;

#pragma mark - 登录
/**
 *  登录
 *
 *  @return
 */
+ (NSDictionary *)loginParamsWithMobile:(NSString *)mobile
                               password:(NSString *)password;

#pragma mark - 登出
/**
 *  登出
 *
 *  @return
 */
+ (NSDictionary *)logoutParams;

#pragma mark - userInfo
/**
 *  userInfo
 *
 *  @return
 */
+ (NSDictionary *)userInfoParams;

#pragma mark - 更新头像和昵称
/**
 *  更新头像和昵称
 *
 *  @return
 */
+ (NSDictionary *)userUpdateInfoParamsWithAvatar:(NSString *)avatar
                                        nickName:(NSString *)nickName;

#pragma mark - 发送验证码
/**
 *  发送验证码
 *
 *  @param mobile 手机号
 *  @param type   类型 1 注册  2忘记密码
 *
 *  @return
 */
+ (NSDictionary *)smsCodeParamsWithMobile:(NSString *)mobile
                                     type:(int)type;

#pragma mark - 忘记密码
/**
 *  忘记密码
 *
 *  @return
 */
+ (NSDictionary *)userForgetPasswordParamsWithMobile:(NSString *)mobile
                                                code:(NSString *)code
                                         newPassword:(NSString *)newPassword;

#pragma mark - 修改密码
/**
 *  修改密码
 *
 *  @return
 */
+ (NSDictionary *)userUpdatePasswordParamsWithOldPassword:(NSString *)oldPassword
                                              newPassword:(NSString *)newPassword
                                               confirmPwd:(NSString *)confirmPwd;

#pragma mark - 上传图片
/**
 *  上传图片
 *
 *  @return
 */
+ (NSDictionary *)uploadImageParams;

#pragma mark - **************************************************************

#pragma mark - 获取游戏列表
/**
 *  获取游戏列表
 *
 *  @return
 */
+ (NSDictionary *)gameListParams;

#pragma mark - **************************************************************

#pragma mark - 资讯列表
/**
 *  资讯列表
 *
 *  @return
 */
+ (NSDictionary *)newsListParamsWithChannelId:(NSString *)channelId
                                         page:(int)page;

#pragma mark - 资讯详情
/**
 *  资讯详情
 *
 *  @return
 */
+ (NSDictionary *)newsInfoParamsWithNewsId:(NSString *)newsId;

#pragma mark - 资讯的评论
/**
 *  资讯的评论
 *
 *  @return
 */
+ (NSDictionary *)newsCommentListParamsWithNewsId:(NSString *)newsId
                                             page:(int)page;

#pragma mark - 资讯添加评论
/**
 *  资讯添加评论
 *
 *  @return
 */
+ (NSDictionary *)newsCommentAddParamsWithNewsId:(NSString *)newsId
                                         comment:(NSString *)comment;

#pragma mark - 为资讯评论点赞
/**
 *  为资讯评论点赞
 *
 *  @return
 */
+ (NSDictionary *)newsCommentClickedParamsWithNewsCommentId:(NSString *)newsCommentId;

#pragma mark - **************************************************************




#pragma mark - **************************************************************

#pragma mark - 查询赛事
/**
 *  查询赛事
 *
 *  @return
 */
+ (NSDictionary *)matchLiveListParamsWithChannelId:(NSString *)channelId
                                              page:(int)page;

#pragma mark - 赛事赛程
/**
 *  赛事赛程
 *
 *  @return
 */
+ (NSDictionary *)matchCourseListParamsWithMatchId:(NSString *)matchId
                                              page:(int)page;

#pragma mark - 查询比赛
/**
 *  查询比赛
 *
 *  @return
 */
+ (NSDictionary *)matchUnitQuaryParamsWithMatchUnitId:(NSString *)matchUnitId;

#pragma mark - 查询赛况（图文直播）
/**
 *  查询赛况（图文直播）
 *
 *  @return
 */
+ (NSDictionary *)matchUnitliveListParamsWithMatchRondaId:(NSString *)matchRondaId
                                                     page:(int)page;

#pragma mark - 查询比赛视频
/**
 *  查询比赛视频
 *
 *  @return
 */
+ (NSDictionary *)matchUnitvideoListParamsWithMatchUnitId:(NSString *)matchUnitId
                                                     page:(int)page;

#pragma mark - 比赛的评论
/**
 *  比赛的评论
 *
 *  @return
 */
+ (NSDictionary *)matchCommentListParamsWithMatchUnitId:(NSString *)matchUnitId
                                                   page:(int)page;

#pragma mark - 评论比赛
/**
 *  评论比赛
 *
 *  @return
 */
+ (NSDictionary *)matchCommentAddParamsWithMatchUnitId:(NSString *)matchUnitId
                                               comment:(NSString *)comment;

#pragma mark - **************************************************************

#pragma mark - 查询赛事栏目视频
/**
 *  查询赛事栏目视频
 *
 *  @return
 */
+ (NSDictionary *)matchVideoListParamsWithChannelId:(NSString *)channelId
                                               type:(int)type
                                               page:(int)page;

#pragma mark - 查询赛事视频详情
/**
 *  查询赛事视频详情
 *
 *  @return
 */
+ (NSDictionary *)matchVideoDetailParamsWithVideoId:(NSString *)videoId;

#pragma mark - 当前视频相关视频
/**
 *  当前视频相关视频
 *
 *  @return
 */
+ (NSDictionary *)matchVideoRelatedListParamsWithVideoId:(NSString *)videoId;

#pragma mark - 当前视频评论
/**
 *  当前视频评论
 *
 *  @return
 */
+ (NSDictionary *)matchVideoCommentListParamsWithVideoId:(NSString *)videoId
                                                    page:(int)page;

#pragma mark - 评论当前视频
/**
 *  评论当前视频
 *
 *  @return
 */
+ (NSDictionary *)matchVideoCommentAddParamsWithVideoId:(NSString *)videoId
                                                comment:(NSString *)comment;

#pragma mark - 对当前评论点赞
/**
 *  对当前评论点赞
 *
 *  @return
 */
+ (NSDictionary *)matchVideoCommentLikeParamsWithVideoCommentId:(NSString *)videoCommentId;






@end
