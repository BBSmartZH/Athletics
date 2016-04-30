//
//  SCAppUpdateModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/29.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

@protocol
SCAppUpdateDataModel
@end

@interface SCAppUpdateDataModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *url;
@property (nonatomic, copy) NSString<Optional> *type;
@property (nonatomic, copy) NSString<Optional> *title;

@end

@interface SCAppUpdateModel : SCResponseModel

@property (nonatomic, strong) SCAppUpdateDataModel<Optional> *data;

@end
