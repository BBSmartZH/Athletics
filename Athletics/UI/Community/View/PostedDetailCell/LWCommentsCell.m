//
//  LWCommentsCell.m
//  Athletics
//
//  Created by 李宛 on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWCommentsCell.h"

@interface LWCommentsCell ()
{
    UILabel     *_label;
}
@end

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
    _label.textColor = kWord_Color_High;
    _label.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self.contentView addSubview:_label];
    _WEAKSELF(ws);
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView);
        make.left.equalTo(ws.contentView).offset(52);
        make.right.equalTo(ws.contentView).offset(-10);
        make.bottom.equalTo(ws.contentView).offset(10);
    }];
    
}

-(void)createLayoutWith:(id)model
{
    NSString *title = @"李SUV价三块 回复 历史课登记费：";
    NSString *commments = @"今天说的上飞你妹你发尅哦的那份单和";
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@,%@",title,commments]];
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
