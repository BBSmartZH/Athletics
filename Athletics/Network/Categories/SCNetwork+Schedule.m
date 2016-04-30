//
//  SCNetwork+Schedule.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNetwork+Schedule.h"
#import "SCUrlWrapper.h"
#import "SCParamsWrapper.h"

#import "SCMatchLiveListModel.h"
#import "SCMatchListModel.h"
#import "SCMatchDetailModel.h"
#import "SCTeletextListModel.h"
#import "SCScheduleVideoListModel.h"
#import "SCMatchBannerModel.h"
#import "SCNewsCommentListModel.h"

@implementation SCNetwork (Schedule)


/**
 *  赛事banner
 *
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)matchBannerWithSuccess:(void (^)(SCMatchBannerModel *model))success
                                         message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper matchBannerUrl] params:nil success:^(NSDictionary *result) {
        NSError *error;
        SCMatchBannerModel *model = [[SCMatchBannerModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

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
                                             message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper matchLiveListUrl] params:[SCParamsWrapper matchLiveListParamsWithChannelId:channelId page:page] success:^(NSDictionary *result) {
        NSError *error;
        SCMatchLiveListModel *model = [[SCMatchLiveListModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

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
                                             message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper matchCourseListUrl] params:[SCParamsWrapper matchCourseListParamsWithMatchId:matchId page:page] success:^(NSDictionary *result) {
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
                                                message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper matchUnitQuaryUrl] params:[SCParamsWrapper matchUnitQuaryParamsWithMatchUnitId:matchUnitId] success:^(NSDictionary *result) {
        NSError *error;
        SCMatchDetailModel *model = [[SCMatchDetailModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

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
                                                    message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper matchUnitliveListUrl] params:[SCParamsWrapper matchUnitliveListParamsWithMatchRondaId:matchRondaId page:page] success:^(NSDictionary *result) {
        NSError *error;
        SCTeletextListModel *model = [[SCTeletextListModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

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
                                                    message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper matchUnitvideoListUrl] params:[SCParamsWrapper matchUnitvideoListParamsWithMatchUnitId:matchUnitId page:page] success:^(NSDictionary *result) {
        NSError *error;
        SCScheduleVideoListModel *model = [[SCScheduleVideoListModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

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
                                                  message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper matchCommentListUrl] params:[SCParamsWrapper matchCommentListParamsWithMatchUnitId:matchUnitId page:page] success:^(NSDictionary *result) {
        NSError *error;
        SCNewsCommentListModel *model = [[SCNewsCommentListModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

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
                                                 message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper matchCommentAddUrl] params:[SCParamsWrapper matchCommentAddParamsWithMatchUnitId:matchUnitId comment:comment] success:^(NSDictionary *result) {
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

@end
