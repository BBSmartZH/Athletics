//
//  SCContentListModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCBaseModel.h"

#import "SCImageModel.h"

@protocol
SCContentVideoModel
@end

@interface SCContentVideoModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *vId;
@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *url;
@property (nonatomic, copy) NSString<Optional> *image_id;
@property (nonatomic, strong) SCImageModel<Optional> *image;
@property (nonatomic, copy) NSString<Optional> *videoLength;

@end

@protocol
SCContentListModel
@end

@interface SCContentListModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *type;
@property (nonatomic, strong) SCContentVideoModel<Optional> *video;
@property (nonatomic, strong) SCImageModel<Optional> *image;
@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *desc;
@property (nonatomic, copy) NSString<Optional> *content;
@property (nonatomic, copy) NSString<Optional> *img_id;

@end
