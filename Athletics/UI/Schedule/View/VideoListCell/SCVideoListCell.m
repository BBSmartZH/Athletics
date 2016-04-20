//
//  SCVideoListCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCVideoListCell.h"

@interface SCVideoListCell ()
{
    UIImageView *_imageView;
    UIButton *_playButton;
    NSString *_url;
}

@end

static CGFloat k_top = 10.0f;
static CGFloat k_left = 10.0f;

@implementation SCVideoListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self uiConfig];
    }
    return self;
}

- (void)uiConfig {
    
    _imageView = [[UIImageView alloc] init];
    _imageView.clipsToBounds = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_imageView];
    
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _playButton.backgroundColor = [UIColor blueColor];
    [_playButton addTarget:self action:@selector(playButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:_playButton];
    
    _WEAKSELF(ws);
    
    CGFloat height = ([UIScreen mainScreen].bounds.size.width - 2 * k_left) * (9.0 / 16.0);

    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView).offset(k_top);
        make.left.equalTo(ws.contentView).offset(k_left);
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.bottom.equalTo(ws.contentView).offset(-k_top);
        make.height.mas_equalTo(@(height));
    }];
    
    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(64, 64));
        make.center.equalTo(_imageView);
    }];
    
}

- (CGRect)videoFrame {
    return _imageView.frame;
}

- (void)playButtonClicked:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(videoButtonClicked:inCell:)]) {
        [self.delegate videoButtonClicked:sender inCell:self];
    }
}

- (void)createLayoutWith:(id)model {
    _url = @"http://v.theonion.com/onionstudios/video/3158/640.mp4";
    _imageView.backgroundColor = [UIColor cyanColor];
}

+ (CGFloat)heightForCellWith:(id)model {
    CGFloat height = 0.0;
    
    height += k_top;
    height += ([UIScreen mainScreen].bounds.size.width - 2 * k_left) * (9.0 / 16.0);
    height += k_top;
    
    return height;
}

+ (NSString *)cellIdentifier {
    return @"SCVideoListCellIdentifier";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
