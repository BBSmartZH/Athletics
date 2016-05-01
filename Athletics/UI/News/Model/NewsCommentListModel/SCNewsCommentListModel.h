//
//  SCNewsCommentListModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/28.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

#import "SCImageModel.h"

@protocol
SCNewsCommentListDataModel
@end

@interface SCNewsCommentListDataModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *matchCommentId;
@property (nonatomic, copy) NSString<Optional> *videoCommentId;
@property (nonatomic, copy) NSString<Optional> *commentId;
@property (nonatomic, copy) NSString<Optional> *userId;
@property (nonatomic, copy) NSString<Optional> *userAvatar;
@property (nonatomic, copy) NSString<Optional> *userName;
@property (nonatomic, copy) NSString<Optional> *comment;
@property (nonatomic, copy) NSString<Optional> *status;
@property (nonatomic, copy) NSString<Optional> *likeCount;
@property (nonatomic, copy) NSString<Optional> *isLike;

@end

@interface SCNewsCommentListModel : SCResponseModel

@property (nonatomic, strong) NSArray<SCNewsCommentListDataModel, Optional> *data;

@end
