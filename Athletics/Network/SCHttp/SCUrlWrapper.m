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

#pragma mark - 获取游戏列表
/**
 *  获取游戏列表
 *
 *  @return
 */
+ (NSString *)gameListUrl {
    return [self p_wrap:@"/static/channel/list"];
}

#pragma mark - app版本更新
/**
 *  app版本更新
 *
 *  @return
 */
+ (NSString *)appUpdateUrl {
    return [self p_wrap:@"/static/package/version"];
}
#pragma mark - 意见反馈
/**
 *  意见反馈
 *
 *  @return
 */
+ (NSString *)feedbackUrl{
    return [self p_wrap:@"/static/feedback"];
}

#pragma mark - 上传apnsToken
/**
 *  上传apnsToken
 *
 *  @return
 */
+ (NSString *)uploadApnsTokenUrl {
    return [self p_wrap:@"/static/apns/token"];
}

#pragma mark - 获取banner
/**
 *  获取banner
 *
 *  @return
 */
+ (NSString *)newsBannerListUrl {
    return [self p_wrap:@"/static/banner/list"];
}

#pragma mark - **************************************************************
#pragma mark - 注册
/**
 *  注册
 *
 *  @return
 */
+ (NSString *)registerUrl {
    return [self p_wrap:@"/user/register"];
}

#pragma mark - 登录
/**
 *  登录
 *
 *  @return
 */
+ (NSString *)loginUrl {
    return [self p_wrap:@"/user/login"];
}

#pragma mark - 登出
/**
 *  登出
 *
 *  @return
 */
+ (NSString *)logoutUrl {
    return [self p_wrap:@"/user/logout"];
}

#pragma mark - userInfo
/**
 *  userInfo
 *
 *  @return
 */
+ (NSString *)userInfoUrl {
    return [self p_wrap:@"/user/info"];
}

#pragma mark - 发送验证码
/**
 *  发送验证码
 *
 *  @return
 */
+ (NSString *)smsCodeUrl {
    return [self p_wrap:@"/user/send/message"];
}

#pragma mark - 忘记密码
/**
 *  忘记密码
 *
 *  @return
 */
+ (NSString *)userForgetPasswordUrl {
    return [self p_wrap:@"/user/password/forgot"];
}

#pragma mark - 修改密码
/**
 *  修改密码
 *
 *  @return
 */
+ (NSString *)userUpdatePasswordUrl {
    return [self p_wrap:@"/user/password/update"];
}

#pragma mark - 更新头像和昵称
/**
 *  更新头像和昵称
 *
 *  @return
 */
+ (NSString *)userUpdateInfoUrl {
    return [self p_wrap:@"/user/update"];
}

#pragma mark - 举报
/**
 *  举报
 *
 *  @return
 */
+ (NSString *)userReportUrl {
    return [self p_wrap:@"/static/user/report"];
}

#pragma mark - 上传图片
/**
 *  上传图片
 *
 *  @return
 */
+ (NSString *)uploadImageUrl {
    return [self p_wrap:@"/account/master/password/update"];
}

#pragma mark - 获取七牛云上传token
/**
 *  获取七牛云上传token
 *
 *  @return
 */
+ (NSString *)qiNiuTokenUrl {
    return [self p_wrap:@"/static/getUploadPictureToken"];
}

#pragma mark - 我的预约
/**
 *  我的预约
 *
 *  @return
 */
+ (NSString *)appointmentListUrl {
    return [self p_wrap:@"/user/appointment/list"];
}

#pragma mark - **************************************************************

#pragma mark - 资讯列表
/**
 *  资讯列表
 *
 *  @return
 */
+ (NSString *)newsListUrl {
    return [self p_wrap:@"/news/list"];
}

#pragma mark - 资讯详情
/**
 *  资讯详情
 *
 *  @return
 */
+ (NSString *)newsInfoUrl {
    return [self p_wrap:@"/news/info"];
}

#pragma mark - 资讯的评论
/**
 *  资讯的评论
 *
 *  @return
 */
+ (NSString *)newsCommentListUrl {
    return [self p_wrap:@"/news/comment"];
}

#pragma mark - 资讯添加评论
/**
 *  资讯添加评论
 *
 *  @return
 */
+ (NSString *)newsCommentAddUrl {
    return [self p_wrap:@"/news/comment/add"];
}

#pragma mark - 为资讯评论点赞
/**
 *  为资讯评论点赞
 *
 *  @return
 */
+ (NSString *)newsCommentClickedUrl {
    return [self p_wrap:@"/news/comment/click"];
}

#pragma mark - **************************************************************

#pragma mark - 帖子列表
/**
 *  帖子列表
 *
 *  @return
 */
+ (NSString *)topicListUrl {
    return [self p_wrap:@"/topic/list"];
}

#pragma mark - 我的帖子
/**
 *  我的帖子
 *
 *  @return
 */
