//
//  SCCommonCell.m
//  MrzjShop
//
//  Created by mrzj_sc on 15/10/27.
//  Copyright © 2015年 mrzj_sc. All rights reserved.
//

#import "SCCommonCell.h"

@interface SCCommonCell ()
{
    UIImageView *_leftImageV;
    UILabel     *_leftLabel;
    UILabel     *_rightLabel;
    UIImageView *_arrowImageV;
}

@end

CGFloat left = 15;

@implementation SCCommonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_uiConfig];
    }
    return self;
}

- (void)p_uiConfig {
    _leftImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:_leftImageV];
    
    _leftLabel = [[UILabel alloc] init];
    _leftLabel.textColor = kWord_Color_High;
    _leftLabel.textAlignment = NSTextAlignmentLeft;
    _leftLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [self.contentView addSubview:_leftLabel];
    
    _rightLabel = [[UILabel alloc] init];
    _rightLabel.textColor = kWord_Color_Event;
    _rightLabel.textAlignment = NSTextAlignmentRight;
    _rightLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self.contentView addSubview:_rightLabel];
    
    _arrowImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_right"]];
    [self.contentView addSubview:_arrowImageV];
    
    [_rightLabel setContentCompressionResistancePriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_rightLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    
    _WEAKSELF(ws);
    [_leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(ws.contentView).offset(left);
    }];
    
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageV.mas_right).offset(left);
        make.right.equalTo(_rightLabel.mas_left).offset(-left);
        make.top.equalTo(ws.contentView).offset(left);
        make.bottom.equalTo(ws.contentView).offset(-left);
        make.width.mas_greaterThanOrEqualTo(@80);
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView);
        make.right.equalTo(_arrowImageV.mas_left).offset(-left);
        make.top.mas_greaterThanOrEqualTo(ws.contentView).offset(left);
        make.bottom.mas_lessThanOrEqualTo(ws.contentView).offset(-left);
    }];
    
    [_arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView);
        make.size.mas_equalTo(CGSizeMake(9, 16));
        make.right.equalTo(ws.contentView).offset(-left);
    }];
}

-(void)setLeftImage:(UIImage *)leftImage {
    _leftImage = leftImage;
    _WEAKSELF(ws);
    if (leftImage) {
        _leftImageV.image = _leftImage;
        _leftImageV.hidden = NO;
        [_leftLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftImageV.mas_right).offset(left);
            make.right.equalTo(_rightLabel.mas_left).offset(-left);
            make.top.equalTo(ws.contentView).offset(left);
            make.bottom.equalTo(ws.contentView).offset(-left);
            make.width.mas_greaterThanOrEqualTo(@80);
        }];
    }else {
        _leftImageV.image = _leftImage;
        _leftImageV.hidden = YES;
        [_leftLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftImageV);
            make.right.equalTo(_rightLabel.mas_left).offset(-left);
            make.top.equalTo(ws.contentView).offset(left);
            make.bottom.equalTo(ws.contentView).offset(-left);
            make.width.mas_greaterThanOrEqualTo(@80);
        }];
    }
}

- (void)setArrowRight:(BOOL)arrowRight {
    _arrowRight = arrowRight;
    _WEAKSELF(ws);
    if (arrowRight) {
        _arrowImageV.hidden = NO;
        [_rightLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_arrowImageV.mas_left).offset(-left);
        }];
    }else {
        _arrowImageV.hidden = YES;
        [_rightLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws.contentView).offset(-left);
        }];
    }
}



- (UILabel *)leftLabel {
    return _leftLabel;
}

- (UILabel *)rightLabel {
    return _rightLabel;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
