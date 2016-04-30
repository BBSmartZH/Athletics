//
//  SCPostsAdCell.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/15.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCAdModel;
@interface SCPostsAdCell : UITableViewCell

- (void)createLayoutWith:(SCAdModel *)model;

+ (NSString *)cellIdentifier;

+ (CGFloat)cellHeightWith:(SCAdModel *)model;

@end
