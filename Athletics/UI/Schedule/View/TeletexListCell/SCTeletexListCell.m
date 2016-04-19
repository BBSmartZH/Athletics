//
//  SCTeletexListCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCTeletexListCell.h"

@interface SCTeletexListCell ()
{
    UIImageView       *_imageV;
    UIImageView       *_headerImageV;
    UILabel           *_nameLabel;
    UIImageView       *_photoImageV;
    UILabel           *_descLabel;
    UIImageView       *_circleImageV;
    UIView            *_lineView;
    UILabel           *_scoreLabel;
    UIView            *_scoreView;
}
@end
static CGFloat k_left = 10.0f;
static CGFloat kImageH = 32.0f;
@implementation SCTeletexListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self p_config];
    }
    return self;
}

-(void)p_config{
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_lineView];
    _circleImageV = [[UIImageView alloc]init];
    _circleImageV.contentMode = UIViewContentModeScaleAspectFill;
    _circleImageV.clipsToBounds = YES;
    [self.contentView addSubview:_circleImageV];
    
    _headerImageV = [[UIImageView alloc]init];
    _headerImageV.contentMode = UIViewContentModeScaleAspectFill;
    _headerImageV.clipsToBounds = YES;
    _headerImageV.layer.cornerRadius = kImageH/2.0;
    [self.contentView addSubview:_headerImageV];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = kWord_Color_Event;
    _nameLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [self.contentView addSubview:_nameLabel];
    
    _imageV = [[UIImageView alloc]init];
    _imageV.contentMode = UIViewContentModeScaleAspectFill;
    _imageV.clipsToBounds = YES;
    [self.contentView addSubview:_imageV];
    
    _descLabel = [[UILabel alloc]init];
    _descLabel.textColor = kWord_Color_Low;
    _descLabel.numberOfLines = 0;
    _descLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [_imageV addSubview:_descLabel];
    
    _photoImageV = [[UIImageView alloc]init];
    _photoImageV.contentMode = UIViewContentModeScaleAspectFill;
    _photoImageV.clipsToBounds = YES;
    _photoImageV.hidden = YES;
    [_imageV addSubview:_photoImageV];
    
    _scoreView = [[UIView alloc]init];
    _scoreView.backgroundColor = k_Base_Color;
    _scoreView.clipsToBounds = YES;
    _scoreView.hidden = YES;
    _scoreView.layer.cornerRadius = 5;
    [_imageV addSubview:_scoreView];
    
    _scoreLabel = [[UILabel alloc]init];
    _scoreLabel.textColor = kWord_Color_Low;
    _scoreLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [_scoreView addSubview:_scoreLabel];
    
    _WEAKSELF(ws);
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(ws.contentView);
        make.left.equalTo(ws.contentView).offset(k_left);
        make.width.mas_equalTo(@2);
    }];
    
    [_circleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_lineView);
        make.centerY.equalTo(_headerImageV);
        make.size.mas_equalTo(CGSizeMake(9, 9));
    }];
    
    [_headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView).offset(k_left);
        make.left.equalTo(_circleImageV.mas_right).offset(k_left);
        make.size.mas_equalTo(CGSizeMake(kImageH,kImageH));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headerImageV);
        make.left.equalTo(_headerImageV.mas_right).offset(k_left);
        make.right.equalTo(ws.contentView).offset(-k_left);
    }];
    
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerImageV.mas_bottom).offset(k_left);
        make.left.equalTo(_headerImageV);
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.bottom.equalTo(ws.contentView);
    }];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageV).offset(k_left);
        make.top.equalTo(_imageV).offset(k_left);
        make.right.equalTo(_imageV).offset(-k_left);
    }];
    
    [_photoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_descLabel.mas_bottom).offset(k_left);
        make.left.equalTo(_descLabel);
        make.size.mas_equalTo(CGSizeMake(100, 80));
        make.bottom.equalTo(_imageV).offset(-k_left);
    }];
    
    [_scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_imageV.mas_right).offset(-k_left);
        make.top.equalTo(_photoImageV);
        make.left.equalTo(_scoreLabel).offset(-k_left);
    }];
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scoreView).offset(5);
        make.right.equalTo(_scoreView).offset(-k_left);
        make.bottom.equalTo(_scoreView).offset(-5);
    }];
    
}

-(void)creatLayoutWith:(id)model
{
    _photoImageV.backgroundColor = [UIColor cyanColor];
    _headerImageV.backgroundColor = k_Base_Color;
    _circleImageV.backgroundColor = [UIColor blueColor];
    _imageV.backgroundColor = [UIColor whiteColor];
    _nameLabel.text = @"直播员：李宝宝";
    _descLabel.text = @"nfd放得开扫色妞奥阿塔就复读啊的酒瓯热啊哎额啊啊啊诶他啊饿欧体安防";
    _imageV.backgroundColor = [UIColor whiteColor];
    _scoreLabel.text = @"人头：0:1";
    _photoImageV.hidden = NO;
    _scoreView.hidden = NO;
    
}
+(NSString *)cellIdentifier
{
    return @"SCTeletextListCellIdentifier";
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
