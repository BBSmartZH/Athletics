//
//  SCPostsTextImageCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/15.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCPostsTextImageCell.h"


@interface SCPostsTextImageCell ()
{
    UIImageView *_imageView;
    id _model;
}

@end

static CGFloat k_left = 10.0f;
static CGFloat k_top = 15.0f;

@implementation SCPostsTextImageCell

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
    [self.contentView addSubview:_imageView];
    
    _WEAKSELF(ws);
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView);
        make.left.equalTo(ws.contentView).offset(k_left);
        make.right.equalTo(ws.contentView).offset(-k_left);
        make.bottom.equalTo(ws.contentView).offset(-k_top);
    }];
}

- (void)createLayoutWith:(id)model {
    _model = model;

    CGSize imageSize = CGSizeZero;
    
    NSInteger number = ((NSNumber *)model).integerValue;
    if (number == 1) {
        imageSize = CGSizeMake(348, 257);
    }else {
        imageSize = CGSizeMake(620, 747);
    }
    
    [_imageView scImageWithURL:@"http://img.78dian.com/user/topic/201604/1461658526_637289.png0" placeholderImage:nil];
}

+ (CGFloat)cellHeightWith:(id)model {
    CGFloat height = 0.0;
    
    CGSize imageSize = CGSizeZero;
    
    NSInteger number = ((NSNumber *)model).integerValue;
    if (number == 1) {
        imageSize = CGSizeMake(348, 257);
    }else {
        imageSize = CGSizeMake(620, 1024);
    }
    
    height = ([UIScreen mainScreen].bounds.size.width - 2 * k_left) * (imageSize.height / imageSize.width);
    height += k_top;
    
    return height;
}

+ (NSString *)cellIdentifier {
    return @"SCPostsImageCellIdentifier";
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
