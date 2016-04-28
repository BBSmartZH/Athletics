//
//  SCVideoCommentListModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/29.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

@protocol
SCVideoCommentListDataModel
@end

@interface SCVideoCommentListDataModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *videoCommentId;
@property (nonatomic, copy) NSString<Optional> *userId;
@property (nonatomic, copy) NSString<Optional> *userName;
@property (nonatomic, copy) NSString<Optional> *userAvatar;
@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *comment;
@property (nonatomic, copy) NSString<Optional> *status;
@property (nonatomic, copy) NSString<Optional> *likeCount;

@end

@interface SCVideoCommentListModel : SCResponseModel

@property (nonatomic, strong) NSArray<SCVideoCommentListDataModel, Optional> *data;

@end
