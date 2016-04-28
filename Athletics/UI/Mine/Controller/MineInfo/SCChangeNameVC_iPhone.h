//
//  SCChangeNameVC_iPhone.h
//  MrzjClient
//
//  Created by mrzj_sc on 15/11/30.
//  Copyright © 2015年 mrzj_sc. All rights reserved.
//

#import "LWBaseTableVC_iPhone.h"

@interface SCChangeNameVC_iPhone : LWBaseTableVC_iPhone

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) SCStringResultBlock completion;

@end
