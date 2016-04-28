//
//  SCNetwork+News.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNetwork.h"

@class SCNewsListModel, SCNewsDetailModel, SCNewsCommentListModel, SCNewsCommentListModel;

@interface SCNetwork (News)

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
                                        message:(SCMessageBlock)message;

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
                                     message:(SCMessageBlock)message;

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
                                            message:(SCMessageBlock)message;

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
                                           message:(SCMessageBlock)message;

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
                                                            message:(SCMessageBlock)message;









@end
