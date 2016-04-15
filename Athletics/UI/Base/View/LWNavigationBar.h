//
//  LWNavigationBar.h
//  Link
//
//  Created by 李宛 on 16/3/10.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWBaseVC_iPhone;


@interface LWNavigationBar : UIView
@property (nonatomic, weak) LWBaseVC_iPhone   *m_vc;
@property (nonatomic, strong) UIColor         *current_color;
@property (nonatomic, assign) CGFloat         bg_alpha;
@property (nonatomic, assign) BOOL            hiddenLine;

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UIButton *backButton;
@property (nonatomic, strong, readonly) UIButton *rightButton;


- (void)setLeftBarButton:(UIButton *)sender;
- (void)setLeftButtonImage:(UIImage *)image;
- (void)setRightBarButton:(UIButton *)sender;
- (void)setRightBarButtonImage:(UIImage *)image;
- (void)setNavTitle:(NSString *)title;

+ (CGSize)barSize;
+ (CGSize)barButtonSize;
+ (CGRect)titleViewFrame;
+ (CGRect)leftButtonFrame;
+ (CGRect)rightButtonFrame;

/**
 *在导航条上覆盖一层自定义视图。ps：搜索框..
 */
- (void)showCoverView:(UIView *)view;
- (void)showCoverView:(UIView *)view animation:(BOOL)isAnimation;
- (void)showCoverViewOnTitleView:(UIView *)view;
- (void)hideCoverView:(UIView *)view;


@end
