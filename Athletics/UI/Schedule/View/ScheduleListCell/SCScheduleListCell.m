//
//  SCScheduleListCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCScheduleListCell.h"


@interface SCScheduleListCell ()
{
    UIImageView *_leftImageV;
    UILabel     *_leftLabel;
    UIImageView *_rightImageV;
    UILabel     *_rightLabel;
    UILabel     *_scoreLabel;
    UILabel     *_timeLabel;
    UIImageView *_stateImageV;
    UILabel     *_stateLabel;
    UIButton    *_appointButton;
}

@end

static CGFloat imageW = 64.0f;
static CGFloat k_left = 10.0f;

@implementation SCScheduleListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self uiConfig];
    }
    return self;
}

- (void)uiConfig {
    
    _leftImageV = [[UIImageView alloc] init];
    _leftImageV.contentMode = UIViewContentModeScaleAspectFill;
    _leftImageV.clipsToBounds = YES;
    [self.contentView addSubview:_leftImageV];
    
    _leftLabel = [[UILabel alloc] init];
    _leftLabel.textAlignment = NSTextAlignmentCenter;
    _leftLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [self.contentView addSubview:_leftLabel];
    
    _rightImageV = [[UIImageView alloc] init];
    _rightImageV.contentMode = UIViewContentModeScaleAspectFill;
    _rightImageV.clipsToBounds = YES;
    [self.contentView addSubview:_rightImageV];
    
    _rightLabel = [[UILabel alloc] init];
    _rightLabel.textAlignment = NSTextAlignmentCenter;
    _rightLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [self.contentView addSubview:_rightLabel];
    
    _scoreLabel = [[UILabel alloc] init];
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    _scoreLabel.font = [UIFont systemFontOfSize:kWord_Font_40px];
    [self.contentView addSubview:_scoreLabel];
    
    _stateLabel = [[UILabel alloc] init];
    _stateLabel.textAlignment = NSTextAlignmentCenter;
    _stateLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    [self.contentView addSubview:_stateLabel];
    
    _stateImageV = [[UIImageView alloc] init];
    _stateImageV.contentMode = UIViewContentModeScaleAspectFill;
    _stateImageV.clipsToBounds = YES;
    [self.contentView addSubview:_stateImageV];
    
    _appointButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_appointButton setImage:nil forState:UIControlStateNormal];
    [_appointButton setImage:nil forState:UIControlStateSelected];
    [_appointButton addTarget:self action:@selector(appointButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_appointButton];
    
     _timeLabel = [[UILabel alloc] init];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    [self.contentView addSubview:_timeLabel];
    
    
    _WEAKSELF(ws);
    CGFloat imageWidth = imageW * ([UIScreen mainScreen].bounds.size.width / 320.0);
    [_leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView).offset(15);
        make.left.equalTo(ws.contentView).offset(20);
        make.size.mas_equalTo(CGSizeMake(imageWidth, imageWidth));
    }];
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftImageV.mas_bottom).offset(k_left);
        make.left.equalTo(ws.contentView).offset(k_left);
        make.centerX.equalTo(_leftImageV);
        make.bottom.equalTo(ws.contentView).offset(-15);
    }];
    [_rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftImageV);
        make.right.equalTo(ws.contentView).offset(-20);
        make.size.equalTo(_leftImageV);
    }];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.centerX.equalTo(_rightImageV);
        make.centerY.equalTo(_leftLabel);
    }];
    [_scoreLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.contentView);
        make.centerY.equalTo(_leftImageV);
    }];
    [_stateLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftLabel);
        make.centerX.equalTo(_scoreLabel).offset(4);
    }];
    [_stateImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_stateLabel);
        make.right.equalTo(_stateLabel.mas_left).offset(-5);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    [_timeLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_appointButton);
        make.bottom.equalTo(_stateLabel.mas_top).offset(-k_left);
    }];
    [_appointButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.contentView);
        make.centerY.equalTo(_leftImageV);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    
    
}

- (void)appointButtonClicked:(UIButton *)sender {
    
}

+ (NSString *)cellIdentifier {
    return @"SCScheduleListCellIdentifier";
}

- (void)createLayoutWith:(id)model {
//    _leftImageV.backgroundColor = [UIColor cyanColor];
//    _rightImageV.backgroundColor = [UIColor cyanColor];
    _stateImageV.backgroundColor = [UIColor cyanColor];
    
    _leftLabel.text = @"VG";
    [_leftImageV scImageWithURL:@"http://static.a.carry6.com/img/dota2/team/1.png" placeholderImage:nil];
    _rightLabel.text = @"LGD";
    [_rightImageV scImageWithURL:@"http://static.a.carry6.com/img/dota2/team/8.png" placeholderImage:nil];

    _appointButton.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4];
    _scoreLabel.text = @"2:1";
    _stateLabel.text = @"看视频";
    _timeLabel.text = @"15日17:00";
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
