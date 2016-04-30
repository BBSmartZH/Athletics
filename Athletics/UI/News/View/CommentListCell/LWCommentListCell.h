//
//  LWCommentListCell.h
//  Athletics
//
//  Created by 李宛 on 16/4/15.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCNewsCommentListDataModel;
@interface LWCommentListCell : UITableViewCell

@property (nonatomic, strong, readonly) UIImageView *avatar;

- (void)createLayoutWith:(SCNewsCommentListDataModel *)model;

+ (NSString *)cellidentifier;

@end
