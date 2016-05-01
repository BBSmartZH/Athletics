//
//  SCVideoCollectionViewCell.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCVideoCoverDataModel;

static CGFloat SCVideoCollectionViewCellHeight = 120;
static CGFloat SCVideoCollectionViewCellWidth = 100;

@interface SCVideoCollectionViewCell : UICollectionViewCell

- (void)createLayoutWith:(SCVideoCoverDataModel *)model;

+ (NSString *)cellIdentifier;

@end
