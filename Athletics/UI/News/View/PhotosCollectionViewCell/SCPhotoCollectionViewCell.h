//
//  SCPhotoCollectionViewCell.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCPhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *photoUrl;
@property (nonatomic, strong) UIImage *photoImage;
@property (nonatomic, assign) UIEdgeInsets zoomInset;

- (void)revertZoom;

+ (NSString *)cellIdentifier;

@end
