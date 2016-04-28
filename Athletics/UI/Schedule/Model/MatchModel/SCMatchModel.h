//
//  SCMatchModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCBaseModel.h"

@protocol
SCMatchModel
@end

@interface SCMatchModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *matchType;
@property (nonatomic, copy) NSString<Optional> *matchId;
@property (nonatomic, copy) NSString<Optional> *leftId;
@property (nonatomic, copy) NSString<Optional> *leftName;
@property (nonatomic, copy) NSString<Optional> *leftBadge;
@property (nonatomic, copy) NSString<Optional> *leftGoal;
@property (nonatomic, copy) NSString<Optional> *isLeftTeamAble;
@property (nonatomic, copy) NSString<Optional> *rightId;
@property (nonatomic, copy) NSString<Optional> *rightName;
@property (nonatomic, copy) NSString<Optional> *rightBadge;
@property (nonatomic, copy) NSString<Optional> *rightGoal;
@property (nonatomic, copy) NSString<Optional> *isRightTeamAble;
@property (nonatomic, copy) NSString<Optional> *matchDesc;
@property (nonatomic, copy) NSString<Optional> *startTime;
@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *logo;

@end
