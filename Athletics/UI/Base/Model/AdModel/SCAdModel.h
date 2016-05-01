//
//  SCAdModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/29.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

@protocol
SCAdModel
@end

@interface SCAdModel : SCResponseModel

@property (nonatomic, copy) NSString<Optional> *aid;
@property (nonatomic, copy) NSString<Optional> *url;
@property (nonatomic, copy) NSString<Optional> *pic;
@property (nonatomic, copy) NSString<Optional> *name;
@property (nonatomic, copy) NSString<Optional> *width;
@property (nonatomic, copy) NSString<Optional> *height;
@property (nonatomic, copy) NSString<Optional> *sponsorId;
@property (nonatomic, copy) NSString<Optional> *status;
@property (nonatomic, copy) NSString<Optional> *createTime;
@property (nonatomic, copy) NSString<Optional> *updateTime;

@end
