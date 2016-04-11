//
//  SCTopScrollView.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/10.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCTopScrollView : UIView

@property (nonatomic, assign) CGFloat space;//Default 2.0

@property (nonatomic, strong) UIColor *itemTextNorColor;

@property (nonatomic, strong) UIColor *itemTextHighColor;


- (instancetype)initWithFrame:(CGRect)frame;

- (void)update;

@end
