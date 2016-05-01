//
//  SCNetwork+Community.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNetwork+Community.h"
#import "SCUrlWrapper.h"
#import "SCParamsWrapper.h"

#import "SCCommunityListModel.h"
#import "SCCommunityDetailModel.h"
#import "SCTopicReplayListModel.h"

@implementation SCNetwork (Community)

#pragma mark - 帖子列表
/**
 *  帖子列表
 *
 *  @param channelId 频道id
 *  @param type      类型  最新  默认  精华
 *  @param page      当前页数
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)topicListWithChannelId:(NSString *)channelId
                                            type:(int)type
                                            page:(int)page
                                         success:(void (^)(SCCommunityListModel *model))success
                                         message:(SCMessageBlock)message {
    return [SCNetworkHelper getWithUrl:[SCUrlWrapper topicListUrl] params:[SCParamsWrapper topicListParamsWithChannelId:channelId type:type page:page] success:^(NSDictionary *result) {
        NSError *error;
        SCCommunityListModel *model = [[SCCommunityListModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

#pragma mark - 帖子详情
/**
 *  帖子详情
 *
 *  @param topicId 帖子id
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)topicInfoWithTopicId:(NSString *)topicId
                                       success:(void (^)(SCCommunityDetailModel *model))success
                                       message:(SCMessageBlock)message {
    return [SCNetworkHelper getWithUrl:[SCUrlWrapper topicInfoUrl] params:[SCParamsWrapper topicInfoParamsWithTopicId:topicId] success:^(NSDictionary *result) {
        NSError *error;
        SCCommunityDetailModel *model = [[SCCommunityDetailModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

#pragma mark - 帖子评论列表
/**
 *  帖子评论列表
 *
 *  @param topicId 帖子id
 *  @param page    当前页
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)topicCommentListWithTopicId:(NSString *)topicId
                                                 page:(int)page
                                              success:(void (^)(SCTopicReplayListModel *model))success
                                              message:(SCMessageBlock)message {
    return [SCNetworkHelper getWithUrl:[SCUrlWrapper topicCommentListUrl] params:[SCParamsWrapper topicCommentListParamsWithTopicId:topicId page:page] success:^(NSDictionary *result) {
        NSError *error;
        SCTopicReplayListModel *model = [[SCTopicReplayListModel alloc] initWithDictionary:result error:&error];
        if (!error) {
            success(model);
        }else {
            message(error.localizedDescription);
        }
    } message:^(NSString *resultMsg) {
        message(resultMsg);
    }];
}

#pragma mark - 增加评论
/**
 *  增加评论
 *
 *  @param topicId   帖子id
 *  @param parentId  回复的人的id    回复帖子不传
 *  @param comment   回复内容
 *  @param floorSort 回复的人所在楼
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)topicCommentAddWithTopicId:(NSString *)topicId
                                            parentId:(NSString *)parentId
                                             comment:(NSString *)comment
                                           floorSort:(int)floorSort
                                             success:(void (^)(SCResponseModel *model))success
                                             message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper topicCommentAddUrl] params:[SCParamsWrapper topicCommentAddParamsWithTopicId:topicId parentId:parentId comment:comment floorSort:floorSort] success:^(NSDictionary *result) {
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

#pragma mark - 支持该帖
/**
 *  支持该帖
 *
 *  @param topicId 帖子id
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)topicLikeAddWithTopicId:(NSString *)topicId
                                          success:(void (^)(SCResponseModel *model))success
                                          message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper topicLikeAddUrl] params:[SCParamsWrapper topicLikeAddParamsWithTopicId:topicId] success:^(NSDictionary *result) {
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

#pragma mark - 发帖
/**
 *  发帖
 *
 *  @param title        标题
 *  @param content      内容
 *  @param imageJsonStr 图片
 *  @param success
 *  @param message
 *
 *  @return
 */
//+ (NSURLSessionDataTask *)topicAddWithTitle:(NSString *)title
//                                    content:(NSString *)content
//                               imageJsonStr:(NSString *)imageJsonStr
//                                    success:(void (^)(SCCommunityListModel *model))success
//                                    message:(SCMessageBlock)message {
//    
//}

#pragma mark - 我的帖子
/**
 *  我的帖子
 *
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)userTopicListWithPage:(int)page
                                        Success:(void (^)(SCCommunityListModel *model))success
                                           message:(SCMessageBlock)message {
    return [SCNetworkHelper getWithUrl:[SCUrlWrapper userTopicListUrl] params:[SCParamsWrapper userTopicListParamsWithPage:page] success:^(NSDictionary *result) {
        NSError *error;
        SCCommunityListModel *model = [[SCCommunityListModel alloc] initWithDictionary:result error:&error];
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
