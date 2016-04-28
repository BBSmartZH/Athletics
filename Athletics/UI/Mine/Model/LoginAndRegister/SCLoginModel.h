//
//  SCLoginModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/28.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

@protocol
SCLoginDataModel
@end

@interface SCLoginDataModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *uid;

@end

@interface SCLoginModel : SCResponseModel

@property (nonatomic, strong) SCLoginDataModel<Optional> *data;

@end
