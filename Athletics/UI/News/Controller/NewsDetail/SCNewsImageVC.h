//
//  SCNewsImageVC.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/16.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWBaseVC_iPhone.h"

typedef void(^TapHiddenBlack)(BOOL isHidden);

@interface SCNewsImageVC : LWBaseVC_iPhone

@property (nonatomic, assign) LWBaseVC_iPhone *parentVC;

@property (nonatomic, copy) TapHiddenBlack tapBlock;

@end
