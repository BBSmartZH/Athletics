//
//  SCPostsAdCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/15.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCPostsAdCell.h"

@interface SCPostsAdCell ()
{
    UIImageView *_imageView;
    UIView *_descBgView;
    UILabel *_descLabel;
    id _model;
}

@end

static CGFloat k_left = 10.0f;
static CGFloat k_top = 15.0f;

@implementation SCPostsAdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self uiConfig];
    }
    return self;
}

- (void)uiConfig {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = kWord_Color_Low;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    titleLabel.text = @"赞助商提供";
    [self.contentView addSubview:titleLabel];
    
    UIImageView *leftLine = [[UIImageView alloc] init];
    leftLine.backgroundColor = k_Border_Color;
    [self.contentView addSubview:leftLine];
    
    UIImageView *rightLine = [[UIImageView alloc] init];
    rightLine.backgroundColor = k_Border_Color;
    [self.contentView addSubview:rightLine];
    
    _descBgView = [[UIView alloc] init];
    _descBgView.backgroundColor = k_Base_Color;
    _descBgView.layer.cornerRadius = 2.0f;
    [self.contentView addSubview:_descBgView];
    
    _descLabel = [[UILabel alloc] init];
    _descLabel.textColor = [UIColor whiteColor];
    _descLabel.textAlignment = NSTextAlignmentCenter;
    _descLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    _descLabel.text = @"广告";
    [_descBgView addSubview:_descLabel];

    
    _imageView = [[UIImageView alloc] init];
    _imageView.clipsToBounds = YES;
    [self.contentView addSubview:_imageView];
    
    _WEAKSELF(ws);
    [titleLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_descLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];

    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView).offset(10);
        make.centerX.equalTo(ws.contentView);
    }];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).offset(k_left);
        make.centerY.equalTo(titleLabel);
        make.right.equalTo(titleLabel.mas_left).offset(-20);
        make.height.mas_equalTo(@.5f);
    }];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.centerY.equalTo(titleLabel);
        make.left.equalTo(titleLabel.mas_right).offset(20);
        make.height.equalTo(leftLine);
    }];
    [_descBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        make.right.equalTo(rightLine);
    }];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_descBgView);
        make.width.equalTo(_descBgView).offset(-6);
        make.height.equalTo(_descBgView).offset(-2);
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_descBgView.mas_bottom).offset(1);
        make.left.equalTo(ws.contentView).offset(k_left);
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.bottom.equalTo(ws.contentView).offset(-k_top);
    }];
}

- (void)createLayoutWith:(id)model {
    _model = model;
    CGSize imageSize = CGSizeZero;
    
    NSInteger number = ((NSNumber *)model).integerValue;
    if (number == 1) {
        imageSize = CGSizeMake(349, 250);
    }else {
        imageSize = CGSizeMake(690, 120);
    }
    _imageView.backgroundColor = [UIColor cyanColor];
}

+ (CGFloat)cellHeightWith:(id)model {
    CGFloat height = 0.0;
    height += 5;
    height += 14;
    height += 5;
    height += 14;

    CGSize imageSize = CGSizeZero;
    
    NSInteger number = ((NSNumber *)model).integerValue;
    if (number == 1) {
        imageSize = CGSizeMake(349, 250);
    }else {
        imageSize = CGSizeMake(690, 300);
    }
    
    height = ([UIScreen mainScreen].bounds.size.width - 2 * k_left) * (imageSize.height / imageSize.width);
    height += 1;
    height += k_top;
    
    return height;
}

+ (NSString *)cellIdentifier {
    return @"SCPostsAdCellIdentifier";
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
