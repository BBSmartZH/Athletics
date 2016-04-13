//
//  SCLoginVC.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWBaseTableVC_iPhone.h"

typedef void(^LoginSuccessBlock)(BOOL result);

@interface SCLoginVC : LWBaseTableVC_iPhone

- (void)loginWithPresentController:(UIViewController *)presentController
                 successCompletion:(LoginSuccessBlock)successCompletion;

@end
