//
//  SCScheduleListCell.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SCMacthAppointType) {
    SCMacthAppointTypeAppoint,
    SCMacthAppointTypeCancel,
};

@class SCMatchListDataModel;

@protocol SCScheduleListCellDelegate <NSObject>

- (void)appointButtonClicked:(UIButton *)sender type:(SCMacthAppointType)type model:(SCMatchListDataModel *)model;

@end

@interface SCScheduleListCell : UITableViewCell

@property (nonatomic, assign) id<SCScheduleListCellDelegate> delegate;

+ (NSString *)cellIdentifier;

- (void)createLayoutWith:(SCMatchListDataModel*)model;

@end
