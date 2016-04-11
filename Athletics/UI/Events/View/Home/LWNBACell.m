//
//  LWNBACell.m
//  Athletics
//
//  Created by 李宛 on 16/4/11.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWNBACell.h"


@interface LWNBACell ()
{
    UIImageView    *_topImagV;
    UILabel        *_topTeamNameLabel;
    UILabel        *_topScore;
    UIImageView    *_rivalImagV;
    UILabel        *_rivalTeamNameLabel;
    UILabel        *_rivalScore;
    UILabel        *_matchLabel;
    UILabel        *_videoLabel;
    UILabel        *_timeLabel;
    UIButton       *_reservationButton;
    UIImageView    *_videoImageV;
    UILabel        *_totalLabel;
    
    BOOL            _start;
}
@end

static CGFloat k_left = 15.0;
static CGFloat k_spacing = 10.0;
static CGFloat k_small = 5.0;

@implementation LWNBACell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_uiConfig];
    }
    return self;
}

- (void)p_uiConfig {
    _start = NO;
    _topImagV = [[UIImageView alloc]init];
    _topImagV.contentMode = UIViewContentModeScaleAspectFill;
    _topImagV.clipsToBounds = YES;
    [self.contentView addSubview:_topImagV];
    
    _topTeamNameLabel = [[UILabel alloc]init];
    _topTeamNameLabel.textColor = kWord_Color_High;
    _topTeamNameLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self.contentView addSubview:_topTeamNameLabel];
    
    _topScore = [[UILabel alloc]init];
    _topScore.textColor = kWord_Color_High;
    _topScore.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self.contentView addSubview:_topScore];
    
    
    _rivalImagV = [[UIImageView alloc]init];
    _rivalImagV.contentMode = UIViewContentModeScaleAspectFill;
    _rivalImagV.clipsToBounds = YES;
    [self.contentView addSubview:_rivalImagV];
    
    _rivalTeamNameLabel = [[UILabel alloc]init];
    _rivalTeamNameLabel.textColor = kWord_Color_High;
    _rivalTeamNameLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self.contentView addSubview:_rivalTeamNameLabel];
    
    _rivalScore = [[UILabel alloc]init];
    _rivalScore.textColor = kWord_Color_High;
    _rivalScore.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self.contentView addSubview:_rivalScore];
    
    _matchLabel = [[UILabel alloc]init];
    _matchLabel.textColor = kWord_Color_Low;
    _matchLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    [self.contentView addSubview:_matchLabel];
    
    _videoLabel = [[UILabel alloc]init];
    _videoLabel.textColor = kWord_Color_High;
    _videoLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self.contentView addSubview:_videoLabel];
    
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.textColor = kWord_Color_Low;
    _timeLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self.contentView addSubview:_timeLabel];
    
    
    _videoImageV = [[UIImageView alloc]init];
    _videoImageV.contentMode = UIViewContentModeScaleAspectFill;
    _videoImageV.clipsToBounds = YES;
    _videoImageV.layer.cornerRadius = 15;
    [self.contentView addSubview:_videoImageV];
    
    _reservationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _reservationButton.layer.cornerRadius = 15;
    _reservationButton.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [_reservationButton addTarget:self action:@selector(p_buttonCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_reservationButton];
    
    
    _totalLabel = [[UILabel alloc]init];
    _totalLabel.textColor = kWord_Color_Low;
    _totalLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    [self.contentView addSubview:_totalLabel];

    
    _WEAKSELF(ws);
    
    [_topImagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).offset(k_left);
        make.top.equalTo(ws.contentView).offset(k_left);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    
    [_rivalImagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topImagV.mas_bottom).offset(k_spacing);
        make.left.equalTo(_topImagV);
        make.size.equalTo(_topImagV);
    }];
    
    [_topTeamNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_topImagV);
        make.left.equalTo(_topImagV.mas_right).offset(k_spacing);
        make.width.mas_equalTo(@50);
    }];
    
    [_rivalTeamNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_rivalImagV);
        make.left.equalTo(_rivalImagV.mas_right).offset(k_spacing);
        make.width.equalTo(_topTeamNameLabel);
    }];
    
    [_matchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_rivalImagV.mas_bottom).offset(k_spacing);
        make.left.equalTo(_rivalImagV);
        make.width.mas_equalTo(@100);
        make.bottom.equalTo(ws.contentView).offset(-k_left);
    }];
    
    [_topScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topTeamNameLabel);
        make.left.equalTo(_topTeamNameLabel.mas_right).offset(3*k_left);
        make.width.mas_equalTo(@10);
    }];
    
    [_rivalScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topScore.mas_bottom);
        make.left.equalTo(_topScore);
        make.width.equalTo(_topScore);
    }];
    
    [_videoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topTeamNameLabel.mas_right).offset(3*k_left);
        make.top.equalTo(ws.contentView).offset(k_left*2);
        make.width.equalTo(@80);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_videoLabel);
        make.top.equalTo(_videoLabel.mas_bottom).offset(k_small);
        make.width.equalTo(_videoLabel);
    }];
    
    [_videoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView).offset(k_left*2);
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    [_reservationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(_videoImageV);
        make.size.equalTo(_videoImageV);
    }];
    
    [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_matchLabel);
        make.right.equalTo(ws.contentView).offset(k_left);
        make.width.equalTo(_matchLabel);
    }];
    
    if (_start == YES) {
        _topScore.hidden = NO;
        _rivalScore.hidden = NO;
        _videoImageV.hidden = NO;
        _totalLabel.hidden = NO;
        _videoLabel.hidden = YES;
        _timeLabel.hidden = YES;
        _reservationButton.hidden = YES;
    }else{
        _topScore.hidden = YES;
        _rivalScore.hidden = YES;
        _videoImageV.hidden = YES;
        _totalLabel.hidden = YES;
        _videoLabel.hidden = NO;
        _timeLabel.hidden = NO;
        _reservationButton.hidden = NO;
    }
        
    
}
-(void)configLayoutWithModel:(id)model
{
    _topImagV.backgroundColor = k_Base_Color;
    _rivalImagV.backgroundColor = k_Base_Color;
    _reservationButton.backgroundColor = k_Base_Color;
    [_reservationButton setTitle:@"预约" forState:UIControlStateNormal];
    _videoImageV.backgroundColor = k_Base_Color;
    _topTeamNameLabel.text = @"利物浦";
    _rivalTeamNameLabel.text = @"斯托克城";
    _topScore.text = @"4";
    _rivalScore.text = @"1";
    _matchLabel.text = @"英超第33轮";
    _videoLabel.text = @"图文直播";
    _timeLabel.text = @"04-16 02:00";
    _totalLabel.text = @"8.3万人看过";
    
}
+(CGFloat)heightForRow
{
    return 120;
}
-(void)p_buttonCliked:(UIButton*)sender
{
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
