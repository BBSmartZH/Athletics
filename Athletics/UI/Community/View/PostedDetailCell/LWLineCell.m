//
//  LWLineCell.m
//  Athletics
//
//  Created by 李宛 on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWLineCell.h"

@interface LWLineCell ()
{
    UILabel     *_label;
}
@end
static CGFloat k_left = 10.0f;
@implementation LWLineCell

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
    _label.backgroundColor = k_Bg_Color;
    [self.contentView addSubview:_label];
    _WEAKSELF(ws);
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView);
        make.left.equalTo(ws.contentView).offset(k_left);
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.height.mas_equalTo(@0.5f);
        make.bottom.equalTo(ws.contentView);
    }];
    
}

+(NSString *)cellIdentifier
{
    return @"LWLineCellIdentifier";
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
