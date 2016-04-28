//
//  SCVideoListModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"
#import "SCImageModel.h"

@protocol
SCVideoListDataModel
@end

@interface SCVideoListDataModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *videoId;
@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *summary;
@property (nonatomic, copy) NSString<Optional> *type;
@property (nonatomic, strong) SCImageModel<Optional> *image;
@property (nonatomic, copy) NSString<Optional> *url;
@property (nonatomic, copy) NSString<Optional> *videoLength;
@property (nonatomic, copy) NSString<Optional> *uploadDate;


@end

@interface SCVideoListModel : SCResponseModel

@property (nonatomic, strong) NSArray<SCVideoListDataModel, Optional> *data;

@end
