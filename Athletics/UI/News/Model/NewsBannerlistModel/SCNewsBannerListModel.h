//
//  SCNewsBannerListModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/30.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

@protocol
SCNewsBannerListDataModel
@end

@interface SCNewsBannerListDataModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *bannerId;
@property (nonatomic, copy) NSString<Optional> *imgUrl;
@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *type;
@property (nonatomic, copy) NSString<Optional> *target;

@end

@interface SCNewsBannerListModel : SCResponseModel

@property (nonatomic, strong) NSArray<SCNewsBannerListDataModel, Optional> *data;

@end
