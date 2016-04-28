//
//  SCNetwork+Video.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNetwork+Video.h"
#import "SCUrlWrapper.h"
#import "SCParamsWrapper.h"

#import "SCVideoListModel.h"
#import "SCVideoDetailModel.h"
#import "SCVideoCommentListModel.h"
#import "SCVideoCoverModel.h"

@implementation SCNetwork (Video)

/**
 *  赛事栏目视频
 *
 *  @param channelId 频道id
 *  @param type      类型    推荐   赛事    娱乐
 *  @param page
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)matchVideoListWithChannelId:(NSString *)channelId
                                                 type:(int)type
                                                 page:(int)page
                                              success:(void (^)(SCVideoListModel *model))success
                                              message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper matchVideoListUrl] params:[SCParamsWrapper matchVideoListParamsWithChannelId:channelId type:type page:page] success:^(NSDictionary *result) {
        NSError *error;
        SCVideoListModel *model = [[SCVideoListModel alloc] initWithDictionary:result error:&error];
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
 *  赛事视频详情
 *
 *  @param videoId 视频id
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)matchVideoDetailWithVideoId:(NSString *)videoId
                                              success:(void (^)(SCVideoDetailModel *model))success
                                              message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper matchVideoDetailUrl] params:[SCParamsWrapper matchVideoDetailParamsWithVideoId:videoId] success:^(NSDictionary *result) {
        NSError *error;
        SCVideoDetailModel *model = [[SCVideoDetailModel alloc] initWithDictionary:result error:&error];
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
 *  视频相关视频
 *
 *  @param videoId 视频id
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)matchVideoRelatedListWithVideoId:(NSString *)videoId
                                                   success:(void (^)(SCVideoCoverModel *model))success
                                                   message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper matchVideoRelatedListUrl] params:[SCParamsWrapper matchVideoRelatedListParamsWithVideoId:videoId] success:^(NSDictionary *result) {
        NSError *error;
        SCVideoCoverModel *model = [[SCVideoCoverModel alloc] initWithDictionary:result error:&error];
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
 *  当前视频评论
 *
 *  @param videoId 视频id
 *  @param page    当前页
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)matchVideoCommentListWithVideoId:(NSString *)videoId
                                                      page:(int)page
                                                   success:(void (^)(SCVideoCommentListModel *model))success
                                                   message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper matchVideoCommentListUrl] params:[SCParamsWrapper matchVideoCommentListParamsWithVideoId:videoId page:page] success:^(NSDictionary *result) {
        NSError *error;
        SCVideoCommentListModel *model = [[SCVideoCommentListModel alloc] initWithDictionary:result error:&error];
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
 *  评论当前视频
 *
 *  @param videoId 视频id
 *  @param comment 评论
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)matchVideoCommentAddWithVideoId:(NSString *)videoId
                                                  comment:(NSString *)comment
                                                  success:(void (^)(SCResponseModel *model))success
                                                  message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper matchVideoCommentAddUrl] params:[SCParamsWrapper matchVideoCommentAddParamsWithVideoId:videoId comment:comment] success:^(NSDictionary *result) {
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

/**
 *  对当前评论点赞
 *
 *  @param videoCommentId 视频评论id
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)matchVideoCommentLikeWithVideoCommentId:(NSString *)videoCommentId
                                                          success:(void (^)(SCResponseModel *model))success
                                                          message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper matchVideoCommentLikeUrl] params:[SCParamsWrapper matchVideoCommentLikeParamsWithVideoCommentId:videoCommentId] success:^(NSDictionary *result) {
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
