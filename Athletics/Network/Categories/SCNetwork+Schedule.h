//
//  SCNetwork+Schedule.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNetwork.h"

@class SCMatchLiveListModel, SCMatchListModel, SCMatchDetailModel, SCScheduleVideoListModel, SCTeletextListModel, SCMatchBannerModel, SCNewsCommentListModel;

@interface SCNetwork (Schedule)


/**
 *  赛事banner
 *
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)matchBannerWithSuccess:(void (^)(SCMatchBannerModel *model))success
                                         message:(SCMessageBlock)message;

/**
 *  查询赛事
 *
 *  @param channelId 频道id
 *  @param page      当前页
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)matchLiveListWithChannelId:(NSString *)channelId
                                                page:(int)page
                                             success:(void (^)(SCMatchLiveListModel *model))success
                                             message:(SCMessageBlock)message;

/**
 *  赛事赛程
 *
 *  @param matchId 赛事id
 *  @param page    当前页
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)matchCourseListWithMatchId:(NSString *)matchId
                                                page:(int)page
                                             success:(void (^)(SCMatchListModel *model))success
                                             message:(SCMessageBlock)message;

/**
 *  查询比赛
 *
 *  @param matchUnitId 比赛id
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)matchUnitQuaryWithMatchUnitId:(NSString *)matchUnitId
                                                success:(void (^)(SCMatchDetailModel *model))success
                                                message:(SCMessageBlock)message;

/**
 *  查询赛况（图文直播）
 *
 *  @param matchRondaId 场次id
 *  @param page         当前页
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)matchUnitliveListWithMatchRondaId:(NSString *)matchRondaId
                                                       page:(int)page
                                                    success:(void (^)(SCTeletextListModel *model))success
                                                    message:(SCMessageBlock)message;

/**
 *  查询比赛视频
 *
 *  @param matchUnitId 比赛id
 *  @param page        当前页
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)matchUnitvideoListWithMatchUnitId:(NSString *)matchUnitId
                                                       page:(int)page
                                                    success:(void (^)(SCScheduleVideoListModel *model))success
                                                    message:(SCMessageBlock)message;

/**
 *  比赛的评论
 *
 *  @param matchUnitId 比赛id
 *  @param page        当前页
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)matchCommentListWithMatchUnitId:(NSString *)matchUnitId
                                                     page:(int )page
                                                  success:(void (^)(SCNewsCommentListModel *model))success
                                                  message:(SCMessageBlock)message;

/**
 *  评论比赛
 *
 *  @param matchUnitId 比赛id
 *  @param comment     评论
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)matchCommentAddWithMatchUnitId:(NSString *)matchUnitId
                                                 comment:(NSString *)comment
                                                 success:(void (^)(SCResponseModel *model))success
                                                 message:(SCMessageBlock)message;




@end
