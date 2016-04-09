//
//  LWNavigationBar.m
//  Link
//
//  Created by 李宛 on 16/3/10.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWNavigationBar.h"
#import "LWBaseVC_iPhone.h"
@interface LWNavigationBar ()
{
    UIView *_bottomLine;
}


@property (nonatomic, strong) UIButton          *m_leftButton;
@property (nonatomic, strong) UIButton          *m_rightButton;
@property (nonatomic, strong) UILabel           *m_titleLabel;
@property (nonatomic, strong) UIImageView       *m_bgImageV;


@end

#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)
#define Size(w, h)                          CGSizeMake(w, h)
#define Point(x, y)                         CGPointMake(x, y)

static CGFloat kEndPoint = 1.5;
static NSString *backImageName = @"icon_back_normal";


@implementation LWNavigationBar
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //TODO
        [self p_uiConfig];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self p_uiConfig];
}

- (void)p_uiConfig {
    
    _m_leftButton = [[self class] createNavButtonByImageNormal:backImageName imageSelected:backImageName target:self action:@selector(p_backButtonClicked:)];
    
    _m_titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _m_titleLabel.textColor = kWord_Color_High;
    _m_titleLabel.backgroundColor = [UIColor clearColor];
    _m_titleLabel.font = [UIFont systemFontOfSize:20];
    _m_titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _m_bgImageV = [[UIImageView alloc] init];
    UIImage *bgImage = [self imageWithColor:[UIColor whiteColor]];
    _m_bgImageV.image = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    _m_bgImageV.alpha = 0.95;
    _m_bgImageV.frame = self.bounds;
    [self addSubview:_m_bgImageV];
    
    _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _m_bgImageV.bounds.size.height - 0.5f, [[self class] barSize].width, 0.5f)];
    _bottomLine.backgroundColor = [UIColor lightGrayColor];
    _bottomLine.alpha = 0.6f;
    [_m_bgImageV addSubview:_bottomLine];
    
    _m_titleLabel.frame = [[self class] titleViewFrame];
    [self addSubview:_m_titleLabel];
    
    [self setLeftBarButton:_m_leftButton];
    
}

- (void)setLeftBarButton:(UIButton *)sender {
    if (_m_leftButton) {
        [_m_leftButton removeFromSuperview];
        _m_leftButton = nil;
    }
    _m_leftButton = sender;
    if (_m_leftButton) {
        _m_leftButton.frame = [[self class] leftButtonFrame];
        [self addSubview:_m_leftButton];
    }
}

- (void)setLeftButtonImage:(UIImage *)image {
    if (image) {
        [_m_leftButton setImage:image forState:UIControlStateNormal];
        [_m_leftButton setImage:image forState:UIControlStateSelected];
        
        //        CGFloat leftInset = ([[self class] barButtonSize].width - image.size.width) / 2.0f;
        //        CGFloat topInset = ([[self class] barButtonSize].height - image.size.height) / 2.0f;
        //        leftInset = (leftInset >= 2.0f) ? leftInset / 2.0f : 0.0f;
        //        topInset = (topInset >= 2.0f) ? topInset / 2.0f : 0.0f;
        //        [_m_leftButton setImageEdgeInsets:UIEdgeInsetsMake(topInset, leftInset, topInset, leftInset)];
        //        [_m_leftButton setTitleEdgeInsets:UIEdgeInsetsMake(topInset, -image.size.width, topInset, leftInset)];
    }
}

- (void)setRightBarButton:(UIButton *)sender {
    if (_m_rightButton) {
        [_m_rightButton removeFromSuperview];
        _m_rightButton = nil;
    }
    _m_rightButton = sender;
    if (_m_rightButton) {
        _m_rightButton.frame = [[self class] rightButtonFrame];
        [self addSubview:_m_rightButton];
    }else {};
}

- (void)setRightBarButtonImage:(UIImage *)image {
    if (image) {
        [_m_rightButton setImage:image forState:UIControlStateNormal];
        [_m_rightButton setImage:image forState:UIControlStateSelected];
    }
}

- (void)setNavTitle:(NSString *)title {
    [_m_titleLabel setText:title];
}

- (void)setCurrent_color:(UIColor *)current_color {
    if (current_color) {
        UIImage *image = [self imageWithColor:current_color];
        _m_bgImageV.image = image;
    }
}

- (void)setBg_alpha:(CGFloat)bg_alpha {
    _m_bgImageV.alpha = bg_alpha;
}

- (void)setHiddenLine:(BOOL)hiddenLine {
    _bottomLine.hidden = hiddenLine;
}

- (UIButton *)backButton {
    return _m_leftButton;
}

- (UIButton *)rightButton {
    return _m_rightButton;
}

+ (CGSize)screenSize {
    return [UIScreen mainScreen].bounds.size;
}

+ (CGSize)barSize {
    if (kIsIOS7OrLater) {
        return Size([self screenSize].width, 64.0f);
    }
    return Size([self screenSize].width, 44.0f);
}

+ (CGSize)barButtonSize {
    return Size(40, 40);
}

+ (CGRect)titleViewFrame {
    CGFloat top = 0.0f;
    if (kIsIOS7OrLater) {
        top = 20.0f;
    }
    return Rect([self barButtonSize].width + 25, top + 2.0f, [self barSize].width - 2 * [self barButtonSize].width - 50, 40);
}

