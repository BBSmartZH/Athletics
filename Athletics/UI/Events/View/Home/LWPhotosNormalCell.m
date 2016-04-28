//
//  LWPhotosNormalCell.m
//  Athletics
//
//  Created by 李宛 on 16/4/11.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWPhotosNormalCell.h"
static CGFloat k_left = 10.0;
static CGFloat k_small = 5.0;
static CGFloat k_WHratio = 0.7;

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
    int               _imageCounts;

}
@end

@implementation LWPhotosNormalCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_config];
    }
    return self;
}

-(void)p_config{
    _imageCounts = 3;
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = kWord_Color_High;
    _titleLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    _titleLabel.numberOfLines = 1;
    [self.contentView addSubview:_titleLabel];
    
    _leftImageV = [[UIImageView alloc]init];
    _leftImageV.contentMode = UIViewContentModeScaleAspectFill;
    _leftImageV.clipsToBounds = YES;
    _leftImageV.hidden = YES;
    [self.contentView addSubview:_leftImageV];
    
    _middleImageV = [[UIImageView alloc]init];
    _middleImageV.contentMode = UIViewContentModeScaleAspectFill;
    _middleImageV.clipsToBounds = YES;
    _middleImageV.hidden = YES;
    [self.contentView addSubview:_middleImageV];
    _rightImageV = [[UIImageView alloc]init];
    _rightImageV.contentMode = UIViewContentModeScaleAspectFill;
    _rightImageV.clipsToBounds = YES;
    _rightImageV.hidden = YES;
    [self.contentView addSubview:_rightImageV];
    
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
        make.top.equalTo(_titleLabel.mas_bottom).offset(k_left);
        make.size.mas_equalTo(CGSizeMake((kScreenWidth-k_left*2-k_left*2)/3.0, (kScreenWidth-k_left*2-k_left*2)/3.0*k_WHratio));
    }];
    
    [_middleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageV.mas_right).offset(k_left);
        make.top.bottom.equalTo(_leftImageV);
        make.size.equalTo(_leftImageV);
    }];
    
    [_rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_middleImageV.mas_right).offset(k_left);
        make.top.bottom.equalTo(_middleImageV);
        make.size.equalTo(_middleImageV);
    }];

    [_commentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftImageV.mas_bottom).offset(k_left);
        make.right.equalTo(ws.contentView).offset(-k_left);
    }];
    [_commentsImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_commentsLabel.mas_left).offset(-k_small);
        make.size.mas_equalTo(CGSizeMake(9, 9));
        make.centerY.equalTo(_commentsLabel);
    }];
    [_scanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commentsLabel);
        make.right.equalTo(_commentsImageV.mas_left).offset(-k_left);
    }];
    [_scanImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_scanLabel.mas_left).offset(-k_small);
        make.centerY.equalTo(_scanLabel);
        make.size.mas_equalTo(CGSizeMake(9, 9));
    }];
    
}
-(void)createLayoutWith:(id)model
{
    _titleLabel.text = @"DOTA2特级锦标赛之马尼拉站即将上演";
    [_leftImageV scImageWithURL:@"http://img.dota2.com.cn/dota2/31/8b/318b43ff95c38c7e54b4d1ad476a88a51458026307.jpg" placeholderImage:nil];
    [_middleImageV scImageWithURL:@"http://img.dota2.com.cn/dota2/af/e7/afe7b0fc2bc4d083a2bac20c3b1c79b11461668008.jpg" placeholderImage:nil];
    [_rightImageV scImageWithURL:@"http://img.dota2.com.cn/dota2/14/b7/14b7fe520b4062b64dfd797eed3df4291461667855.jpg" placeholderImage:nil];
    _commentsLabel.text = @"12334";
    _commentsImageV.backgroundColor = k_Bg_Color;
    _scanImageV.backgroundColor = k_Bg_Color;
    _scanLabel.text = @"114";
    
    _imageCounts = 3;
    
    if (_imageCounts == 1) {
        _leftImageV.hidden = NO;
        _middleImageV.hidden = YES;
        _rightImageV.hidden = YES;
    }else if(_imageCounts == 2){
        _leftImageV.hidden = NO;
        _middleImageV.hidden = NO;
        _rightImageV.hidden = YES;
    }else if (_imageCounts >2){
        _leftImageV.hidden = NO;
        _middleImageV.hidden = NO;
        _rightImageV.hidden = NO;
    }

}
+(CGFloat)heightForRowWithPhotosWithCounts:(int)counts{
    
    CGFloat height = 0.0f;
    
    height += k_left;
    height += [SCGlobaUtil heightOfLineWithFont:kWord_Font_28px];
    height += k_left;

    height += (kScreenWidth - k_left * 2 - k_left * 2) / 3.0 * k_WHratio;
    
    height += k_left;
    height += [SCGlobaUtil heightOfLineWithFont:kWord_Font_20px];
    height += k_left;

    return height;
}

+ (NSString *)cellIdentifier {
    return @"LWPhotosNormalCellIdentifier";
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
