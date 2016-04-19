//
//  SCGuessListCell.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCGuessListCellDelegate <NSObject>

- (void)guessButtonClickedWith:(id)model isLeft:(BOOL)isLeft;

@end

@interface SCGuessListCell : UITableViewCell

@property (nonatomic, assign) id<SCGuessListCellDelegate> delegate;

- (void)createLayoutWith:(id)model;
+ (CGFloat)heightForCellWith:(id)model;
+ (NSString *)cellIdentifier;

@end
