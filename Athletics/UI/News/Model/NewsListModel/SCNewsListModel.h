//
//  SCNewsListModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"
#import "SCImageModel.h"

@protocol
SCNewsListDataModel
@end

@interface SCNewsListDataModel : SCBaseModel

@property (nonatomic, copy) NSString<Optional> *newsId;

@property (nonatomic, copy) NSString<Optional> *title;

@property (nonatomic, copy) NSString<Optional> *desc;

@property (nonatomic, copy) NSString<Optional> *type;//1 text  2 video   3image

@property (nonatomic, copy) NSString<Optional> *pub_time;

@property (nonatomic, strong) NSArray<Optional, SCImageModel> *images;

@property (nonatomic, copy) NSString<Optional> *commentsNum;

@property (nonatomic, copy) NSString<Optional> *imgUrl;

@property (nonatomic, copy) NSString<Optional> *img_count;

@end

@interface SCNewsListModel : SCResponseModel

@property (nonatomic, strong) NSArray<SCNewsListDataModel, Optional> *data;

@end
