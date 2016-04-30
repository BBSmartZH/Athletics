//
//  SCUploadTokenModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/29.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"


@protocol
SCUploadTokenDataModel
@end

@interface SCUploadTokenDataModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional>    *uploadToken;
@property (nonatomic, copy) NSString<Optional>    *spaceUrl;

@end

@interface SCUploadTokenModel : SCResponseModel

@property (nonatomic, strong) SCUploadTokenDataModel<Optional>  *data;

@end
