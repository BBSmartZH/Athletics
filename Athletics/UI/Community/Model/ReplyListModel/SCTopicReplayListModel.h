//
//  SCTopicReplayListModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/29.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

@protocol
SCTopicReplayListDataModel
@end

@interface SCTopicReplayListDataModel : SCBaseModel

@property(nonatomic, copy) NSString<Optional> *commentId;
@property(nonatomic, copy) NSString<Optional> *uid;
@property(nonatomic, copy) NSString<Optional> *topicId;
@property(nonatomic, copy) NSString<Optional> *userName;
@property(nonatomic, copy) NSString<Optional> *userAvatar;
@property(nonatomic, copy) NSString<Optional> *title;
@property(nonatomic, copy) NSString<Optional> *comment;
@property(nonatomic, copy) NSString<Optional> *provId;
@property(nonatomic, copy) NSString<Optional> *floorSort;//第几楼
@property(nonatomic, copy) NSString<Optional> *createTime;
@property(nonatomic, copy) NSString<Optional> *status;

@end

@interface SCTopicReplayListModel : SCResponseModel

@property (nonatomic, strong) NSArray<SCTopicReplayListDataModel, Optional> *data;

@end
