//
//  SCMatchListModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

#import "SCMatchModel.h"

@protocol
SCMatchListDataModel
@end

@interface SCMatchListDataModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *matchUnitId;
@property (nonatomic, copy) NSString<Optional> *status;//1未开始, 2正在进行，3已结束，4已取消
@property (nonatomic, copy) NSString<Optional> *leftTeamId;
@property (nonatomic, copy) NSString<Optional> *leftTeamName;
@property (nonatomic, copy) NSString<Optional> *leftTeamBadge;
@property (nonatomic, copy) NSString<Optional> *leftTeamGoal;
@property (nonatomic, copy) NSString<Optional> *leftTeamAble;
@property (nonatomic, copy) NSString<Optional> *rightTeamId;
@property (nonatomic, copy) NSString<Optional> *rightTeamName;
@property (nonatomic, copy) NSString<Optional> *rightTeamBadge;
@property (nonatomic, copy) NSString<Optional> *rightTeamGoal;
@property (nonatomic, copy) NSString<Optional> *rightTeamAble;
@property (nonatomic, copy) NSString<Optional> *beginTime;
@property (nonatomic, copy) NSString<Optional> *appointType;

@end

@protocol
SCMatchGroupListModel
@end

@interface SCMatchGroupListModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *name;
@property (nonatomic, strong) NSArray<SCMatchListDataModel, Optional> *matchUnit;

@end

@interface SCMatchListModel : SCResponseModel

@property (nonatomic, strong) NSArray<SCMatchGroupListModel, Optional> *data;

@end
