//
//  SCPostsInputView.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCPostsInputView.h"

@interface SCPostsInputView ()
{
    
}

@property (nonatomic, strong, readwrite) UIButton *choosePicButton;

@end

@implementation SCPostsInputView

- (void)dealloc {
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    // 当别的地方需要add的时候，就会调用这里
    if (newSuperview) {
        [self setupMessageInputView];
    }
}

- (void)setup {
    //配置自适应
    self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin);
    self.opaque = YES;
    self.userInteractionEnabled = YES;
    
}

#pragma mark - 添加控件
- (void)setupMessageInputView {
    UIButton *choosePicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [choosePicButton setImage:nil forState:UIControlStateNormal];
    [choosePicButton setImage:nil forState:UIControlStateSelected];
    [choosePicButton addTarget:self action:@selector(messageStyleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    choosePicButton.frame = CGRectMake(20, (self.bounds.size.height - 36.0) / 2.0, 36.0, 36.0);
    
    self.choosePicButton = choosePicButton;
};

#pragma mark - Button Action
- (void)messageStyleButtonClicked:(UIButton *)sender {
    
}













@end
