//
//  SCNewsDetailImageCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/16.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNewsDetailImageCell.h"
#import "SCContentListModel.h"

@interface SCNewsDetailImageCell ()
{
    UIImageView *_imageView;
    SCContentListModel *_model;
}

@end

static CGFloat k_top = 10.0f;
static CGFloat k_left = 10.0f;

@implementation SCNewsDetailImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self uiConfig];
    }
    return self;
}

- (void)uiConfig {
    
    _imageView = [[UIImageView alloc] init];
    _imageView.clipsToBounds = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_imageView];
    
    _WEAKSELF(ws);
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView).offset(k_top);
        make.left.equalTo(ws.contentView).offset(k_left);
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.bottom.equalTo(ws.contentView).offset(-k_top);
    }];
    
}

- (void)createLayoutWith:(SCContentListModel *)model {
    _model = model;
    [_imageView scImageWithURL:_model.image.url placeholderImage:nil];
}

+ (CGFloat)cellHeightWith:(SCContentListModel *)model {
    CGFloat height = 0.0;
    height += k_top;

    CGSize imageSize = CGSizeMake([SCGlobaUtil getFloat:model.image.width], [SCGlobaUtil getFloat:model.image.height]);
    
    height = ([UIScreen mainScreen].bounds.size.width - 2 * k_left) * (imageSize.height / imageSize.width);
    height += k_top;
    
    return height;
}

+ (NSString *)cellIdentifier {
    return @"SCNewsDetailImageCellIdentifier";
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
