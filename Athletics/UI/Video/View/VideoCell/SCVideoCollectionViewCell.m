//
//  SCVideoCollectionViewCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCVideoCollectionViewCell.h"

@interface SCVideoCollectionViewCell ()
{
    UIImageView *_imageView;
    UILabel *_timeLabel;
    UILabel *_titleLabel;
}

@end

static CGFloat k_left = 10.0f;

@implementation SCVideoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self uiConfig];
    }
    return self;
}

- (void)uiConfig {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.fWidth, 60)];
    _imageView.clipsToBounds = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_imageView];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.fWidth - 60, _imageView.fHeight - 16, 60, 16)];
    _timeLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    _timeLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_timeLabel];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _imageView.bottom + k_left, _imageView.fWidth, self.fHeight - _imageView.fHeight - k_left)];
    _titleLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    _titleLabel.textColor = kWord_Color_High;
    _titleLabel.numberOfLines = 3;
    [self.contentView addSubview:_titleLabel];
    
}

- (void)createLayoutWith:(id)model {
    _imageView.backgroundColor = [UIColor cyanColor];
    _timeLabel.text = @"120:23";
    _titleLabel.text = @"这是视频标题这是视频标题这是视频标题这是视频标题这是视频标题这是视频标题这是视频标题这是视频标题这是视频标题这是视频标题";
    //选中title变红色
//    _titleLabel.textColor = [UIColor redColor];
}

+ (NSString *)cellIdentifier {
    return @"SCVideoCollectionViewCellIdentifier";
}

@end
