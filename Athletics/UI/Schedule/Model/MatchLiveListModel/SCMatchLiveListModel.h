//
//  SCMatchLiveListModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

#import "SCImageModel.h"

@protocol
SCMatchLiveListDataModel
@end

@interface SCMatchLiveListDataModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *matchId;//赛事活动id
@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *desc;
@property (nonatomic, copy) NSString<Optional> *startTime;
@property (nonatomic, copy) NSString<Optional> *endTime;
@property (nonatomic, copy) NSString<Optional> *url;//赛事图片
@property (nonatomic, copy) NSString<Optional> *status;//1.未开始 2.正在进行 3.已结束 4.取消

@end

@interface SCMatchLiveListModel : SCResponseModel

@property (nonatomic, strong) NSArray<SCMatchLiveListDataModel, Optional> *data;

@end
