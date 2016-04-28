//
//  SCCommunityListModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

#import "SCImageModel.h"
#import "SCUserModel.h"

@protocol
SCCommunityListDataModel
@end

@interface SCCommunityListDataModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *id;

@property (nonatomic, copy) NSString<Optional> *moduleIds;

@property (nonatomic, copy) NSString<Optional> *moduleName;

@property (nonatomic, copy) NSString<Optional> *title;

@property (nonatomic, copy) NSString<Optional> *summary;

@property (nonatomic, strong) NSArray<Optional, SCImageModel> *images;

@property (nonatomic, copy) NSString<Optional> *replyNum;

@property (nonatomic, copy) NSString<Optional> *supportNum;

@property (nonatomic, copy) NSString<Optional> *status;

@property (nonatomic, copy) NSString<Optional> *isRecmd;

@property (nonatomic, copy) NSString<Optional> *createTime;

@property (nonatomic, copy) NSString<Optional> *lastReplyTime;

@property (nonatomic, copy) NSString<Optional> *creatorId;

@property (nonatomic, strong) SCUserModel<Optional> *user;

@property (nonatomic, copy) NSString<Optional> *followed;

@property (nonatomic, copy) NSString<Optional> *isLeader;


@end


@interface SCCommunityListModel : SCResponseModel

@property (nonatomic, strong) NSArray<SCCommunityListDataModel, Optional> *data;

@end
