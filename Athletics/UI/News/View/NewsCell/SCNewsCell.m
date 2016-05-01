//
//  SCNewsCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNewsCell.h"
#import "SCNewsListModel.h"

@interface SCNewsCell ()
{
    UIImageView *_leftImageV;
    UIImageView *_markImageV;
    UILabel *_titleLabel;
    UILabel *_descLabel;
    UILabel *_timeLabel;
    UILabel *_commentLabel;
    UIImageView *_commentImageV;
    SCNewsListDataModel *_model;
}

@end

static CGFloat k_left = 10.0f;

static CGFloat imageW = 90.0f;
static float scale = 0.65;

@implementation SCNewsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_uiConfig];
    }
    return self;
}

- (void)p_uiConfig {
    
    _leftImageV = [[UIImageView alloc]init];
    _leftImageV.contentMode = UIViewContentModeScaleAspectFill;
    _leftImageV.clipsToBounds = YES;
    [self.contentView addSubview:_leftImageV];
    
    _markImageV = [[UIImageView alloc]init];
    _markImageV.layer.cornerRadius = 8;
    _markImageV.clipsToBounds = YES;
    _markImageV.contentMode = UIViewContentModeScaleAspectFill;
    _markImageV.backgroundColor = [UIColor cyanColor];
    _markImageV.hidden = YES;
    [_leftImageV addSubview:_markImageV];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = kWord_Color_High;
    _titleLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [self.contentView addSubview:_titleLabel];
    
    _descLabel = [[UILabel alloc]init];
    _descLabel.numberOfLines = 2;
    _descLabel.textColor = kWord_Color_Event;
    _descLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self.contentView addSubview:_descLabel];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.textColor = kWord_Color_Low;
    _timeLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    [self.contentView addSubview:_timeLabel];
    
    _commentLabel = [[UILabel alloc]init];
    _commentLabel.textColor = kWord_Color_Low;
    _commentLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    _commentLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_commentLabel];
    
    _commentImageV = [[UIImageView alloc]init];
    _commentImageV.contentMode = UIViewContentModeScaleAspectFill;
    _commentImageV.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_commentImageV];
    
    [_timeLabel setContentCompressionResistancePriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_commentLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    CGFloat imageWidth = imageW * ([UIScreen mainScreen].bounds.size.width / 320.0);
    _WEAKSELF(ws);
    [_leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).offset(k_left);
        make.top.equalTo(ws.contentView).offset(k_left);
        make.bottom.lessThanOrEqualTo(ws.contentView).offset(-k_left);
        make.size.mas_equalTo(CGSizeMake(imageWidth, floorf(imageWidth * scale)));
    }];
    
    [_markImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_leftImageV.mas_right).offset(-10);
        make.bottom.equalTo(_leftImageV).offset(-10);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageV.mas_right).offset(10);
        make.top.equalTo(_leftImageV);
        make.right.equalTo(ws.contentView).offset(-k_left);
    }];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        make.left.right.equalTo(_titleLabel);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.greaterThanOrEqualTo(_descLabel.mas_bottom).offset(k_left);
        make.bottom.equalTo(ws.contentView).offset(-k_left);
    }];
    
    [_commentImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLabel.mas_right).offset(5);
        make.right.equalTo(_commentLabel.mas_left).offset(-2);
        make.centerY.equalTo(_commentLabel);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.top.bottom.equalTo(_timeLabel);
    }];
    
};

- (void)createLayoutWith:(SCNewsListDataModel *)model {
    _model = model;
    _titleLabel.text = _model.title;
    _descLabel.text = _model.desc;
    _timeLabel.text = _model.pub_time;
    _commentLabel.text = [NSString stringWithFormat:@"%@", _model.commentsNum];
    _commentImageV.hidden = NO;
    if ([SCGlobaUtil getInt:_model.type] == 2) {
        _markImageV.hidden = NO;
    }else {
        _markImageV.hidden = YES;
    }
    [_leftImageV scImageWithURL:_model.imgUrl placeholderImage:nil];
}

+ (NSString *)cellIdentifier {
    return @"SCNewsCellIdentifier";
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
