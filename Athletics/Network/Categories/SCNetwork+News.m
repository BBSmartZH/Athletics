//
//  SCNetwork+News.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNetwork+News.h"
#import "SCUrlWrapper.h"
#import "SCParamsWrapper.h"

#import "SCNewsListModel.h"
#import "SCNewsDetailModel.h"
#import "SCContentListModel.h"
#import "SCNewsCommentListModel.h"

@implementation SCNetwork (News)

/**
 *  资讯列表
 *
 *  @param channelId 频道id
 *  @param page      当前page
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)newsListWithChannelId:(NSString *)channelId
                                           page:(int)page
                                        success:(void (^)(SCNewsListModel *model))success
                                        message:(SCMessageBlock)message {
    return [SCNetworkHelper getWithUrl:[SCUrlWrapper newsListUrl] params:[SCParamsWrapper newsListParamsWithChannelId:channelId page:page] success:^(NSDictionary *result) {
        NSError *error;
        SCNewsListModel *model = [[SCNewsListModel alloc] initWithDictionary:result error:&error];
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
 *  资讯详情
 *
 *  @param newsId  newsId
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)newsInfoWithNewsId:(NSString *)newsId
                                     success:(void (^)(SCNewsDetailModel *model))success
                                     message:(SCMessageBlock)message {
    return [SCNetworkHelper getWithUrl:[SCUrlWrapper newsInfoUrl] params:[SCParamsWrapper newsInfoParamsWithNewsId:newsId] success:^(NSDictionary *result) {
        NSError *error;
        SCNewsDetailModel *model = [[SCNewsDetailModel alloc] initWithDictionary:result error:&error];
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
 *  资讯的评论
 *
 *  @param newsId  newsId
 *  @param page    当前页
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)newsCommentListWithNewsId:(NSString *)newsId
                                               page:(int)page
                                            success:(void (^)(SCNewsCommentListModel *model))success
                                            message:(SCMessageBlock)message {
    return [SCNetworkHelper getWithUrl:[SCUrlWrapper newsCommentListUrl] params:[SCParamsWrapper newsCommentListParamsWithNewsId:newsId page:page] success:^(NSDictionary *result) {
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
 *  资讯添加评论
 *
 *  @param newsId  newsId
 *  @param comment 评论
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)newsCommentAddWithNewsId:(NSString *)newsId
                                           comment:(NSString *)comment
                                           success:(void (^)(SCResponseModel *model))success
                                           message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper newsCommentAddUrl] params:[SCParamsWrapper newsCommentAddParamsWithNewsId:newsId comment:comment] success:^(NSDictionary *result) {
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
 *  为资讯评论点赞
 *
 *  @param newsCommentId 评论id
 *  @param success
 *  @param message
 *
 *  @return
 */
+ (NSURLSessionDataTask *)newsCommentClickedParamsWithNewsCommentId:(NSString *)newsCommentId
                                                            success:(void (^)(SCResponseModel *model))success
                                                            message:(SCMessageBlock)message {
    return [SCNetworkHelper postWithUrl:[SCUrlWrapper newsCommentClickedUrl] params:[SCParamsWrapper newsCommentClickedParamsWithNewsCommentId:newsCommentId] success:^(NSDictionary *result) {
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
