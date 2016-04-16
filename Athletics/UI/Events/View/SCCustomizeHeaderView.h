//
//  SCCustomizeHeaderView.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/16.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCCustomizeHeaderView : UICollectionReusableView

@property (nonatomic, copy) NSString *leftTitle;
@property (nonatomic, copy) NSString *rightTitle;

+ (NSString *)headerIdentifier;

@end
