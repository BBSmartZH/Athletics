//
//  SCScheduleVideoListModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/29.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

#import "SCImageModel.h"

@protocol
SCScheduleVideoListDataModel
@end

@interface SCScheduleVideoListDataModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *matchUnitId;
@property (nonatomic, copy) NSString<Optional> *url;
@property (nonatomic, strong) SCImageModel<Optional> *image;
@property (nonatomic, copy) NSString<Optional> *videoLength;
@property (nonatomic, copy) NSString<Optional> *uploadDate;
@property (nonatomic, copy) NSString<Optional> *title;


@end

@interface SCScheduleVideoListModel : SCResponseModel

@property (nonatomic, strong) NSArray<SCScheduleVideoListDataModel, Optional> *data;

@end
