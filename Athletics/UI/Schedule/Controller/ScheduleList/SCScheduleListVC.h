//
//  SCScheduleListVC.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWBaseTableVC_iPhone.h"

@interface SCScheduleListVC : LWBaseTableVC_iPhone

@property (nonatomic, copy) NSString *matchId;
@property (nonatomic, copy) NSString *liveTitle;

@property (nonatomic, assign, readonly) BOOL isUpdated;

@end
