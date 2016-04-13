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
}

@end

@implementation SCDragCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width - 80) / 2.0, (frame.size.height - 20) / 2.0, 80, 20)];
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    if (![_title isEqualToString:title]) {
        _title = title;
        _titleLabel.text = _title;
    }
}

@end
