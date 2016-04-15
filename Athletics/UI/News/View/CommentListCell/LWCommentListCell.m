//
//  LWCommentListCell.m
//  Athletics
//
//  Created by 李宛 on 16/4/15.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWCommentListCell.h"

@interface LWCommentListCell ()
{
    UIImageView     *_headerImageV;
    UILabel         *_nameLabel;
    UILabel         *_detailLabel;
    UILabel         *_numLabel;
    UIButton        *_praiseButton;
}
@end
static CGFloat k_left = 10.0f;
static CGFloat headerImageH = 24.0f;

@implementation LWCommentListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self p_config];
    }
    return self;
}

-(void)p_config
{
    _headerImageV = [[UIImageView alloc]init];
    _headerImageV.clipsToBounds = YES;
    _headerImageV.contentMode = UIViewContentModeScaleAspectFill;
    _headerImageV.layer.cornerRadius = headerImageH / 2.0;
    [self.contentView addSubview:_headerImageV];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = kWord_Color_High;
    _nameLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [self.contentView addSubview:_nameLabel];
    
    _detailLabel = [[UILabel alloc]init];
    _detailLabel.textColor = kWord_Color_Event;
    _detailLabel.numberOfLines = 0;
    _detailLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self.contentView addSubview:_detailLabel];
    
    _numLabel = [[UILabel alloc]init];
    _numLabel.textColor = kWord_Color_Low;
    _numLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self.contentView addSubview:_numLabel];
    
    _praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_praiseButton setImage:[UIImage imageNamed:@"live_btn_support_left_press"]forState:UIControlStateNormal];
    [_praiseButton setImage:[UIImage imageNamed:@"live_btn_support_left_sel"] forState:UIControlStateSelected];
    [self.contentView addSubview:_praiseButton];
    
    
    _WEAKSELF(ws);
    [_headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).offset(k_left);
        make.top.equalTo(ws.contentView).offset(k_left);
        make.size.mas_equalTo(CGSizeMake(headerImageH, headerImageH));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headerImageV.mas_right).offset(k_left);
        make.centerY.equalTo(_headerImageV);
    }];
    
    [_praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.centerY.equalTo(_headerImageV);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    [_numLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_praiseButton.mas_left).offset(-2);
        make.centerY.equalTo(_headerImageV);
        make.left.equalTo(_nameLabel.mas_right).offset(k_left);
    }];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerImageV.mas_bottom).offset(k_left);
        make.left.equalTo(_nameLabel);
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.bottom.equalTo(ws.contentView).offset(-k_left);
    }];
    
    
}

-(void)createLayoutWith:(id)model
{
    _headerImageV.backgroundColor = k_Base_Color;
    _nameLabel.text = @"第三方你是";
    _detailLabel.text = @"南方你vbhVBV的吗他怒吼热价女女不发达让湖人女警花你的呢是干活定不反弹后安防尽快的丧失姑奶奶";
    _numLabel.text = @"1234";
}

+ (NSString *)cellidentifier {
    return @"LWCommentListCellidentifier";
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
