//
//  SCPhotoCollectionViewCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCPhotoCollectionViewCell.h"

#import "SCPhotoZoomView.h"


@interface SCPhotoCollectionViewCell ()
{
    SCPhotoZoomView * _zoomView;
}

@end

@implementation SCPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _zoomView = [[SCPhotoZoomView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _zoomView.backgroundColor = [UIColor blackColor];
        [self addSubview:_zoomView];
    }
    return self;
}

- (void)setPhotoUrl:(NSString *)photoUrl {
    if (![_photoUrl isEqualToString:photoUrl]) {
        _photoUrl = photoUrl;
        [_zoomView setNetWorkImageWithUrl:_photoUrl];
    }
}

- (void)setPhotoImage:(UIImage *)photoImage {
    if (_photoImage != photoImage) {
        _photoImage = photoImage;
    }
}

- (void)setZoomInset:(UIEdgeInsets)zoomInset {
    if (_zoomInset.bottom != zoomInset.bottom || _zoomInset.top != zoomInset.top || _zoomInset.left != zoomInset.left || _zoomInset.right != zoomInset.right) {
        _zoomInset = zoomInset;
        
        [_zoomView setImageInset:_zoomInset];
    }
}

- (void)revertZoom {
    if (_zoomView) {
        [_zoomView setZoomScale:1.0f];
    }
}

+ (NSString *)cellIdentifier {
    return @"SCPhotoCollectionViewCellIdentifier";
}

@end
