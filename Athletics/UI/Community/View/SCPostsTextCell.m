//
//  SCPostsTextCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCPostsTextCell.h"
#import "SCCommunityListModel.h"
@interface SCPostsTextCell ()
{
    UIImageView   *_headImageV;
    UILabel       *_nameLabel;
    UILabel       *_tilteLable;
    UILabel       *_summaryLabel;
    UILabel       *_dateLabel;
    UIImageView   *_thumbImagev;
    UILabel       *_thumbNumLabel;
    UIImageView   *_messageImageV;
    UILabel       *_messageNumLabel;
}

@end

static CGFloat k_left = 10.0;
static CGFloat k_small = 2.0;

@implementation SCPostsTextCell

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
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_summaryLabel.mas_bottom).offset(k_left);
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.bottom.equalTo(ws.contentView).offset(-k_left);
    }];
    
}

+ (NSString *)cellIdentifier {
    return @"SCPostsTextCellIdentifier";
}

- (void)createLayoutWith:(SCCommunityListDataModel*)model {
    
    [_headImageV scImageWithURL:model.userAvatar placeholderImage:nil];
    _nameLabel.text = model.userName;
    _thumbImagev.backgroundColor = k_Base_Color;
    _thumbNumLabel.text = model.supportNum;
    _messageImageV.backgroundColor = k_Base_Color;
    _messageNumLabel.text = model.replyNum;
    _tilteLable.text = model.title;
    _summaryLabel.text = model.summary;
    _dateLabel.text = model.createTime;
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
