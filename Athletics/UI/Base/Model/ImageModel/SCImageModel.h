//
//  SCImageModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCBaseModel.h"

@protocol
SCImageModel
@end

@interface SCImageModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *url;
@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *width;
@property (nonatomic, copy) NSString<Optional> *height;
@property (nonatomic, copy) NSString<Optional> *size;
@property (nonatomic, copy) NSString<Optional> *type;

//自用
@property (nonatomic, strong) UIImage<Ignore> *image;

@end
