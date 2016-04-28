//
//  SCCommunityDetailModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

#import "SCUserModel.h"

@protocol
SCTopicModel
@end

@interface SCTopicModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *topicId;
@property (nonatomic, copy) NSString<Optional> *moduleIds;
@property (nonatomic, copy) NSString<Optional> *moduleName;
@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *creatorId;
@property (nonatomic, copy) NSString<Optional> *summary;

@end

@protocol
SCCommunityDetailDataModel
@end

@interface SCCommunityDetailDataModel : SCBaseModel

@property (nonatomic, strong) SCTopicModel<Optional> *topic;
@property (nonatomic, copy) NSString<Optional> *lastReplyId;
@property (nonatomic, copy) NSString<Optional> *supportNum;
@property (nonatomic, copy) NSString<Optional> *supported;
@property (nonatomic, copy) NSString<Optional> *replyNum;
@property (nonatomic, copy) NSString<Optional> *status;
@property (nonatomic, copy) NSString<Optional> *isRecmd;
@property (nonatomic, copy) NSString<Optional> *createTime;
@property (nonatomic, copy) NSString<Optional> *lastReplyTime;
@property (nonatomic, strong) SCUserModel<Optional> *user;
@property (nonatomic, copy) NSString<Optional> *isMy;
@property (nonatomic, copy) NSString<Optional> *isLeader;
@property (nonatomic, copy) NSString<Optional> *supportUsers;
@property (nonatomic, copy) NSString<Optional> *isAdmin;
@property (nonatomic, copy) NSString<Optional> *isMaster;

@end

@interface SCCommunityDetailModel : SCResponseModel

@property (nonatomic, strong) SCCommunityDetailDataModel<Optional> *data;

@end
