//
//  SCUserModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCBaseModel.h"

@protocol
SCUserModel
@end

@interface SCUserModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *uid;
@property (nonatomic, copy) NSString<Optional> *name;
@property (nonatomic, copy) NSString<Optional> *mobile;
@property (nonatomic, copy) NSString<Optional> *avatar;
@property (nonatomic, copy) NSString<Optional> *gender;

@end
