//
//  SCVideoCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCVideoCell.h"

#import "SCVideoListModel.h"

@interface SCVideoCell ()
{
    UIImageView *_leftImageV;
    UIView *_durationBgView;
    UILabel *_durationLabel;
    UILabel *_titleLabel;
    UILabel *_timeLabel;
    SCVideoListDataModel *_model;
}

@end

static CGFloat k_left = 10.0f;

static CGFloat imageW = 90.0f;
static float scale = 0.75;

@implementation SCVideoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_uiConfig];
    }
    return self;
}

- (void)p_uiConfig {
    
    self.backgroundColor = [UIColor whiteColor];
    
    _leftImageV = [[UIImageView alloc]init];
    _leftImageV.contentMode = UIViewContentModeScaleAspectFill;
    _leftImageV.clipsToBounds = YES;
    _leftImageV.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_leftImageV];
    
    _durationBgView = [[UIView alloc] init];
    _durationBgView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4];
    [_leftImageV addSubview:_durationBgView];
    
    _durationLabel = [[UILabel alloc]init];
    _durationLabel.textColor = [UIColor whiteColor];
    _durationLabel.textAlignment = NSTextAlignmentRight;
    _durationLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    [_durationBgView addSubview:_durationLabel];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = kWord_Color_High;
    _titleLabel.numberOfLines = 2;
    _titleLabel.font = [UIFont systemFontOfSize:kWord_Font_30px];
    [self.contentView   addSubview:_titleLabel];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.textColor = kWord_Color_Low;
    _timeLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    [self.contentView  addSubview:_timeLabel];
    
    _WEAKSELF(ws);
    
    CGFloat imageWidth = imageW * ([UIScreen mainScreen].bounds.size.width / 320.0);
    [_leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).offset(k_left);
        make.top.equalTo(ws.contentView).offset(k_left);
        make.bottom.lessThanOrEqualTo(ws.contentView).offset(-k_left);
        make.size.mas_equalTo(CGSizeMake(imageWidth, floorf(imageWidth * scale)));
    }];
    
    [_durationBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(_leftImageV);
    }];
    [_durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_durationBgView).offset(1);
        make.left.equalTo(_durationBgView).offset(5);
        make.right.equalTo(_durationBgView).offset(-5);
        make.bottom.equalTo(_durationBgView).offset(-1);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageV.mas_right).offset(k_left);
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.top.equalTo(_leftImageV);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_titleLabel);
        make.top.greaterThanOrEqualTo(_titleLabel.mas_bottom).offset(k_left);
        make.bottom.equalTo(ws.contentView).offset(-k_left);
    }];
    
};

- (void)createLayoutWith:(SCVideoListDataModel *)model {
    _model = model;
    [_leftImageV scImageWithURL:model.image.url placeholderImage:[UIImage imageNamed:@"default_image"]];
    _titleLabel.text = _model.title;
    _timeLabel.text = _model.uploadDate;//5秒前  12分钟前   2016-04-04
    _durationLabel.text = _model.videoLength;
}

+ (NSString *)cellIdentifier {
    return @"SCVideoCellIdentifier";
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