+ (NSString *)userTopicListUrl {
    return [self p_wrap:@"/topic/list/user"];
}

#pragma mark - 帖子详情
/**
 *  帖子详情
 *
 *  @return
 */
+ (NSString *)topicInfoUrl {
    return [self p_wrap:@"/topic/info"];
}

#pragma mark - 帖子评论列表
/**
 *  帖子评论列表
 *
 *  @return
 */
+ (NSString *)topicCommentListUrl {
    return [self p_wrap:@"/topic/comment/list"];
}

#pragma mark - 增加评论
/**
 *  增加评论
 *
 *  @return
 */
+ (NSString *)topicCommentAddUrl {
    return [self p_wrap:@"/topic/comment/add"];
}

#pragma mark - 支持该帖
/**
 *  支持该帖
 *
 *  @return
 */
+ (NSString *)topicLikeAddUrl {
    return [self p_wrap:@"/topic/like/add"];
}

#pragma mark - 发帖
/**
 *  发帖
 *
 *  @return
 */
+ (NSString *)topicAddUrl {
    return [self p_wrap:@"/topic/add"];
}

#pragma mark - **************************************************************

#pragma mark - 赛事banner
/**
 *   赛事banner
 *
 *  @return
 */
+ (NSString *)matchBannerUrl {
    return [self p_wrap:@"/match/banner"];
}

#pragma mark - 查询赛事
/**
 *  查询赛事
 *
 *  @return
 */
+ (NSString *)matchLiveListUrl {
    return [self p_wrap:@"/match/match/list"];
}

#pragma mark - 赛事赛程
/**
 *  赛事赛程
 *
 *  @return
 */
+ (NSString *)matchCourseListUrl {
    return [self p_wrap:@"/match/course/list"];
}

#pragma mark - 查询比赛
/**
 *  查询比赛
 *
 *  @return
 */
+ (NSString *)matchUnitQuaryUrl {
    return [self p_wrap:@"/match/unit/query"];
}

#pragma mark - 查询赛况（图文直播）
/**
 *  查询赛况（图文直播）
 *
 *  @return
 */
+ (NSString *)matchUnitliveListUrl {
    return [self p_wrap:@"/match/unit/live/list"];
}

#pragma mark - 查询比赛视频
/**
 *  查询比赛视频
 *
 *  @return
 */
+ (NSString *)matchUnitvideoListUrl {
    return [self p_wrap:@"/match/unit/video/list"];
}

#pragma mark - 比赛的评论
/**
 *  比赛的评论
 *
 *  @return
 */
+ (NSString *)matchCommentListUrl {
    return [self p_wrap:@"/match/comment/list"];
}

#pragma mark - 评论比赛
/**
 *  评论比赛
 *
 *  @return
 */
+ (NSString *)matchCommentAddUrl {
    return [self p_wrap:@"/match/comment/add"];
}

#pragma mark - 比赛评论点赞
/**
 *  比赛评论点赞
 *
 *  @return
 */
+ (NSString *)matchCommentLikeUrl {
    return [self p_wrap:@"/match/comment/like/add"];
}

#pragma mark - 赛事预约
/**
 *  赛事预约
 *
 *  @return
 */
+ (NSString *)matchAppointmentAddUrl {
    return [self p_wrap:@"/match/appointment/add"];
}

#pragma mark - **************************************************************

#pragma mark - 查询赛事栏目视频
/**
 *  查询赛事栏目视频
 *
 *  @return
 */
+ (NSString *)matchVideoListUrl {
    return [self p_wrap:@"/video/list"];
}

#pragma mark - 查询赛事视频详情
/**
 *  查询赛事视频详情
 *
 *  @return
 */
+ (NSString *)matchVideoDetailUrl {
    return [self p_wrap:@"/video/query"];
}

#pragma mark - 当前视频相关视频
/**
 *  当前视频相关视频
 *
 *  @return
 */
+ (NSString *)matchVideoRelatedListUrl {
    return [self p_wrap:@"/video/tag/list"];
}

#pragma mark - 当前视频评论
/**
 *  当前视频评论
 *
 *  @return
 */
+ (NSString *)matchVideoCommentListUrl {
    return [self p_wrap:@"/video/comment/list"];
}

#pragma mark - 评论当前视频
/**
 *  评论当前视频
 *
 *  @return
 */
+ (NSString *)matchVideoCommentAddUrl {
    return [self p_wrap:@"/video/comment/add"];
}

#pragma mark - 对当前评论点赞
/**
 *  对当前评论点赞
 *
 *  @return
 */
+ (NSString *)matchVideoCommentLikeUrl {
    return [self p_wrap:@"/video/comment/like/add"];
}

#pragma mark - Private
+ (NSString *)p_wrap:(NSString *)url {
    return [NSString stringWithFormat:@"/esports/api%@", url];///esports
}

@end
