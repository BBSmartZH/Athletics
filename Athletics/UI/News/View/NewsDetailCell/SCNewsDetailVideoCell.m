//
//  SCNewsDetailVideoCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/16.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNewsDetailVideoCell.h"

#import "SCContentListModel.h"

@interface SCNewsDetailVideoCell ()
{
    UIImageView *_imageView;
    UIButton *_playButton;
    NSString *_url;
    SCContentListModel *_model;
}

@end

static CGFloat k_top = 10.0f;
static CGFloat k_left = 10.0f;

@implementation SCNewsDetailVideoCell

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

    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView).offset(k_top);
        make.left.equalTo(ws.contentView).offset(k_left);
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.bottom.equalTo(ws.contentView).offset(-k_top);
    }];
    
    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(64, 64));
        make.center.equalTo(_imageView);
    }];
    
}

- (void)playButtonClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(playButtonClickedWith:)]) {
        [self.delegate playButtonClickedWith:_model];
    }
}

- (void)createLayoutWith:(SCContentListModel *)model {
    _model = model;
    [_imageView scImageWithURL:_model.video.image.url placeholderImage:[UIImage imageNamed:@"default_image"]];
}

+ (CGFloat)cellHeightWith:(SCContentListModel *)model {
    CGFloat height = 0.0;
    
    height += k_top;
    height += ([UIScreen mainScreen].bounds.size.width - 2 * k_left) * (9.0 / 16.0);
    height += k_top;
    
    return height;
}

+ (NSString *)cellIdentifier {
    return @"SCNewsDetailVideoCellIdentifier";
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
