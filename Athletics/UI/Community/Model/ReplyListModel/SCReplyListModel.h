//
//  SCReplyListModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"
#import "SCUserModel.h"

@protocol
SCReplyListDataModel
@end

@interface SCReplyListDataModel : SCBaseModel

@property(nonatomic, copy) NSString<Optional> *id;
@property(nonatomic, copy) NSString<Optional> *mid;
@property(nonatomic, copy) NSString<Optional> *creatorId;
@property(nonatomic, copy) NSString<Optional> *content;
@property(nonatomic, copy) NSString<Optional> *summary;
@property(nonatomic, copy) NSString<Optional> *pid;
@property(nonatomic, copy) NSString<Optional> *ppid;
@property(nonatomic, copy) NSString<Optional> *supportNum;
@property(nonatomic, copy) NSString<Optional> *createTime;
@property(nonatomic, strong) SCUserModel<Optional> *user;
@property(nonatomic, strong) SCReplyListDataModel<Optional> *parentReply;
@property(nonatomic, copy) NSString<Optional> *isMy;
@property(nonatomic, copy) NSString<Optional> *isMaster;
@property(nonatomic, copy) NSString<Optional> *floorNum;
@property(nonatomic, copy) NSString<Optional> *subReplyNum;
@property(nonatomic, copy) NSString<Optional> *isLeader;
@property(nonatomic, copy) NSString<Optional> *type;
@property(nonatomic, copy) NSString<Optional> *status;

@end


@interface SCReplyListModel : SCResponseModel

@property (nonatomic, strong) NSArray<SCReplyListDataModel, Optional> *data;

@end