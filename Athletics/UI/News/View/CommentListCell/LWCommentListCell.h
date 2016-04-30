//
//  LWCommentListCell.h
//  Athletics
//
//  Created by 李宛 on 16/4/15.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCNewsCommentListDataModel;

@protocol LWCommentListCellDelegate <NSObject>

- (void)praiseButtonClicked:(UIButton *)sender withModel:(SCNewsCommentListDataModel *)model;

@end


@interface LWCommentListCell : UITableViewCell

@property (nonatomic, assign) id<LWCommentListCellDelegate> delegate;

@property (nonatomic, strong, readonly) UIImageView *avatar;

- (void)createLayoutWith:(SCNewsCommentListDataModel *)model;

+ (NSString *)cellidentifier;

@end
