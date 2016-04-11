//
//  LWPhotosNormalCell.m
//  Athletics
//
//  Created by 李宛 on 16/4/11.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWPhotosNormalCell.h"
static CGFloat k_left = 15.0;
static CGFloat k_spacing = 10.0;
@interface LWPhotosNormalCell ()
{
    UILabel          *_titleLabel;
    UIImageView      *_leftImageV;
    UIImageView      *_middleImageV;
    UIImageView      *_rightImageV;

}
@end

@implementation LWPhotosNormalCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_config];
    }
    return self;
}

-(void)p_config{
    self.type = 0;
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text = @"女的你看大哥哥结果多个不放假的开关和发规范梵蒂冈";
    _titleLabel.textColor = kWord_Color_High;
    _titleLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    _titleLabel.numberOfLines = 1;
    [self.contentView addSubview:_titleLabel];
    _leftImageV = [[UIImageView alloc]init];
    _leftImageV.contentMode = UIViewContentModeScaleAspectFill;
    _leftImageV.clipsToBounds = YES;
    _leftImageV.backgroundColor = k_Bg_Color;
    [self.contentView addSubview:_leftImageV];
    
    NSArray *imageArray = @[@1, @2, @3];
    if (imageArray.count == 1) {
        
    }else {
        
    }
    _WEAKSELF(ws);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).offset(k_left);
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.top.equalTo(ws.contentView).offset(k_left);
    }];
    
    [_leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).offset(k_left);
        make.top.equalTo(_titleLabel.mas_bottom).offset(k_spacing);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    if (self.type == 0) {
        _middleImageV = [[UIImageView alloc]init];
        _middleImageV.clipsToBounds = YES;
        _middleImageV.backgroundColor = k_Bg_Color;
        [self.contentView addSubview:_middleImageV];
        _rightImageV = [[UIImageView alloc]init];
        _rightImageV.clipsToBounds = YES;
        _rightImageV.backgroundColor = k_Bg_Color;
        [self.contentView addSubview:_rightImageV];
        [_leftImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(k_left);
            make.top.equalTo(_titleLabel.mas_bottom).offset(k_spacing);
            make.size.mas_equalTo(CGSizeMake((kScreenWidth-k_spacing*2-k_left*2)/3.0, 100));
        }];
        [_middleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftImageV.mas_right).offset(k_spacing);
            make.top.bottom.equalTo(_leftImageV);
            make.size.equalTo(_leftImageV);
        }];
        
        [_rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_middleImageV.mas_right).offset(k_spacing);
            make.top.bottom.equalTo(_middleImageV);
            make.size.equalTo(_middleImageV);
        }];
        
    }
    
}
-(void)configLayoutWithModel:(id)model
{
    
}
+(CGFloat)heightForRowWithPhotos{
    return 150;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
