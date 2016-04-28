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

@property (nonatomic, copy) NSString<Optional> *gameId;
@property (nonatomic, copy) NSString<Optional> *gameName;
@property (nonatomic, copy) NSString<Optional> *gameDesc;
@property (nonatomic, copy) NSString<Optional> *gamePic;

@end
