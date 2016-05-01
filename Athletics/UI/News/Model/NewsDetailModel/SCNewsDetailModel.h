//
//  SCNewsDetailModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

#import "SCNewsListModel.h"
#import "SCContentListModel.h"
#import "SCAdModel.h"

@protocol
SCNewsDetailDataModel
@end

@interface SCNewsDetailDataModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *abstract;
@property (nonatomic, strong) NSArray<SCContentListModel, Optional> *contents;
@property (nonatomic, copy) NSString<Optional> *url;
@property (nonatomic, copy) NSString<Optional> *pub_time;
@property (nonatomic, copy) NSString<Optional> *atype;
@property (nonatomic, copy) NSString<Optional> *newsAppId;
@property (nonatomic, copy) NSString<Optional> *targetId;
@property (nonatomic, copy) NSString<Optional> *commentNum;
@property (nonatomic, strong) NSArray<SCNewsListDataModel, Optional> *relate;

@property (nonatomic, strong) SCAdModel<Optional> *ad;



@end

@interface SCNewsDetailModel : SCResponseModel

@property (nonatomic, strong) SCNewsDetailDataModel<Optional> *data;

@end
