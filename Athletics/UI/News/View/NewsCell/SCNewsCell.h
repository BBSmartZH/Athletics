//
//  SCNewsCell.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCNewsListDataModel;
@interface SCNewsCell : UITableViewCell

+ (NSString *)cellIdentifier;

- (void)createLayoutWith:(SCNewsListDataModel *)model;

@end
