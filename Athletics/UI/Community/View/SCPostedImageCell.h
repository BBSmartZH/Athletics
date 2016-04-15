//
//  SCPostedImageCell.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCPostedImageCellDelegate <NSObject>

- (void)deletePostedImageWith:(NSIndexPath *)indexPath;

@end

@interface SCPostedImageCell : UICollectionViewCell

@property (nonatomic, assign) id<SCPostedImageCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, assign) BOOL hiddenDeleteButton;

+ (NSString *)cellIdeatifier;

@end
