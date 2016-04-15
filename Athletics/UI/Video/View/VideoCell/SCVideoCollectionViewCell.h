//
//  SCVideoCollectionViewCell.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat SCVideoCollectionViewCellHeight = 120;
static CGFloat SCVideoCollectionViewCellWidth = 100;

@interface SCVideoCollectionViewCell : UICollectionViewCell

- (void)createLayoutWith:(id)model;

+ (NSString *)cellIdentifier;

@end
