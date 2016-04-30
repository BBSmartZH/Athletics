//
//  SCMatchBannerModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/29.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

@protocol

SCMatchBannerDataModel

@end

@interface SCMatchBannerDataModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *url;
@property (nonatomic, copy) NSString<Optional> *pic;

@end

@interface SCMatchBannerModel : SCResponseModel

@property (nonatomic, strong) NSArray<SCMatchBannerDataModel, Optional> *data;

@end
