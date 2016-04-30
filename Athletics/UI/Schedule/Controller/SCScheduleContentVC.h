//
//  SCScheduleContentVC.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCBaseRefreshVC_iPhone.h"

@interface SCScheduleContentVC : SCBaseRefreshVC_iPhone

@property (nonatomic, assign) UIViewController *parentVC;
@property (nonatomic, copy) NSString *channelId;

@property (nonatomic, assign, readonly) BOOL isUpdated;

- (void)updateData;

@end
