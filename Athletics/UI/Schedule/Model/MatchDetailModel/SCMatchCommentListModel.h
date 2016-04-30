//
//  SCMatchCommentListModel.h
//  Athletics
//
//  Created by 李宛 on 16/4/30.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCResponseModel.h"

@protocol
SCMatchCommentListDataModel
@end

@interface  SCMatchCommentListDataModel: SCBaseModel
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *userAvatar;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *comment;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *likeCount;

@end


@interface SCMatchCommentListModel : SCResponseModel
@property (nonatomic,strong)NSArray<Optional,SCMatchCommentListDataModel> *data;
@end
