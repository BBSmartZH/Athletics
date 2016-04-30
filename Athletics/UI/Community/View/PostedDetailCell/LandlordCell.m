//
//  LandlordCell.m
//  Athletics
//
//  Created by 李宛 on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LandlordCell.h"
#import "SCTopicReplayListModel.h"

@interface LandlordCell ()
{
    UIImageView        *_imageV;
    UILabel            *_hostNameLabel;
    UILabel            *_dateLabel;
    UILabel            *_commentLabel;
    UIView             *_lineView;
}
@end
static CGFloat k_left = 10.0f;
//static CGFloat k_top = 15.0f;
static CGFloat k_margin = 5.0f;
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
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = k_Bg_Color;
    [self.contentView addSubview:_lineView];
    
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
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(ws.contentView).offset(k_left);
        make.right.equalTo(ws.contentView);
        make.top.equalTo(ws.contentView).offset(k_left);
        make.height.mas_equalTo(@0.5);
    }];
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).offset(k_left);
        make.top.equalTo(_lineView.mas_bottom).offset(k_left);
        make.size.mas_equalTo(CGSizeMake(kImageH, kImageH));
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

- (UIImageView *)avatar {
    return _imageV;
}

-(void)createLayoutWith:(SCTopicReplayListDataModel *)model
{
    [_imageV scImageWithURL:model.userAvatar placeholderImage:[UIImage imageNamed:@"mine_default_avatar"]];
    _hostNameLabel.text = model.userName;
    _dateLabel.text = [NSString stringWithFormat:@"%@楼 %@", model.floorSort, model.createTime];
    _commentLabel.text = model.comment;
    
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
