//
//  LWCommentsCell.h
//  Athletics
//
//  Created by 李宛 on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCTopicReplayListDataModel;
@interface LWCommentsCell : UITableViewCell

- (void)createLayoutWith:(SCTopicReplayListDataModel *)model;

+ (NSString *)cellIdentifier;

@end
