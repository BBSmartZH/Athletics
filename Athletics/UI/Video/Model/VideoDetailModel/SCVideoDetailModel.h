//
//  SCVideoDetailModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"
#import "SCImageModel.h"

@protocol
SCVideoDetailDataModel
@end

@interface SCVideoDetailDataModel : SCBaseModel

@property(nonatomic, copy) NSString<Optional> *url;
@property(nonatomic, strong) SCImageModel<Optional> *image;

@end

@interface SCVideoDetailModel : SCResponseModel

@property (nonatomic, strong) SCVideoDetailDataModel<Optional> *data;

@end
