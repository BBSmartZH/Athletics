//
//  LWCustomizeVC_iPhone.h
//  Athletics
//
//  Created by 李宛 on 16/4/10.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWBaseVC_iPhone.h"

typedef void(^ColumEditBlock)(BOOL result);

@interface LWCustomizeVC_iPhone : LWBaseVC_iPhone

@property (nonatomic, copy) ColumEditBlock editBlock;



@end
