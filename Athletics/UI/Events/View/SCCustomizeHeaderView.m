//
//  SCCustomizeHeaderView.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/16.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCCustomizeHeaderView.h"

@interface SCCustomizeHeaderView ()
{
    UILabel *_leftLabel;
    UILabel *_rightLabel;
}

@end

@implementation SCCustomizeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self uiConfig];
    }
    return self;
}

- (void)uiConfig {
    _leftLabel = [[UILabel alloc] init];
    _leftLabel.textColor = kWord_Color_Event;
    _leftLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self addSubview:_leftLabel];
    
    _rightLabel = [[UILabel alloc] init];
    _rightLabel.textColor = kWord_Color_Event;
    _rightLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    _rightLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_rightLabel];
    
    _WEAKSELF(ws);
    
    [_leftLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_rightLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws).offset(-10);
        make.left.equalTo(ws).offset(10);
    }];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_leftLabel);
        make.right.equalTo(ws).offset(-10);
    }];
    
}


- (void)setLeftTitle:(NSString *)leftTitle {
    _leftTitle = leftTitle;
    _leftLabel.text = _leftTitle;
}

- (void)setRightTitle:(NSString *)rightTitle {
    _rightTitle = rightTitle;
    _rightLabel.text = _rightTitle;
}


+ (NSString *)headerIdentifier {
    return @"SCCustomizeHeaderViewHeaderIdentifier";
}





@end
