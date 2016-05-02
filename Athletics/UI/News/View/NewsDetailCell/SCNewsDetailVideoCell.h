//
//  SCNewsDetailVideoCell.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/16.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCContentListModel;

@protocol SCNewsDetailVideoCellDelegate <NSObject>

- (void)playButtonClickedWith:(SCContentListModel *)model;

@end

@interface SCNewsDetailVideoCell : UITableViewCell

@property (nonatomic, assign) id<SCNewsDetailVideoCellDelegate> delegate;

- (void)createLayoutWith:(SCContentListModel *)model;

+ (NSString *)cellIdentifier;

+ (CGFloat)cellHeightWith:(SCContentListModel *)model;

@end
