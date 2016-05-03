//
//  LWCommentsCell.m
//  Athletics
//
//  Created by 李宛 on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWCommentsCell.h"

#import "SCTopicReplayListModel.h"

@interface LWCommentsCell ()
{
    UILabel     *_label;
}
@end
static CGFloat k_left = 10.0f;
@implementation LWCommentsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self config];
    }
    return self;
}

-(void)config{
    
    _label = [[UILabel alloc]init];
    _label.textColor = kWord_Color_Event;
    _label.numberOfLines = 0;
    _label.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self.contentView addSubview:_label];
    _WEAKSELF(ws);
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView);
        make.left.equalTo(ws.contentView).offset(52);
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.bottom.equalTo(ws.contentView).offset(-k_left);
    }];
    
}

-(void)createLayoutWith:(SCTopicReplayListDataModel *)model
{
    NSString * userName = @"";
    if (model.userName) {
        userName = model.userName;
    }
    NSString * provName = @"";
    if (model.provName) {
        provName = model.provName;
    }
    NSString * comment = @"";
    if (model.comment) {
        comment = model.comment;
    }
    NSString *title = [NSString stringWithFormat:@"%@ 回复 %@：", userName, provName];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@", title, comment]];
    [string addAttribute:NSForegroundColorAttributeName value:kWord_Color_Low range:NSMakeRange(0, title.length)];
    _label.attributedText = string;
}

+(NSString *)cellIdentifier
{
    return @"LWCommentsCellIdentifier";
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
