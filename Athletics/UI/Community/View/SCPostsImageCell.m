//
//  SCPostsImageCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCPostsImageCell.h"

@interface SCPostsImageCell ()
{
    UIImageView   *_headImageV;
    UILabel       *_nameLabel;
    UILabel       *_tilteLable;
    UILabel       *_summaryLabel;
    UIImageView   *_leftImageV;
    UIImageView   *_middleImageV;
    UIImageView   *_rightImageV;
    UILabel       *_dateLabel;
    UIImageView   *_thumbImagev;
    UILabel       *_thumbNumLabel;
    UIImageView   *_messageImageV;
    UILabel       *_messageNumLabel;
    
    int           _imageCounts;
}

@end

static CGFloat k_left = 10.0;
static CGFloat k_small = 2.0;
static CGFloat k_WHratio = 0.8;

@implementation SCPostsImageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_config];
    }
    return self;
}
-(void)p_config{
    
    _headImageV = [[UIImageView alloc]init];
    _headImageV.contentMode = UIViewContentModeScaleAspectFill;
    _headImageV.layer.cornerRadius = 12;
    _headImageV.clipsToBounds = YES;
    [self.contentView addSubview:_headImageV];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = kWord_Color_High;
    _nameLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [self.contentView addSubview:_nameLabel];
    
    _thumbImagev = [[UIImageView alloc]init];
    _thumbImagev.contentMode = UIViewContentModeScaleAspectFill;
    _thumbImagev.clipsToBounds = YES;
    [self.contentView addSubview:_thumbImagev];
    
    _thumbNumLabel = [[UILabel alloc]init];
    _thumbNumLabel.textColor = kWord_Color_Low;
    _thumbNumLabel.textAlignment = NSTextAlignmentRight;
    _thumbNumLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    [self.contentView addSubview:_thumbNumLabel];
    
    _messageImageV = [[UIImageView alloc]init];
    _messageImageV.contentMode = UIViewContentModeScaleAspectFill;
    _messageImageV.clipsToBounds = YES;
    [self.contentView addSubview:_messageImageV];
    
    _messageNumLabel = [[UILabel alloc]init];
    _messageNumLabel.textColor = kWord_Color_Low;
    _messageNumLabel.textAlignment = NSTextAlignmentRight;
    _messageNumLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    [self.contentView addSubview:_messageNumLabel];
    
    _tilteLable = [[UILabel alloc]init];
    _tilteLable.textColor = kWord_Color_High;
    _tilteLable.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [self.contentView addSubview:_tilteLable];
    
    _summaryLabel = [[UILabel alloc]init];
    _summaryLabel.textColor = kWord_Color_Low;
    _summaryLabel.numberOfLines = 2;
    _summaryLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self.contentView addSubview:_summaryLabel];
    
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
    
    
    _dateLabel = [[UILabel alloc]init];
    _dateLabel.textColor = kWord_Color_Low;
    _dateLabel.textAlignment = NSTextAlignmentRight;
    _dateLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    [self.contentView addSubview:_dateLabel];
    
    [_thumbNumLabel setContentCompressionResistancePriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_messageNumLabel setContentCompressionResistancePriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    
    [_thumbNumLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_messageNumLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    
    
    _WEAKSELF(ws);
    
    [_headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).offset(k_left);
        make.top.equalTo(ws.contentView).offset(k_left);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageV.mas_right).offset(k_small);
        make.centerY.equalTo(_headImageV);
        make.right.equalTo(_thumbImagev.mas_left).offset(-k_left);
    }];
    
    [_messageNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.centerY.equalTo(_nameLabel);
    }];
    
    [_messageImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_messageNumLabel.mas_left).offset(-k_small);
        make.centerY.equalTo(_messageNumLabel);
        make.size.mas_equalTo(CGSizeMake(9, 9));
    }];
    
    [_thumbNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_messageImageV.mas_left).offset(-k_left);
        make.centerY.equalTo(_messageImageV);
    }];
    
    [_thumbImagev mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_thumbNumLabel.mas_left).offset(-k_small);
        make.centerY.equalTo(_thumbNumLabel);
        make.size.mas_equalTo(CGSizeMake(9, 9));
    }];
    
    [_tilteLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImageV.mas_bottom).offset(k_left);
        make.left.equalTo(_headImageV);
        make.right.equalTo(ws.contentView).offset(-k_left);
    }];
    
    [_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_tilteLable);
        make.top.equalTo(_tilteLable.mas_bottom).offset(k_left);
        make.bottom.lessThanOrEqualTo(ws.contentView).offset(-k_left);
    }];
    
    CGFloat imageWidth = floorf(([UIScreen mainScreen].bounds.size.width - 4 * k_left) / 3.0f);
    
    [_leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_summaryLabel.mas_bottom).offset(k_left);
        make.left.equalTo(_headImageV);
        make.size.mas_equalTo(CGSizeMake(imageWidth,imageWidth * k_WHratio));
    }];
    
    [_middleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageV.mas_right).offset(k_left);
        make.top.equalTo(_leftImageV);
        make.size.equalTo(_leftImageV);
    }];
    
    [_rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_middleImageV.mas_right).offset(k_left);
        make.top.equalTo(_middleImageV);
        make.size.equalTo(_middleImageV);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftImageV.mas_bottom).offset(k_left);
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.bottom.equalTo(ws.contentView).offset(-k_left);
    }];
    
}

