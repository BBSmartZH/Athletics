//
//  SCNewsDetailVideoCell.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/16.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCContentListModel;
@interface SCNewsDetailVideoCell : UITableViewCell

- (void)createLayoutWith:(SCContentListModel *)model;

+ (NSString *)cellIdentifier;

+ (CGFloat)cellHeightWith:(SCContentListModel *)model;

@end
