//
//  SCTeletextListModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/29.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

#import "SCImageModel.h"

@protocol
SCTeletextListDataModel
@end

@interface SCTeletextListDataModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *liverName;
@property (nonatomic, copy) NSString<Optional> *liverAvatar;
@property (nonatomic, copy) NSString<Optional> *content;
@property (nonatomic, strong) SCImageModel<Optional> *image;
@property (nonatomic, copy) NSString<Optional> *goalStr;
@property (nonatomic, copy) NSString<Optional> *liveTime;

@end

@protocol
SCTeletextModel
@end

@interface SCTeletextModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *status;
@property (nonatomic, strong) NSArray<SCTeletextListDataModel, Optional> *list;


@end

@interface SCTeletextListModel : SCResponseModel

@property (nonatomic, strong) SCTeletextModel<Optional> *data;

@end
