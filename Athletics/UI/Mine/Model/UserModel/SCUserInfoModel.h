//
//  SCUserInfoModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/28.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

#import "SCUserModel.h"

@interface SCUserInfoModel : SCResponseModel

@property (nonatomic, strong) SCUserModel<Optional> *data;

@end
