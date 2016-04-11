//
//  LWNewsTypeNormalCell.m
//  Athletics
//
//  Created by 李宛 on 16/4/11.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWNewsTypeNormalCell.h"

static CGFloat k_left = 15;
static CGFloat k_spacing = 8;
@interface LWNewsTypeNormalCell ()
{
    UIImageView     *_leftImageV;
    UIImageView     *_iconImageV;
    UILabel         *_summaryLabel;
    UILabel         *_typeLabel;
    UIImageView     *_commentsImagV;
    UILabel         *_totalLabel;
    int             _type;
}
@end

@implementation LWNewsTypeNormalCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_uiConfig];
    }
    return self;
}

- (void)p_uiConfig {
    _type = 1;
    _leftImageV = [[UIImageView alloc]init];
    _leftImageV.contentMode = UIViewContentModeScaleAspectFill;
    _leftImageV.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_leftImageV];
    _iconImageV = [[UIImageView alloc]init];
    _iconImageV.layer.cornerRadius = 8;
    _iconImageV.clipsToBounds = YES;
    _iconImageV.contentMode = UIViewContentModeScaleAspectFill;
    _iconImageV.backgroundColor = [UIColor cyanColor];
    [_leftImageV addSubview:_iconImageV];
    _summaryLabel = [[UILabel alloc]init];
    _summaryLabel.textColor = kWord_Color_High;
    _summaryLabel.numberOfLines = 2;
    _summaryLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self.contentView addSubview:_summaryLabel];
    _typeLabel = [[UILabel alloc]init];
    _typeLabel.backgroundColor = [UIColor blueColor];
    _typeLabel.textColor = [UIColor whiteColor];
    _typeLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    [self.contentView addSubview:_typeLabel];
    
    _commentsImagV = [[UIImageView alloc]init];
    _commentsImagV.hidden = YES;
    _commentsImagV.contentMode = UIViewContentModeScaleAspectFill;
    _commentsImagV.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_commentsImagV];
    _totalLabel = [[UILabel alloc]init];
    _totalLabel.textColor = kWord_Color_Low;
    _totalLabel.hidden = YES;
    _totalLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    [self.contentView addSubview:_totalLabel];
     _summaryLabel.text = @"是快递费三法师的；这你怎么想新东方的发布过是快递费三法师的；这你怎么想新东方的发布过";
    _typeLabel.text = @"视频辑";
    _totalLabel.text = @"1234";
    [_totalLabel setContentCompressionResistancePriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_commentsImagV setContentCompressionResistancePriority:750 forAxis:UILayoutConstraintAxisHorizontal];
    [_totalLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    _WEAKSELF(ws);
    [_leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).offset(k_left);
        make.top.equalTo(ws.contentView).offset(k_left);
        make.bottom.equalTo(ws.contentView).offset(-k_left);
        make.width.mas_equalTo(@80);
    }];
    
    [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_leftImageV.mas_right).offset(-k_spacing);
        make.bottom.equalTo(_leftImageV).offset(-k_spacing);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    [_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageV.mas_right).offset(k_left);
        make.top.equalTo(_leftImageV);
        make.right.equalTo(ws.contentView).offset(-k_left);
    }];
    
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.contentView).offset(-k_left);
        make.right.equalTo(_summaryLabel);
        make.width.mas_equalTo(@50);
    }];
    [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.bottom.equalTo(ws.contentView).offset(-k_left);
        make.width.mas_equalTo(@30);
    }];
    
    [_commentsImagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_totalLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.bottom.equalTo(_totalLabel);
    }];
    
    if (_type == 1) {
        _typeLabel.hidden = YES;
        _totalLabel.hidden = NO;
        _commentsImagV.hidden = NO;
    }
    
    
}

-(void)configLayoutWithModel:(id)model
{
    
    
}
+(CGFloat)heightForRow
{
    return 100;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
