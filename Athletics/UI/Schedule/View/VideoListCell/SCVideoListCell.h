//
//  SCVideoListCell.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCVideoListCell, SCScheduleVideoListDataModel;

@protocol SCVideoListCellDelegate <NSObject>

- (void)videoButtonClicked:(UIButton *)sender inCell:(SCVideoListCell *)inCell withModel:(SCScheduleVideoListDataModel *)model;

@end

@interface SCVideoListCell : UITableViewCell

@property (nonatomic, assign) id<SCVideoListCellDelegate> delegate;
@property (nonatomic, assign, readonly) CGRect videoFrame;

- (void)createLayoutWith:(SCScheduleVideoListDataModel *)model;

+ (CGFloat)heightForCellWith:(SCScheduleVideoListDataModel *)model;

+ (NSString *)cellIdentifier;

@end
