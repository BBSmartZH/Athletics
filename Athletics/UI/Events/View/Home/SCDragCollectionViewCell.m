//
//  SCDragCollectionViewCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/12.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCDragCollectionViewCell.h"

@interface SCDragCollectionViewCell ()
{
    UILabel *_titleLabel;
    UIImageView *_imageView;
    
    UIImageView *_addImageView;
}

@end

@implementation SCDragCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat width = frame.size.width * 0.4;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - width) / 2.0, (frame.size.height - width - 20 - 10) / 2.0, width, width)];
//        _imageView.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, frame.size.height - 20 - 10, frame.size.width - 10, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:12.0f * ([UIScreen mainScreen].bounds.size.width / 320.0)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_titleLabel];
        
        _addImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 20, 0, 20, 20)];
        _addImageView.image = [UIImage imageNamed:@"add_customsize"];
        [self.contentView addSubview:_addImageView];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    if (![_title isEqualToString:title]) {
        _title = title;
        _titleLabel.text = _title;
    }
}

- (void)setImageUrl:(NSString *)imageUrl {
    if (![_imageUrl isEqualToString:imageUrl]) {
        _imageUrl = imageUrl;
        [_imageView scImageWithURL:_imageUrl placeholderImage:nil];
    }
}

- (void)setIsChoose:(BOOL)isChoose {
    if (_isChoose != isChoose) {
        _isChoose = isChoose;
        _addImageView.hidden = _isChoose;
    }
}

@end
