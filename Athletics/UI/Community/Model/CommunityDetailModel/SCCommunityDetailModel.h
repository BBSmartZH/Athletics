//
//  SCCommunityDetailModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

#import "SCAdModel.h"
#import "SCImageModel.h"

@protocol
SCTopicLikeModel
@end

@interface SCTopicLikeModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *topicId;
@property (nonatomic, copy) NSString<Optional> *userId;
@property (nonatomic, copy) NSString<Optional> *userName;
@property (nonatomic, copy) NSString<Optional> *status;
@property (nonatomic, copy) NSString<Optional> *userAvatar;
@property (nonatomic, copy) NSString<Optional> *createTime;

@end

@protocol
SCCommunityDetailDataModel
@end

@interface SCCommunityDetailDataModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *tid;
@property (nonatomic, copy) NSString<Optional> *likeCount;
@property (nonatomic, copy) NSString<Optional> *isLike;
@property (nonatomic, copy) NSString<Optional> *commentCount;
@property (nonatomic, copy) NSString<Optional> *createTime;
@property (nonatomic, copy) NSString<Optional> *lastReplyTime;
@property (nonatomic, copy) NSString<Optional> *userId;
@property (nonatomic, copy) NSString<Optional> *userName;
@property (nonatomic, copy) NSString<Optional> *content;
@property (nonatomic, copy) NSString<Optional> *title;

@property (nonatomic, copy) NSString<Optional> *userAvatar;
@property (nonatomic, copy) NSString<Optional> *channelId;

@property (nonatomic, strong) NSArray<SCImageModel, Optional> *images;

@property (nonatomic, strong) NSArray<SCTopicLikeModel, Optional> *topicLikes;

@property (nonatomic, copy) NSString<Optional> *adId;
@property (nonatomic, strong) SCAdModel<Optional> *ad;

@end

@interface SCCommunityDetailModel : SCResponseModel

@property (nonatomic, strong) SCCommunityDetailDataModel<Optional> *data;

@end
