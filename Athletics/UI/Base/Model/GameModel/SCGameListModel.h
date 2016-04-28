//
//  SCGameListModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/26.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"
#import "SCGameModel.h"

@interface SCGameListModel : SCResponseModel

@property (nonatomic, strong) NSArray<SCGameModel, Optional> *gameList;

@end
