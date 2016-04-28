//
//  SCPostsTopView.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/15.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCPostsTopView.h"


@interface SCPostsTopView ()
{
    UIImageView *_avatar;
    UILabel *_nameLabel;
    UILabel *_statusLabel;//身份
    UILabel *_descLabel;//描述
    UILabel *_timeLabel;//时间
    
    UILabel *_titleLabel;
    UIFont  *_titleFont;
    NSMutableParagraphStyle *_titleStyle;
    CGFloat _titleHeight;
    UILabel *_contentLabel;
    UIFont  *_contentFont;
    NSMutableParagraphStyle *_contentStyle;
    CGFloat _contentHeight;
    CGFloat _contentTempHeight;
    
    UIView *_showMoreView;
    UIButton *_showMoreButton;
    
    //test
    NSString *_title;
    NSString *_content;
}

@end

static CGFloat avatarH = 44.0f;
static CGFloat k_left = 10.0f;
static CGFloat k_top = 15.0f;
static CGFloat titleLineSpace = 4.0f;
static CGFloat contentLineSpace = 6.0f;
static CGFloat showButtonH = 22.0f;

@implementation SCPostsTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        [self uiConfig];
    }
    return self;
}

- (void)uiConfig {
    
    _titleFont = [UIFont fontWithName:@"Helvetica-Bold" size:kWord_Font_32px];
    _contentFont = [UIFont systemFontOfSize:kWord_Font_28px];
    
    _titleStyle = [[NSMutableParagraphStyle alloc] init];
    [_titleStyle setLineSpacing:titleLineSpace];
    
    _contentStyle = [[NSMutableParagraphStyle alloc] init];
    [_contentStyle setLineSpacing:contentLineSpace];
    
    _avatar = [[UIImageView alloc] init];
    _avatar.layer.cornerRadius = avatarH / 2.0f;
    _avatar.contentMode = UIViewContentModeScaleAspectFill;
    _avatar.clipsToBounds = YES;
    [self addSubview:_avatar];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = kWord_Color_Event;
    _nameLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [self addSubview:_nameLabel];
    
    _descLabel = [[UILabel alloc] init];
    _descLabel.textColor = kWord_Color_Event;
    _descLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    [self addSubview:_descLabel];
    
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.textColor = [UIColor whiteColor];
    _statusLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    _statusLabel.backgroundColor = [UIColor cyanColor];
    _statusLabel.layer.cornerRadius = 2.0f;
    _statusLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_statusLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textColor = kWord_Color_Event;
    _timeLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_timeLabel];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = kWord_Color_High;
    _titleLabel.font = _titleFont;
    _titleLabel.numberOfLines = 0;
    [self addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.textColor = kWord_Color_High;
    _contentLabel.font = _contentFont;
    _contentLabel.numberOfLines = 0;
    [self addSubview:_contentLabel];
    
    _showMoreView = [[UIView alloc] init];
    _showMoreView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_showMoreView];
    
    _showMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_showMoreButton setTitle:@"查看全文" forState:UIControlStateNormal];
    [_showMoreButton setTitle:@"收起" forState:UIControlStateSelected];
    [_showMoreButton addTarget:self action:@selector(showMoreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_showMoreButton setTitleColor:k_Base_Color forState:UIControlStateNormal];
    _showMoreButton.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [_showMoreView addSubview:_showMoreButton];
    
    _WEAKSELF(ws);
    
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).offset(k_left);
        make.top.equalTo(ws).offset(k_top);
        make.size.mas_equalTo(CGSizeMake(avatarH, avatarH));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_avatar).offset(5);
        make.left.equalTo(_avatar.mas_right).offset(5);
        make.right.equalTo(_statusLabel.mas_left).offset(-k_left);
    }];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_avatar).offset(-5);
        make.left.equalTo(_nameLabel);
        make.right.equalTo(_timeLabel.mas_left).offset(-k_left);
    }];
    
    [_statusLabel setContentCompressionResistancePriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_timeLabel setContentCompressionResistancePriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_statusLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_timeLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel);
        make.right.equalTo(ws).offset(-k_left);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_descLabel);
        make.right.equalTo(_statusLabel);
    }];
    
    _titleLabel.frame = CGRectMake(k_left, 2 * k_top + avatarH, self.fWidth - 2 * k_left, 0);
    _contentLabel.frame = CGRectMake(_titleLabel.left, _titleLabel.bottom + k_top, _titleLabel.fWidth, 0);
    
    [_showMoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws);
        make.bottom.equalTo(ws);
    }];
    
    [_showMoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_showMoreView).offset(5);
        make.size.mas_equalTo(CGSizeMake(60, showButtonH));
        make.centerX.equalTo(_showMoreView);
        make.bottom.equalTo(_showMoreView).offset(-k_top);
    }];
}


