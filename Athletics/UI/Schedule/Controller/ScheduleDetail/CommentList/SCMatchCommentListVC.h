//
//  SCMatchCommentListVC.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/28.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCBaseRefreshVC_iPhone.h"

@interface SCMatchCommentListVC : SCBaseRefreshVC_iPhone

@property (nonatomic, assign) CGFloat topHeight;

@property (nonatomic, assign) UIViewController *parentVC;

- (void)upDateData;

@end
