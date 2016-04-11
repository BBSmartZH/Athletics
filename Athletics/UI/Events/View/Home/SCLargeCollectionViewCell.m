//
//  SCLargeCollectionViewCell.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/11.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCLargeCollectionViewCell.h"

@interface SCLargeCollectionViewCell ()


@end

@implementation SCLargeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.hidden = YES;
    }
    return self;
}


- (void)setShowView:(UIView *)showView {
    if (showView != _showView) {
        [_showView removeFromSuperview];
        _showView = showView;
        _showView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        [self addSubview:_showView];
    }
}

@end
