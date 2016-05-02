//
//  SCTeletexListCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCTeletexListCell.h"
#import "SCTeletextListModel.h"

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
    _circleImageV.layer.cornerRadius = 5;
    _circleImageV.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_circleImageV];
    
    _headerImageV = [[UIImageView alloc] init];
    _headerImageV.contentMode = UIViewContentModeScaleAspectFill;
    _headerImageV.clipsToBounds = YES;
    _headerImageV.layer.cornerRadius = kImageH/2.0;
    [self.contentView addSubview:_headerImageV];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = kWord_Color_Event;
    _nameLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [self.contentView addSubview:_nameLabel];
    
    _imageV = [[UIImageView alloc] init];
    _imageV.contentMode = UIViewContentModeScaleAspectFill;
    _imageV.clipsToBounds = YES;
    _imageV.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_imageV];
    
    _descLabel = [[UILabel alloc] init];
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
    _scoreLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    _scoreLabel.textColor = [UIColor whiteColor];
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
        make.size.mas_equalTo(CGSizeMake(10, 10));
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
        make.bottom.lessThanOrEqualTo(_imageV);
    }];
    
    [_photoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_descLabel.mas_bottom).offset(k_left);
        make.left.equalTo(_descLabel);
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];
    
    [_scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_imageV.mas_right).offset(-k_left);
        make.centerY.equalTo(_imageV);
        make.left.equalTo(_scoreLabel).offset(-k_left);
    }];
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scoreView).offset(5);
        make.right.equalTo(_scoreView).offset(-k_left);
        make.bottom.equalTo(_scoreView).offset(-5);
    }];
    
}

-(void)creatLayoutWith:(SCTeletextListDataModel *)model
{
    [_headerImageV scImageWithURL:model.liverAvatar placeholderImage:[UIImage imageNamed:@"mine_default_avatar"]];
    _nameLabel.text = [NSString stringWithFormat:@"直播员：%@", model.liverName];
    _descLabel.text = model.content;
    _scoreLabel.text = model.goalStr;
    _scoreView.hidden = NO;
    
    if ([SCGlobaUtil isEmpty:model.image.url]) {
        _photoImageV.hidden = NO;
        [_photoImageV scImageWithURL:model.image.url placeholderImage:[UIImage imageNamed:@"default_image"]];
        
        CGFloat imageW = 0.0f;
        CGFloat imageH = 0.0f;
        
        
        if ([SCGlobaUtil getFloat:model.image.width] == 0 || [SCGlobaUtil getFloat:model.image.height] == 0) {
            imageW = self.fWidth / 3.0;
            imageH = self.fWidth / 3.0;
        }else {
            float scal = [SCGlobaUtil getFloat:model.image.height] / [SCGlobaUtil getFloat:model.image.width];
            
            if ([SCGlobaUtil getFloat:model.image.width] > self.fWidth / 3.0) {
                imageW = self.fWidth / 3.0;
                imageH = imageW * scal;
            }else {
                imageW = [SCGlobaUtil getFloat:model.image.width];
                imageH = [SCGlobaUtil getFloat:model.image.height];
            }
        }
        
        [_photoImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_descLabel.mas_bottom).offset(k_left);
            make.left.equalTo(_descLabel);
            make.size.mas_equalTo(CGSizeMake(imageW, imageH));
            make.bottom.equalTo(_imageV).offset(-k_left);
        }];
    }else {
        _photoImageV.hidden = YES;
        [_photoImageV mas_remakeConstraints:^(MASConstraintMaker *make) {}];
    }
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