+ (CGRect)leftButtonFrame {
    CGFloat top = 0.0f;
    if (kIsIOS7OrLater) {
        top = 20.0f;
    }
    return Rect(0.0f, top + 2.0f, [self barButtonSize].width, [self barButtonSize].height);
}

+ (CGRect)rightButtonFrame {
    CGFloat top = 0.0f;
    if (kIsIOS7OrLater) {
        top = 20.0f;
    }
    return Rect([self barSize].width - [self barButtonSize].width, top + 2.0f, [self barButtonSize].width, [self barButtonSize].height);
}

- (void)p_backButtonClicked:(UIButton *)sender {
    if (self.m_vc) {
        if (self.m_vc.isPresented) {
            [self.m_vc dismissViewControllerAnimated:YES completion:nil];
        }else if (self.m_vc.navigationController) {
            [self.m_vc.navigationController popViewControllerAnimated:YES];
        }
    }else {
        //TODO
    }
}


/**
 *在导航条上覆盖一层自定义视图。ps：搜索框..
 */
- (void)showCoverView:(UIView *)view {
    [self showCoverView:view animation:NO];
}
- (void)showCoverView:(UIView *)view animation:(BOOL)isAnimation {
    if (view) {
        [self p_hideOriginalBarItem:YES];
        [view removeFromSuperview];
        
        view.alpha = 0.4f;
        [self addSubview:view];
        if (isAnimation) {
            [UIView animateWithDuration:0.2f animations:^{
                view.alpha = 1.0f;
            } completion:^(BOOL finished) {}];
        }else {
            view.alpha = 1.0f;
        }
    }else {
        //TODO
    }
}
- (void)showCoverViewOnTitleView:(UIView *)view {
    if (view) {
        if (_m_titleLabel) {
            _m_titleLabel.hidden = YES;
        }else {}
        [view removeFromSuperview];
        view.frame = _m_titleLabel.frame;
        [self addSubview:view];
    }else {
        //TODO
    }
}
- (void)hideCoverView:(UIView *)view {
    [self p_hideOriginalBarItem:NO];
    if (view && (view.superview == self)) {
        [view removeFromSuperview];
    }else {}
}

#pragma mark -
- (void)p_hideOriginalBarItem:(BOOL)isHide
{
    if (_m_leftButton)
    {
        _m_leftButton.hidden = isHide;
    }else{}
    if (_m_rightButton)
    {
        _m_rightButton.hidden = isHide;
    }else{}
    if (_m_titleLabel)
    {
        _m_titleLabel.hidden = isHide;
    }
}

/**
 *使用title创建一个导航条按钮
 */
+ (UIButton *)createNavButttonByTitle:(NSString *)strTitle target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:strTitle forState:UIControlStateNormal];
    [button setTintColor:[UIColor blackColor]];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    return button;
}

/**
 *使用自定义图片创建一个导航条按钮
 */
+ (UIButton *)createNavButtonByImageNormal:(NSString *)strNormal imageSelected:(NSString *)strSelected target:(id)target action:(SEL)action {
    UIImage *imageNormal = [UIImage imageNamed:strNormal];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:imageNormal forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:(strSelected ? strSelected : strNormal)] forState:UIControlStateSelected];
    
    //    CGFloat leftInset = ([[self class] barButtonSize].width - imageNormal.size.width) / 2.0f;
    //    CGFloat topInset = ([[self class] barButtonSize].height - imageNormal.size.height) / 2.0f;
    //    leftInset = (leftInset >= 2.0f) ? leftInset / 2.0f : 0.0f;
    //    topInset = (topInset >= 2.0f) ? topInset / 2.0f : 0.0f;
    //    [button setImageEdgeInsets:UIEdgeInsetsMake(topInset, leftInset, topInset, leftInset)];
    //    [button setTitleEdgeInsets:UIEdgeInsetsMake(topInset, -imageNormal.size.width, topInset, leftInset)];
    return button;
}



void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor) {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGPoint startPoint = CGPointMake(rect.size.width/2, 0);
    CGPoint endPoint = CGPointMake(rect.size.width/2, rect.size.height/kEndPoint);
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextSetStrokeColorWithColor(context, [[UIColor clearColor] CGColor]);
}

/**
 *  用颜色来生成一张image
 *
 *  @param color 色值
 *
 *  @return 图片
 */
- (UIImage *)imageWithColor:(UIColor *)color {
    if (!color) {
        color = [UIColor clearColor];
    }
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  用两种颜色生成渐变的图片（从上到下）
 *
 *  @param colours 两个色值
 *
 *  @return 渐变色图片
 */
- (UIImage *)imageWithGradients:(NSArray *)colours {
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor * beginColor = [UIColor clearColor];
    UIColor * endColor = [UIColor clearColor];
    if (colours.count > 0) {
        beginColor = [colours objectAtIndex:0];
    }
    if (colours.count > 1) {
        endColor = [colours objectAtIndex:1];
    }
    drawLinearGradient(context, rect, beginColor.CGColor, endColor.CGColor);
    CGContextRestoreGState(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
