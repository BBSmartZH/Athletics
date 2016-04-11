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
static CGFloat k_small = 5.0;

@interface LWPhotosNormalCell ()
{
    UILabel          *_titleLabel;
    UIImageView      *_leftImageV;
    UIImageView      *_middleImageV;
    UIImageView      *_rightImageV;
    UIImageView      *_commentsImageV;
    UIImageView      *_scanImageV;
    UILabel          *_commentsLabel;
    UILabel          *_scanLabel;

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
    _titleLabel.textColor = kWord_Color_High;
    _titleLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    _titleLabel.numberOfLines = 1;
    [self.contentView addSubview:_titleLabel];
    
    _leftImageV = [[UIImageView alloc]init];
    _leftImageV.contentMode = UIViewContentModeScaleAspectFill;
    _leftImageV.clipsToBounds = YES;
    [self.contentView addSubview:_leftImageV];
    
    _commentsImageV = [[UIImageView alloc]init];
    _commentsImageV.contentMode = UIViewContentModeScaleAspectFill;
    _commentsImageV.clipsToBounds = YES;
    [self.contentView addSubview:_commentsImageV];
    _scanImageV = [[UIImageView alloc]init];
    _scanImageV.contentMode = UIViewContentModeScaleAspectFill;
    _scanImageV.clipsToBounds = YES;
    [self.contentView addSubview:_scanImageV];
    
    _commentsLabel = [[UILabel alloc]init];
    _commentsLabel.textColor = kWord_Color_Low;
    _commentsLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    _commentsLabel.numberOfLines = 1;
    [self.contentView addSubview:_commentsLabel];
    
    _scanLabel = [[UILabel alloc]init];
    _scanLabel.textColor = kWord_Color_Low;
    _scanLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    _scanLabel.numberOfLines = 1;
    [self.contentView addSubview:_scanLabel];
    
    
    
    NSArray *imageArray = @[@1, @2, @3];
    if (imageArray.count == 1) {
        
    }else {
        
    }
    [_scanLabel setContentCompressionResistancePriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_scanImageV setContentCompressionResistancePriority:750 forAxis:UILayoutConstraintAxisHorizontal];
    [_scanLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_scanImageV setContentHuggingPriority:750 forAxis:UILayoutConstraintAxisHorizontal];
    [_commentsLabel setContentCompressionResistancePriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_commentsImageV setContentCompressionResistancePriority:750 forAxis:UILayoutConstraintAxisHorizontal];
    [_commentsLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    
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
    [_commentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftImageV.mas_bottom).offset(k_spacing);
        make.right.equalTo(ws.contentView).offset(-k_left);
//        make.width.mas_equalTo(@30);
    }];
    [_commentsImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_commentsLabel.mas_left).offset(-k_small);
        make.size.mas_equalTo(CGSizeMake(9, 9));
        make.centerY.equalTo(_commentsLabel);
    }];
    [_scanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commentsLabel);
        make.right.equalTo(_commentsImageV.mas_left).offset(-k_spacing);
//        make.width.mas_equalTo(@30);
    }];
    [_scanImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_scanLabel.mas_left).offset(-k_small);
        make.centerY.equalTo(_scanLabel);
        make.size.mas_equalTo(CGSizeMake(9, 9));
    }];
    
    if (self.type == 0) {
        _middleImageV = [[UIImageView alloc]init];
        _middleImageV.clipsToBounds = YES;
        [self.contentView addSubview:_middleImageV];
        _rightImageV = [[UIImageView alloc]init];
        _rightImageV.clipsToBounds = YES;
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
    _titleLabel.text = @"女的你看大哥哥结果多个不放假的开关和发规范梵蒂冈";
    _leftImageV.backgroundColor = k_Bg_Color;
    _commentsLabel.text = @"12334";
    _commentsImageV.backgroundColor = k_Bg_Color;
    _scanImageV.backgroundColor = k_Bg_Color;
    _middleImageV.backgroundColor = k_Bg_Color;
    _rightImageV.backgroundColor = k_Bg_Color;
    _scanLabel.text = @"114";


    

}
+(CGFloat)heightForRowWithPhotos{
    return 170;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
