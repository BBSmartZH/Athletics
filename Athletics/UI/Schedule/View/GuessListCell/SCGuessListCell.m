//
//  SCGuessListCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCGuessListCell.h"

@interface SCGuessListCell ()
{
    UILabel *_titleLabel;
    UILabel *_statusLabel;
    UIImageView *_leftImageV;
    UIImageView *_rightImageV;
    UIImageView *_vsImageV;
    UIButton *_leftGuessButton;
    UIButton *_rightGessButton;
}

@end

static CGFloat k_left = 10.0f;
static CGFloat k_top = 10.0f;

static CGFloat imageH = 64.0f;
static CGFloat buttonH = 36.0f;

@implementation SCGuessListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self uiConfig];
    }
    return self;
}

- (void)uiConfig {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    _titleLabel.textColor = kWord_Color_High;
    [self.contentView addSubview:_titleLabel];
    
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    _statusLabel.textAlignment = NSTextAlignmentRight;
    _statusLabel.textColor = kWord_Color_Event;
    [self.contentView addSubview:_statusLabel];
    
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = k_Border_Color;
    [self.contentView addSubview:topLine];
    
    _leftImageV = [[UIImageView alloc] init];
    _leftImageV.contentMode = UIViewContentModeScaleAspectFill;
    _leftImageV.layer.cornerRadius = imageH / 2.0;
    _leftImageV.layer.borderColor = k_Border_Color.CGColor;
    _leftImageV.layer.borderWidth = 2.0f;
    [self.contentView addSubview:_leftImageV];
    
    _rightImageV = [[UIImageView alloc] init];
    _rightImageV.contentMode = UIViewContentModeScaleAspectFill;
    _rightImageV.layer.cornerRadius = imageH / 2.0;
    _rightImageV.layer.borderColor = k_Border_Color.CGColor;
    _rightImageV.layer.borderWidth = 2.0f;
    [self.contentView addSubview:_rightImageV];
    
    _vsImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:_vsImageV];
    
    UIView *leftLine = [[UIView alloc] init];
    leftLine.backgroundColor = k_Border_Color;
    [self.contentView addSubview:leftLine];

    UIView *rightLine = [[UIView alloc] init];
    rightLine.backgroundColor = k_Border_Color;
    [self.contentView addSubview:rightLine];
    
    _leftGuessButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftGuessButton addTarget:self action:@selector(guessButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_leftGuessButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_leftGuessButton setTitleColor:kWord_Color_Low forState:UIControlStateDisabled];
    _leftGuessButton.layer.cornerRadius = 8.0f;
    _leftGuessButton.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self.contentView addSubview:_leftGuessButton];
    
    _rightGessButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightGessButton addTarget:self action:@selector(guessButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_rightGessButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightGessButton setTitleColor:kWord_Color_Low forState:UIControlStateDisabled];
    _rightGessButton.layer.cornerRadius = 8.0f;
    _rightGessButton.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self.contentView addSubview:_rightGessButton];
    
    _WEAKSELF(ws);
    [_titleLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_statusLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).offset(k_left);
        make.top.equalTo(ws.contentView).offset(k_top);
    }];
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.centerY.equalTo(_titleLabel);
    }];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(k_top);
        make.left.equalTo(_titleLabel);
        make.right.equalTo(_statusLabel);
        make.height.mas_equalTo(.5f);
    }];
    [_leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLine.mas_bottom).offset(2 * k_top);
        make.left.equalTo(ws.contentView).offset(4 * k_left);
        make.size.mas_equalTo(CGSizeMake(imageH, imageH));
    }];
    [_rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftImageV);
        make.right.equalTo(ws.contentView).offset(-4 * k_left);
        make.size.equalTo(_leftImageV);
    }];
    [_vsImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.contentView);
        make.centerY.equalTo(_leftImageV);
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageV.mas_right).offset(5);
        make.right.equalTo(_vsImageV.mas_left);
        make.centerY.equalTo(_vsImageV);
        make.height.mas_equalTo(.5f);
    }];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vsImageV.mas_right);
        make.right.equalTo(_rightImageV.mas_left).offset(-5);
        make.centerY.height.equalTo(leftLine);
    }];
    [_leftGuessButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftImageV.mas_bottom).offset(k_top);
        make.centerX.equalTo(_leftImageV);
        make.size.mas_equalTo(CGSizeMake(70, buttonH));
        make.bottom.equalTo(ws.contentView).offset(-k_top);
    }];
    [_rightGessButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftGuessButton);
        make.size.equalTo(_leftGuessButton);
        make.centerX.equalTo(_rightImageV);
    }];
    
}

- (void)guessButtonClicked:(UIButton *)sender {
    BOOL isLeft = NO;
    if (sender == _leftGuessButton) {
        isLeft = YES;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(guessButtonClickedWith:isLeft:)]) {
        [self.delegate guessButtonClickedWith:nil isLeft:isLeft];
    }
}

- (void)createLayoutWith:(id)model {
    _titleLabel.text = @"猜输赢";
    _statusLabel.text = @"已结算";
    BOOL isEnable = YES;
    if (isEnable) {
        _leftGuessButton.enabled = YES;
        _leftGuessButton.backgroundColor = k_Base_Color;
        _leftGuessButton.layer.borderWidth = 0.0f;
        [_leftGuessButton setTitle:@"1.80" forState:UIControlStateNormal];
        
        _rightGessButton.enabled = YES;
        _rightGessButton.backgroundColor = k_Base_Color;
        _rightGessButton.layer.borderWidth = 0.0f;
        [_rightGessButton setTitle:@"0.98" forState:UIControlStateNormal];
    }else {
        _leftGuessButton.enabled = NO;
        _leftGuessButton.backgroundColor = [UIColor whiteColor];
        _leftGuessButton.layer.borderColor = k_Border_Color.CGColor;
        _leftGuessButton.layer.borderWidth = 1.0f;
        [_leftGuessButton setTitle:@"1.80" forState:UIControlStateNormal];
        
        _rightGessButton.enabled = NO;
        _rightGessButton.backgroundColor = [UIColor whiteColor];
        _rightGessButton.layer.borderColor = k_Border_Color.CGColor;
        _rightGessButton.layer.borderWidth = 1.0f;
        [_rightGessButton setTitle:@"0.98" forState:UIControlStateNormal];
    }
    
    _leftImageV.backgroundColor = [UIColor cyanColor];
    _rightImageV.backgroundColor = [UIColor cyanColor];
    
    _vsImageV.backgroundColor = [UIColor blueColor];
}

+ (CGFloat)heightForCellWith:(id)model {
    CGFloat height = 0.0f;
    
    height += k_top;
    height += ([SCGlobaUtil sizeOfLabelWith:@"猜输赢" font:kWord_Font_28px width:MAXFLOAT].height);
    height += k_top;
    
    height += 0.5;
    height += (2 * k_top);
    height += imageH;
    height += k_top;
    
    height += buttonH;
    height += k_top;
    
    return height;
}

+ (NSString *)cellIdentifier {
    return @"SCGuessListCellIdentifier";
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
