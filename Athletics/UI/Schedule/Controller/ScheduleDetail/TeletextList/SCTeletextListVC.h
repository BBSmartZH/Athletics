//
//  SCTeletextListVC.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCBaseRefreshVC_iPhone.h"

@class SCRoundGameModel;
@interface SCTeletextListVC : SCBaseRefreshVC_iPhone

@property (nonatomic, assign) CGFloat topHeight;

@property (nonatomic, assign) UIViewController *parentVC;

@property (nonatomic, strong) NSArray<SCRoundGameModel *> *roundGames;

@property (nonatomic, copy) NSString *matchUnitId;

@property (nonatomic, assign) BOOL isUpdated;

- (void)upDateData;

@end
