//
//  SCVideoCoverModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/29.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"
#import "SCImageModel.h"

@protocol
SCVideoCoverDataModel
@end

@interface SCVideoCoverDataModel : SCBaseModel

@property(nonatomic, copy) NSString<Optional> *videoId;
@property(nonatomic, copy) NSString<Optional> *title;
@property(nonatomic, copy) NSString<Optional> *stitle;//
@property(nonatomic, strong) SCImageModel<Optional> *image;
@property(nonatomic, copy) NSString<Optional> *url;
@property(nonatomic, copy) NSString<Optional> *videoLength;
@property(nonatomic, copy) NSString<Optional> *uploadDate;


@end

@interface SCVideoCoverModel : SCResponseModel

@property(nonatomic, strong) NSArray<SCVideoCoverDataModel, Optional> *data;


@end
