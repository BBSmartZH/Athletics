//
//  SCNewsDetailVC.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCBaseRefreshVC_iPhone.h"

@interface SCNewsDetailVC : LWBaseTableVC_iPhone

@property (nonatomic, assign) UIViewController *parentVC;
@property (nonatomic, copy) NSString *newsId;

@end
