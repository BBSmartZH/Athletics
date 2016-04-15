//
//  SCPostedChooseView.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCPostedChooseView.h"

@interface SCPostedChooseView ()
{
    UIButton *_deleteButton;
    UIImageView *_imageView;
}

@end

@implementation SCPostedChooseView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, frame.size.width - 8, frame.size.height - 8)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.layer.borderWidth = .5f;
        _imageView.layer.borderColor = k_Border_Color.CGColor;
        [self addSubview:_imageView];
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.frame = CGRectMake(0, frame.size.width - 12, 20, 20);
        _deleteButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        [self addSubview:_deleteButton];
    }
    return self;
}

- (void)deleteButtonClicked:(UIButton *)sender {
    
}

@end
