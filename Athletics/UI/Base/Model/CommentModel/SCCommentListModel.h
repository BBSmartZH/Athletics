//
//  SCCommentListModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

#import "SCUserModel.h"

@protocol
SCCommentModel
@end

@interface SCCommentModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *id;
@property (nonatomic, copy) NSString<Optional> *time;
@property (nonatomic, copy) NSString<Optional> *content;
@property (nonatomic, strong) SCUserModel<Optional> *user;

@end

@protocol
SCCommentListDataModel
@end

@interface SCCommentListDataModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *total;
@property (nonatomic, strong) SCCommentModel<Optional> *comment;

@end

@interface SCCommentListModel : SCResponseModel

@property(nonatomic, strong) SCCommentListDataModel<Optional> *data;

@end
