//
//  SCNewsDetailTextCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/16.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNewsDetailTextCell.h"
#import "SCContentListModel.h"

@interface SCNewsDetailTextCell ()
{
    UILabel *_textLabel;
    NSString *_text;
    UIFont  *_textFont;
    NSMutableParagraphStyle *_textStyle;
    SCContentListModel *_model;
}

@end

static CGFloat trxtLineSpace = 8.0f;
static CGFloat k_top = 10.0f;
static CGFloat k_left = 10.0f;

@implementation SCNewsDetailTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self uiConfig];
    }
    return self;
}

- (void)uiConfig {
    
    _textFont = [UIFont systemFontOfSize:kWord_Font_28px];
    
    _textStyle = [[NSMutableParagraphStyle alloc] init];
    [_textStyle setLineSpacing:trxtLineSpace];
    
    _textLabel = [[UILabel alloc] init];
    _textLabel.textColor = kWord_Color_High;
    _textLabel.font = _textFont;
    _textLabel.numberOfLines = 0;
    [self.contentView addSubview:_textLabel];
    
    _WEAKSELF(ws);
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).offset(k_left);
        make.top.equalTo(ws.contentView).offset(k_top);
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.bottom.equalTo(ws.contentView).offset(-k_top);
    }];
    
}

- (void)createLayoutWith:(SCContentListModel *)model {
    _model = model;
    _text = _model.content ? _model.content : @"";
    
    NSMutableAttributedString *textAttStr = [[NSMutableAttributedString alloc] initWithString:_text];
    
    [textAttStr addAttribute:NSParagraphStyleAttributeName value:_textStyle range:NSMakeRange(0, textAttStr.length)];
    [textAttStr addAttribute:NSFontAttributeName value:_textFont range:NSMakeRange(0, textAttStr.length)];
    
    _textLabel.attributedText = textAttStr;
}

+ (NSString *)cellIdentifier {
    return @"SCNewsDetailTextCellIdentifier";
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
