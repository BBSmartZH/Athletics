//
//  SCCommentListVC.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/16.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCBaseRefreshVC_iPhone.h"

typedef void (^CommentNumBlock)(NSString *num);

@interface SCCommentListVC : SCBaseRefreshVC_iPhone

@property (nonatomic, assign) UIViewController *parentVC;
@property (nonatomic, copy) CommentNumBlock numBlock;

@property (nonatomic, copy) NSString *newsId;

@property (nonatomic, assign, readonly) BOOL isUpdated;

- (void)updateData;

@end
