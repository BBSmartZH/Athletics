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

@property (nonatomic, copy) NSString<Optional> *tid;

@property (nonatomic, copy) NSString<Optional> *moduleName;//无

@property (nonatomic, copy) NSString<Optional> *title;

@property (nonatomic, copy) NSString<Optional> *summary;

@property (nonatomic, copy) NSString<Optional> *content;

@property (nonatomic, strong) NSArray<Optional, SCImageModel> *images;

@property (nonatomic, copy) NSString<Optional> *commentCount;

@property (nonatomic, copy) NSString<Optional> *likeCount;

@property (nonatomic, copy) NSString<Optional> *status;

@property (nonatomic, copy) NSString<Optional> *createTime;

@property (nonatomic, copy) NSString<Optional> *lastReplyTime;

@property (nonatomic, copy) NSString<Optional> *userid;

@property (nonatomic, copy) NSString<Optional> *userName;

@property (nonatomic, copy) NSString<Optional> *userAvatar;


@end


@interface SCCommunityListModel : SCResponseModel

@property (nonatomic, strong) NSArray<SCCommunityListDataModel, Optional> *data;

@end
