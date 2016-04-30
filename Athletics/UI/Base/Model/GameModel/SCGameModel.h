//
//  SCGameModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

@protocol
SCGameModel
@end

@interface SCGameModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *channelId;
@property (nonatomic, copy) NSString<Optional> *name;
@property (nonatomic, copy) NSString<Optional> *status;
@property (nonatomic, copy) NSString<Optional> *pic;

@end
