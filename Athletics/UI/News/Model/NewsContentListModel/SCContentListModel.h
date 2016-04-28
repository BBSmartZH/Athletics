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
SCContentListModel
@end

@interface SCContentListModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *type;
@property (nonatomic, copy) NSString<Optional> *vid;
@property (nonatomic, strong) SCImageModel<Optional> *image;
@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *desc;
@property (nonatomic, copy) NSString<Optional> *duration;
@property (nonatomic, copy) NSString<Optional> *info;
@property (nonatomic, copy) NSString<Optional> *itype;

@end
