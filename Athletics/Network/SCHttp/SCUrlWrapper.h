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

#pragma mark - 获取游戏列表
/**
 *  获取游戏列表
 *
 *  @return
 */
+ (NSString *)gameListUrl;

#pragma mark - app版本更新
/**
 *  app版本更新
 *
 *  @return
 */
+ (NSString *)appUpdateUrl;

#pragma mark - 上传apnsToken
/**
 *  上传apnsToken
 *
 *  @return
 */
+ (NSString *)uploadApnsTokenUrl;

#pragma mark - 获取banner
/**
 *  获取banner
 *
 *  @return
 */
+ (NSString *)newsBannerListUrl;

#pragma mark - **************************************************************
#pragma mark - 注册
/**
 *  注册
 *
 *  @return
 */
+ (NSString *)registerUrl;

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

#pragma mark - userInfo
/**
 *  userInfo
 *
 *  @return
 */
+ (NSString *)userInfoUrl;

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

#pragma mark - 更新头像和昵称
/**
 *  更新头像和昵称
 *
 *  @return
 */
+ (NSString *)userUpdateInfoUrl;

#pragma mark - 举报
/**
 *  举报
 *
 *  @return
 */
+ (NSString *)userReportUrl;

#pragma mark - 上传图片
/**
 *  上传图片
 *
 *  @return
 */
+ (NSString *)uploadImageUrl;

#pragma mark - 获取七牛云上传token
/**
 *  获取七牛云上传token
 *
 *  @return
 */
+ (NSString *)qiNiuTokenUrl;

#pragma mark - 我的预约
/**
 *  我的预约
 *
 *  @return
 */
+ (NSString *)appointmentListUrl;

#pragma mark - **************************************************************

#pragma mark - 资讯列表
/**
 *  资讯列表
 *
 *  @return
 */
+ (NSString *)newsListUrl;

#pragma mark - 资讯详情
/**
 *  资讯详情
 *
 *  @return
 */
+ (NSString *)newsInfoUrl;

#pragma mark - 资讯的评论
/**
 *  资讯的评论
 *
 *  @return
 */
+ (NSString *)newsCommentListUrl;

#pragma mark - 资讯添加评论
/**
 *  资讯添加评论
 *
 *  @return
 */
+ (NSString *)newsCommentAddUrl;

#pragma mark - 为资讯评论点赞
/**
 *  为资讯评论点赞
 *
 *  @return
 */
+ (NSString *)newsCommentClickedUrl;
#pragma mark - **************************************************************

#pragma mark - 帖子列表
/**
 *  帖子列表
 *
 *  @return
 */
+ (NSString *)topicListUrl;

#pragma mark - 我的帖子
/**
 *  我的帖子
 *
 *  @return
 */
+ (NSString *)userTopicListUrl;

#pragma mark - 帖子详情
/**
 *  帖子详情
 *
 *  @return
 */
+ (NSString *)topicInfoUrl;

#pragma mark - 帖子评论列表
/**
 *  帖子评论列表
 *
 *  @return
 */
+ (NSString *)topicCommentListUrl;

#pragma mark - 增加评论
/**
 *  增加评论
 *
 *  @return
 */
+ (NSString *)topicCommentAddUrl;

#pragma mark - 支持该帖
/**
 *  支持该帖
 *
 *  @return
 */
+ (NSString *)topicLikeAddUrl;

#pragma mark - 发帖
/**
 *  发帖
 *
 *  @return
 */
+ (NSString *)topicAddUrl;


#pragma mark - **************************************************************


#pragma mark - 赛事banner
/**
 *   赛事banner
 *
 *  @return
 */
+ (NSString *)matchBannerUrl;

#pragma mark - 查询赛事
/**
 *  查询赛事
 *
 *  @return
 */
+ (NSString *)matchLiveListUrl;

#pragma mark - 赛事赛程
/**
 *  赛事赛程
 *
 *  @return
 */
+ (NSString *)matchCourseListUrl;

#pragma mark - 查询比赛
/**
 *  查询比赛
 *
 *  @return
 */
+ (NSString *)matchUnitQuaryUrl;

#pragma mark - 查询赛况（图文直播）
/**
 *  查询赛况（图文直播）
 *
 *  @return
 */
+ (NSString *)matchUnitliveListUrl;

#pragma mark - 查询比赛视频
/**
 *  查询比赛视频
 *
 *  @return
 */
+ (NSString *)matchUnitvideoListUrl;

#pragma mark - 比赛的评论
/**
 *  比赛的评论
 *
 *  @return
 */
+ (NSString *)matchCommentListUrl;

#pragma mark - 评论比赛
/**
 *  评论比赛
 *
 *  @return
 */
+ (NSString *)matchCommentAddUrl;

#pragma mark - 赛事预约
/**
 *  赛事预约
 *
 *  @return
 */
+ (NSString *)matchAppointmentAddUrl;

#pragma mark - **************************************************************

#pragma mark - 查询赛事栏目视频
/**
 *  查询赛事栏目视频
 *
 *  @return
 */
+ (NSString *)matchVideoListUrl;

#pragma mark - 查询赛事视频详情
/**
 *  查询赛事视频详情
 *
 *  @return
 */
+ (NSString *)matchVideoDetailUrl;

#pragma mark - 当前视频相关视频
/**
 *  当前视频相关视频
 *
 *  @return
 */
+ (NSString *)matchVideoRelatedListUrl;

#pragma mark - 当前视频评论
/**
 *  当前视频评论
 *
 *  @return
 */
+ (NSString *)matchVideoCommentListUrl;

#pragma mark - 评论当前视频
/**
 *  评论当前视频
 *
 *  @return
 */
+ (NSString *)matchVideoCommentAddUrl;

#pragma mark - 对当前评论点赞
/**
 *  对当前评论点赞
 *
 *  @return
 */
+ (NSString *)matchVideoCommentLikeUrl;



@end