+ (NSString *)cellIdentifier {
    return @"SCPostsImageCellIdentifier";
}

- (void)createLayoutWith:(id)model {
    
    _imageCounts = ((NSNumber *)model).intValue;
    //    _imageCounts = 0;
    
    
    CGFloat imageWidth = floorf(([UIScreen mainScreen].bounds.size.width - 4 * k_left) / 3.0f);

    
    if (_imageCounts == 0) {
        
    }else if (_imageCounts == 1) {
        imageWidth = floorf(([UIScreen mainScreen].bounds.size.width - 3 * k_left) / 2.0f);

        _leftImageV.hidden = NO;
        _rightImageV.hidden = YES;
        _middleImageV.hidden = YES;
        
    }else if (_imageCounts >= 2){
        imageWidth = floorf(([UIScreen mainScreen].bounds.size.width - 4 * k_left) / 3.0f);
        _leftImageV.hidden = NO;
        _middleImageV.hidden = NO;
        if (_imageCounts == 2) {
            _rightImageV.hidden = YES;
        }else {
            _rightImageV.hidden = NO;
        }
    }
    
    [_leftImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_summaryLabel.mas_bottom).offset(k_left);
        make.left.equalTo(_headImageV);
        make.size.mas_equalTo(CGSizeMake(imageWidth,imageWidth * k_WHratio));
    }];
    [_middleImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageV.mas_right).offset(k_left);
        make.top.equalTo(_leftImageV);
        make.size.equalTo(_leftImageV);
    }];
    
    [_rightImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_middleImageV.mas_right).offset(k_left);
        make.top.equalTo(_middleImageV);
        make.size.equalTo(_middleImageV);
    }];
    
    _headImageV.backgroundColor = k_Base_Color;
    _nameLabel.text = @"小怪咖UI";
    _thumbImagev.backgroundColor = k_Base_Color;
    _thumbNumLabel.text = @"123";
    _messageImageV.backgroundColor = k_Base_Color;
    _messageNumLabel.text = @"3546";
    _tilteLable.text = @"你的级沙发上浪费那你干嘛";
    _summaryLabel.text = @"你但买房快疯了改变真服你了接口没那么那加大非标准接口没那么那加大非标准接口没那么那加大非标准版速度快放假光和热";
    _leftImageV.backgroundColor = [UIColor cyanColor];
    _middleImageV.backgroundColor = [UIColor cyanColor];
    _rightImageV.backgroundColor = [UIColor cyanColor];
    _dateLabel.text = @"2016-04-12 16:15";
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
