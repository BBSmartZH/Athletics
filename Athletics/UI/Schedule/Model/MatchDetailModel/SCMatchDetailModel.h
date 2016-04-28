//
//  SCMatchDetailModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/29.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

@protocol
SCRoundGameModel
@end

@interface SCRoundGameModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *name;
@property (nonatomic, copy) NSString<Optional> *roundId;
@property (nonatomic, copy) NSString<Optional> *status;

@end


@protocol
SCMatchDetailDataModel
@end

@interface SCMatchDetailDataModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *name;

@property (nonatomic, copy) NSString<Optional> *matchUnitId;
@property (nonatomic, copy) NSString<Optional> *status;
@property (nonatomic, copy) NSString<Optional> *leftTeamId;
@property (nonatomic, copy) NSString<Optional> *leftTeamName;
@property (nonatomic, copy) NSString<Optional> *leftTeamBadge;
@property (nonatomic, copy) NSString<Optional> *leftTeamGoal;
@property (nonatomic, copy) NSString<Optional> *isLeftTeamAble;
@property (nonatomic, copy) NSString<Optional> *rightTeamId;
@property (nonatomic, copy) NSString<Optional> *rightTeamName;
@property (nonatomic, copy) NSString<Optional> *rightTeamBadge;
@property (nonatomic, copy) NSString<Optional> *rightTeamGoal;
@property (nonatomic, copy) NSString<Optional> *isRightTeamAble;
@property (nonatomic, copy) NSString<Optional> *beginTime;

@property (nonatomic, strong) NSArray<SCRoundGameModel, Optional> *data;

@end

@interface SCMatchDetailModel : SCResponseModel

@property (nonatomic, strong) SCMatchDetailDataModel<Optional> *data;

@end
