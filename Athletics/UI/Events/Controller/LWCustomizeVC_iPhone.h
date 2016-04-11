//
//  LWCustomizeVC_iPhone.h
//  Athletics
//
//  Created by 李宛 on 16/4/10.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ColumEditBlock)(NSMutableArray *array);

@interface LWCustomizeVC_iPhone : UIViewController

@property (nonatomic, copy) ColumEditBlock editBlock;



@end
