//
//  SCCommonCell.h
//  MrzjShop
//
//  Created by mrzj_sc on 15/10/27.
//  Copyright © 2015年 mrzj_sc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCCommonCell : UITableViewCell
/**
 *  左边图片
 */
@property (nonatomic, strong) UIImage *leftImage;
/**
 *  左边label
 */
@property (nonatomic, strong, readonly) UILabel *leftLabel;
/**
 *  右边label
 */
@property (nonatomic, strong, readonly) UILabel *rightLabel;
/**
 *  是否有右箭头 默认YES
 */
@property (nonatomic, assign) BOOL arrowRight;

@end
