//
//  SCNewsDetailTextCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/16.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNewsDetailTextCell.h"

@interface SCNewsDetailTextCell ()
{
    UILabel *_textLabel;
    NSString *_text;
    UIFont  *_textFont;
    NSMutableParagraphStyle *_textStyle;
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

- (void)createLayoutWith:(id)model {
    _text = @"经过了大赛不断的精彩冬季后，DOTA2即将随着本周6.87游戏性更新的发布迎来万象更新的春季。天梯全英雄选择模式的改动，小地图扫描技能的加入，全新物品的推出和大量平衡性调整，6.87更新日志中有诸多内容亟待您的探索。";
    
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
