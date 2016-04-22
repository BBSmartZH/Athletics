//
//  SCVideoListCell.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCVideoListCell;

@protocol SCVideoListCellDelegate <NSObject>

- (void)videoButtonClicked:(UIButton *)sender  inCell:(SCVideoListCell *)inCell;

@end

@interface SCVideoListCell : UITableViewCell

@property (nonatomic, assign) id<SCVideoListCellDelegate> delegate;
@property (nonatomic, assign, readonly) CGRect videoFrame;

- (void)createLayoutWith:(id)model;

+ (CGFloat)heightForCellWith:(id)model;

+ (NSString *)cellIdentifier;

@end
