//
//  SCScheduleCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCScheduleCell.h"
#import "SCMatchLiveListModel.h"

@interface SCScheduleCell ()
{
    UIImageView *_leftImageV;
    UIImageView *_markImageV;
    UILabel *_titleLabel;
    UILabel *_timeLabel;
    UIImageView *_topImageV;
    CGFloat _topImageH;
    SCMatchLiveListDataModel *_model;
}

@end

static CGFloat k_left = 10.0f;

static CGFloat imageW = 90.0f;
static CGFloat markImageW = 44;
static float scale = 0.75;

@implementation SCScheduleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_uiConfig];
    }
    return self;
}

- (void)p_uiConfig {
    
    self.backgroundColor = [UIColor clearColor];
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 5.0f;
    backView.clipsToBounds = YES;
    backView.layer.borderColor = k_Border_Color.CGColor;
    backView.layer.borderWidth = .5f;
    [self.contentView addSubview:backView];
    
    _WEAKSELF(ws);

    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(ws.contentView);
        make.left.equalTo(ws.contentView).offset(k_left);
        make.right.equalTo(ws.contentView).offset(-k_left);
    }];
    
    _topImageH = kImageWithName(@"icon_sawtooth_enabled").size.height;
    _topImageV = [[UIImageView alloc] init];
    [backView addSubview:_topImageV];
    
    _leftImageV = [[UIImageView alloc]init];
    _leftImageV.contentMode = UIViewContentModeScaleAspectFill;
    _leftImageV.clipsToBounds = YES;
    _leftImageV.backgroundColor = [UIColor redColor];
    [backView addSubview:_leftImageV];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = kWord_Color_High;
    _titleLabel.font = [UIFont systemFontOfSize:kWord_Font_30px];
    [backView  addSubview:_titleLabel];
    
    UIView *centerView = [[UIView alloc] init];
    centerView.backgroundColor = [UIColor clearColor];
    [backView addSubview:centerView];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.textColor = kWord_Color_Low;
    _timeLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    [backView addSubview:_timeLabel];
    
    _markImageV = [[UIImageView alloc]init];
    _markImageV.layer.cornerRadius = markImageW / 2.0;
    _markImageV.clipsToBounds = YES;
    _markImageV.contentMode = UIViewContentModeScaleAspectFill;
    _markImageV.backgroundColor = [UIColor cyanColor];
    _markImageV.hidden = YES;
    [backView addSubview:_markImageV];
    
    CGFloat imageWidth = imageW * ([UIScreen mainScreen].bounds.size.width / 320.0);
    [_leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(k_left);
        make.top.equalTo(backView).offset(15 + _topImageH);
        make.bottom.equalTo(backView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(imageWidth, floorf(imageWidth * scale)));
    }];
    
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageV.mas_right).offset(k_left);
        make.centerY.equalTo(_leftImageV);
        make.right.equalTo(backView).offset(-k_left);
        make.height.mas_equalTo(@.01f);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(centerView);
        make.bottom.equalTo(centerView.mas_top).offset(-5);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_titleLabel);
        make.top.equalTo(centerView.mas_bottom).offset(5);
    }];
    
    [_markImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView);
        make.right.equalTo(backView).offset(-k_left);
        make.size.mas_equalTo(CGSizeMake(markImageW, markImageW));
    }];
    
};

- (void)createLayoutWith:(SCMatchLiveListDataModel *)model {
    _model = model;
    _titleLabel.text = model.title;
    _timeLabel.text = [NSString stringWithFormat:@"%@ 到 %@", model.startTime, model.endTime];
    _markImageV.hidden = YES;
    [_leftImageV scImageWithURL:model.image.url placeholderImage:nil];
    [self setState:[SCGlobaUtil getInt:model.status]];
}

- (void)setState:(NSInteger)state {
    switch (state) {
        case 0: {
            _topImageV.image = [kImageWithName(@"icon_sawtooth_enabled") resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeTile];
        }
            break;
        case 1: {
            _topImageV.image = [kImageWithName(@"icon_sawtooth_unenabled") resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
        }
            break;
        case 2: {
            _topImageV.image = [kImageWithName(@"icon_sawtooth_unenabled") resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
        }
            break;
        default:
            break;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _topImageV.frame = CGRectMake(0, 0, self.fWidth - 2 * k_left, _topImageH);
}

+ (NSString *)cellIdentifier {
    return @"SCScheduleCellIdentifier";
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
