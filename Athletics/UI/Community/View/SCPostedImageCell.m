//
//  SCPostedImageCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCPostedImageCell.h"

@interface SCPostedImageCell ()
{
    UIButton *_deleteButton;
    UIImageView *_imageView;
    UILabel *_sizeLabel;
}

@end

@implementation SCPostedImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, frame.size.width - 6, frame.size.height - 6 - 14 - 2)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.layer.borderWidth = .5f;
        _imageView.layer.borderColor = k_Border_Color.CGColor;
        [self addSubview:_imageView];
        
        _sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.left, _imageView.bottom + 2, _imageView.fWidth, 12)];
        _sizeLabel.textColor = kWord_Color_Event;
        _sizeLabel.font = [UIFont systemFontOfSize:8];
        _sizeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_sizeLabel];
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.frame = CGRectMake(frame.size.width - 20, 0, 20, 20);
        _deleteButton.layer.cornerRadius = 10.0f;
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
        _deleteButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
        [self addSubview:_deleteButton];
    }
    return self;
}

- (void)deleteButtonClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deletePostedImageWith:)]) {
        [self.delegate deletePostedImageWith:_indexPath];
    }
}

- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
        _imageView.image = image;
    }
}

- (void)setSize:(NSString *)size {
    if (_size != size) {
        _size = size;
        _sizeLabel.text = _size;
    }
}

- (void)setHiddenDeleteButton:(BOOL)hiddenDeleteButton {
    if (_hiddenDeleteButton != hiddenDeleteButton) {
        _hiddenDeleteButton = hiddenDeleteButton;
        
        _deleteButton.hidden = _hiddenDeleteButton;
    }
}

+ (NSString *)cellIdeatifier {
    return @"SCPostedImageCellIdeatifier";
}

@end
