//
//  LandlordCell.m
//  Athletics
//
//  Created by 李宛 on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LandlordCell.h"

@interface LandlordCell ()
{
    UIImageView        *_imageV;
    UILabel            *_hostNameLabel;
    UILabel            *_dateLabel;
    UILabel            *_commentLabel;
}
@end
static CGFloat k_left = 10.0f;
static CGFloat k_top = 15.0f;
static CGFloat k_margin = 7.0f;
static CGFloat kImageH = 32.0f;
@implementation LandlordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self uiConfig];
    }
    return self;

}

-(void)uiConfig{
    
    _imageV = [[UIImageView alloc]init];
    _imageV.contentMode = UIViewContentModeScaleAspectFill;
    _imageV.clipsToBounds = YES;
    _imageV.layer.cornerRadius = kImageH/2.0;
    [self.contentView addSubview:_imageV];
    
    _hostNameLabel = [[UILabel alloc]init];
    _hostNameLabel.textColor = kWord_Color_Low;
    _hostNameLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self.contentView addSubview:_hostNameLabel];
    
    _dateLabel = [[UILabel alloc]init];
    _dateLabel.textColor = kWord_Color_Low;
    _dateLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self.contentView addSubview:_dateLabel];
    
    _commentLabel = [[UILabel alloc]init];
    _commentLabel.textColor = kWord_Color_High;
    _commentLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [self.contentView addSubview:_commentLabel];
    
    _WEAKSELF(ws);
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).offset(k_left);
        make.top.equalTo(ws.contentView).offset(k_left);
        make.width.mas_equalTo(CGSizeMake(kImageH, kImageH));
    }];
    
    
    [_hostNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageV);
        make.left.equalTo(_imageV.mas_right).offset(k_left);
        make.right.equalTo(ws.contentView).offset(-k_left);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hostNameLabel.mas_bottom).offset(k_margin);
        make.left.right.equalTo(_hostNameLabel);
    }];
    
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_dateLabel);
        make.top.equalTo(_dateLabel.mas_bottom).offset(k_left);
        make.bottom.equalTo(ws.contentView).offset(-k_left);
    }];
}

-(void)createLayoutWith:(id)model
{
    _imageV.backgroundColor = k_Base_Color;
    _hostNameLabel.text = @"罗也无声";
    _dateLabel.text = @"1楼 2018-05-09 10:37";
    _commentLabel.text = @"24,打击都懂得，科迷无处不在";
    
}

+(NSString *)cellIdentifier
{
    return @"LandlordCellIdentifer";
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
