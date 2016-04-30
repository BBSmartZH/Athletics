//
//  LandlordCell.h
//  Athletics
//
//  Created by 李宛 on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCTopicReplayListDataModel;
@interface LandlordCell : UITableViewCell

@property (nonatomic, strong, readonly) UIImageView *avatar;

- (void)createLayoutWith:(SCTopicReplayListDataModel *)model;

+ (NSString *)cellIdentifier;

//+ (CGFloat)cellHeightWith:(id)model;
@end