- (void)showMoreButtonClicked:(UIButton *)sender {
    if (!sender.isSelected) {
        sender.selected = YES;
    }else {
        sender.selected = NO;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(postsTopViewHeightChanged)]) {
        [self.delegate postsTopViewHeightChanged];
    }
}

- (void)setModel:(id)model {
    if (_model != model) {
        [_avatar scImageWithURL:@"http://img.78dian.com/user/m_avatar/201604/1461657916_756423.png" placeholderImage:nil];
        _nameLabel.text = @"背单词的gxc";
        _descLabel.text = @"Dota2";
        _statusLabel.text = @"楼主";
        _timeLabel.text = @"2016-04-26 10:00";
        
        _title = @"求问 这香蕉到底什么梗";
        
        NSMutableAttributedString *titleAttStr = [[NSMutableAttributedString alloc] initWithString:_title];
        
        
        [titleAttStr addAttribute:NSParagraphStyleAttributeName value:_titleStyle range:NSMakeRange(0, titleAttStr.length)];
        [titleAttStr addAttribute:NSFontAttributeName value:_titleFont range:NSMakeRange(0, titleAttStr.length)];
        _titleLabel.attributedText = titleAttStr;
        
        _content = @"看到个图，有人说吃了永久加智力，那么问题来了，匹配也有这个吗";
        
//        _content = @"内容这是内容这是内容是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这内,,,,,,,,,,,,,,,容这是内容";
        NSMutableAttributedString *contentAttStr = [[NSMutableAttributedString alloc] initWithString:_content];
        
        [contentAttStr addAttribute:NSParagraphStyleAttributeName value:_contentStyle range:NSMakeRange(0, contentAttStr.length)];
        [contentAttStr addAttribute:NSFontAttributeName value:_contentFont range:NSMakeRange(0, contentAttStr.length)];

        _contentLabel.attributedText = contentAttStr;
        

        _titleHeight = [self sizeOfLabelWith:_title width:self.fWidth - 2 * k_left attributes:@{NSFontAttributeName : _titleFont, NSParagraphStyleAttributeName : _titleStyle}].height;
        
        NSString *testStr = @"测试CeShi9999！!@~——#";
        CGFloat contentOneLineHeight = [self sizeOfLabelWith:testStr width:MAXFLOAT attributes:@{NSFontAttributeName : _contentFont, NSParagraphStyleAttributeName : _contentStyle}].height;
        _contentTempHeight = 6 * contentOneLineHeight;
        
        _contentHeight = [self sizeOfLabelWith:_content width:self.fWidth - 2 * k_left attributes:@{NSFontAttributeName : _contentFont, NSParagraphStyleAttributeName : _contentStyle}].height;
        
        _titleLabel.frame = CGRectMake(_titleLabel.left, _titleLabel.top, _titleLabel.fWidth, _titleHeight);
        _contentLabel.frame = CGRectMake(_contentLabel.left, _titleLabel.bottom + k_top, _contentLabel.fWidth, _contentHeight);

        if (_contentHeight > _contentTempHeight) {
            //显示展开全部
            _showMoreView.hidden = NO;
        }else {
            _showMoreView.hidden = YES;
        }
    }
}


- (CGFloat)topViewHeight {
    CGFloat height = 0.0f;
    
    height += k_top;
    height += avatarH;
    height += k_top;
    
    height += _titleHeight;
    height += k_top;
    
    if (_contentHeight > _contentTempHeight) {
        if (_showMoreButton.isSelected) {
            height += _contentHeight;
        }else {
            height += _contentTempHeight;
        }
        height += 5;
        height += showButtonH;
    }else {
        height += _contentHeight;
    }
    
    height += k_top;
    
    return height;
}

- (CGSize)sizeOfLabelWith:(NSString *)text width:(CGFloat)width attributes:(NSDictionary *)attributes {
    CGSize size = CGSizeZero;
    if (kIsIOS7OrLater) {
        // 计算文本的大小  ios7.0
        size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                               attributes:attributes        // 文字的属性
                                  context:nil].size;
    }
    
    return size;
    
}

- (void)layoutSubviews {
    
}



@end
