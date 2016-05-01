//
//  SCNetwork+Video.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNetwork.h"

@class SCVideoListModel, SCVideoDetailModel, SCVideoCoverModel, SCNewsCommentListModel;

@interface SCNetwork (Video)

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
                                              message:(SCMessageBlock)message;

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
                                              message:(SCMessageBlock)message;

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
                                                   message:(SCMessageBlock)message;

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
                                                   success:(void (^)(SCNewsCommentListModel *model))success
                                                   message:(SCMessageBlock)message;

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
                                                  message:(SCMessageBlock)message;

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
                                                          message:(SCMessageBlock)message;



@end
