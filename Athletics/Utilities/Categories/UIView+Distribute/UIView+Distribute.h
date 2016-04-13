//
//  UIView+Distribute.h
//  MrzjExpert
//
//  Created by shenchuang on 15/8/6.
//  Copyright (c) 2015年 shenchuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Distribute)

@property (nonatomic, readonly)CGFloat left;
@property (nonatomic, readonly)CGFloat right;
@property (nonatomic, readonly)CGFloat top;
@property (nonatomic, readonly)CGFloat bottom;
@property (nonatomic, readonly)CGFloat fWidth;
@property (nonatomic, readonly)CGFloat fHeight;

@end
