//
//  SCNewsPhotosPackVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/18.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNewsPhotosPackVC.h"

#import "SCCommentInputView.h"
#import "SCNewsImageVC.h"
#import "SCCommentListVC.h"
#import "SCLoginVC.h"

@interface SCNewsPhotosPackVC ()<SCCommentInputViewDelegate, UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIView *_touchView;
}
@property (nonatomic, strong) SCCommentInputView *inputView;

@property (nonatomic, strong) SCNewsImageVC *photosVC;
@property (nonatomic, strong) SCCommentListVC *commentVC;

@end

@implementation SCNewsPhotosPackVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboareWillShowNotif:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboareWillHiddenNotif:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[[IQKeyboardManager sharedManager] disabledDistanceHandlingClasses] addObject:[self class]];
    [[[IQKeyboardManager sharedManager] disabledToolbarClasses] addObject:[self class]];

    self.title = @"资讯";
    
    self.m_navBar.current_color = [UIColor colorWithWhite:0.0 alpha:0.6];
    self.m_navBar.hiddenLine = YES;
    
    self.inputView = [[SCCommentInputView alloc] initWithFrame:CGRectMake(0, self.view.fHeight - 44, self.view.fWidth, 44)];
    _inputView.backgroundColor = k_Bg_Color;
    _inputView.delegate = self;
    _inputView.layer.borderWidth = .5f;
    _inputView.layer.borderColor = k_Border_Color.CGColor;
    _inputView.isComment = YES;
    _inputView.inputTextView.placeHolder = @"我来说两句..";
    [self.view addSubview:_inputView];
    
    NSString *norStr = [NSString stringWithFormat:@"%@评", _commentNum];
    NSMutableAttributedString *norAttStr = [[NSMutableAttributedString alloc] initWithString:norStr];
    [norAttStr addAttribute:NSForegroundColorAttributeName value:k_Base_Color range:NSMakeRange(0, norAttStr.length - 1)];
    [norAttStr addAttribute:NSForegroundColorAttributeName value:kWord_Color_Event range:NSMakeRange(norAttStr.length - 1, 1)];
    [_inputView.commentButton setAttributedTitle:norAttStr forState:UIControlStateNormal];
    
    NSAttributedString *disAttStr = [[NSAttributedString alloc] initWithString:norStr attributes:@{NSForegroundColorAttributeName : kWord_Color_Low}];
    [_inputView.commentButton setAttributedTitle:disAttStr forState:UIControlStateDisabled];
    
    NSAttributedString *selAttStr = [[NSAttributedString alloc] initWithString:@"原文" attributes:@{NSForegroundColorAttributeName : k_Base_Color, NSFontAttributeName : [UIFont systemFontOfSize:kWord_Font_28px]}];
    [_inputView.commentButton setAttributedTitle:selAttStr forState:UIControlStateSelected];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.fWidth, self.view.fHeight)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;
    
    _scrollView.contentSize = CGSizeMake(_scrollView.fWidth * 2, _scrollView.fHeight);
    [self.view addSubview:_scrollView];
    
    [self.view bringSubviewToFront:self.m_navBar];

    _touchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.fWidth, self.view.fHeight)];
    _touchView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    _touchView.alpha = 0.0;
    UITapGestureRecognizer *touchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchTap:)];
    [_touchView addGestureRecognizer:touchTap];
    [self.view addSubview:_touchView];
    
    [self.view bringSubviewToFront:_inputView];
    
    self.photosVC = [[SCNewsImageVC alloc] init];
    self.photosVC.newsId = _newsId;
    self.photosVC.parentVC = self;
    __weak typeof(self) weakSelf = self;

    self.photosVC.tapBlock = ^(BOOL isHidden) {
        if (isHidden) {
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.m_navBar.alpha = 0.0f;
                weakSelf.inputView.alpha = 0.0f;
            }];
        }else {
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.m_navBar.alpha = 1.0f;
                weakSelf.inputView.alpha = 1.0f;
            }];
        }
    };
    self.photosVC.view.frame = CGRectMake(0, 0, _scrollView.fWidth, _scrollView.fHeight);
    [_scrollView addSubview:self.photosVC.view];
    
    self.commentVC = [[SCCommentListVC alloc] init];
    self.commentVC.newsId = _newsId;
    self.commentVC.view.frame = CGRectMake(_scrollView.fWidth, self.m_navBar.bottom, _scrollView.fWidth, _scrollView.fHeight - self.m_navBar.fHeight);
    [_scrollView addSubview:self.commentVC.view];
    
}

- (void)touchTap:(UITapGestureRecognizer *)sender {
    [_inputView.inputTextView resignFirstResponder];
}

#pragma mark - SCCommentInputViewDelegate

- (void)commentButtonClicked:(UIButton *)sender {
    if (!sender.isSelected) {
        
        [UIView animateWithDuration:0.25 animations:^{
            //滚动到评论列表
            [_scrollView setContentOffset:CGPointMake(_scrollView.fWidth, 0) animated:YES];
        } completion:^(BOOL finished) {
            sender.selected = YES;
            self.title = @"评论";
            if (!self.commentVC.isUpdated) {
                [self.commentVC updateData];
            }
        }];
    }else {
        [UIView animateWithDuration:0.25 animations:^{
            //滚动到详情
            [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        } completion:^(BOOL finished) {
            sender.selected = NO;
            self.title = @"资讯";
        }];
    }
}

- (void)inputViewDidChangedFrame:(CGRect)frame {
    _inputView.frame = frame;
}

- (void)inputTextViewWillBeginEditing:(SCMessageTextView *)inputTextView {
    if (![SCUserInfoManager isLogin]) {
        [self.view endEditing:YES];
        SCLoginVC *loginVC = [[SCLoginVC alloc] init];
        [loginVC loginWithPresentController:self successCompletion:^(BOOL result) {
            if (result) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [_inputView.inputTextView becomeFirstResponder];
                });
            }
        }];
    }
}

- (void)inputTextViewDidSendMessage:(SCMessageTextView *)inputTextView {
    
    MBProgressHUD *HUD = [SCProgressHUD MBHudWithText:@"评价中" showAddTo:self.view delay:NO];
    
    [SCNetwork newsCommentAddWithNewsId:_newsId comment:inputTextView.text success:^(SCResponseModel *model) {
        [HUD hideAnimated:YES];
        _inputView.inputTextView.text = nil;
        [self postMessage:@"发表成功"];
        [self.commentVC updateData];
    } message:^(NSString *resultMsg) {
        [HUD hideAnimated:YES];
        [self postMessage:resultMsg];
    }];
}

#pragma mark - keyboard
- (void)keyboareWillShowNotif:(NSNotification *)notification {
    // 键盘信息字典
    NSDictionary* info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardHeight = CGRectGetHeight([aValue CGRectValue]);
    
    [UIView animateWithDuration:duration animations:^{
        _inputView.frame = CGRectMake(0, self.view.fHeight - keyboardHeight - _inputView.fHeight, _inputView.fWidth, _inputView.fHeight);
        _touchView.alpha = 1.0;
    }];
}

- (void)keyboareWillHiddenNotif:(NSNotification *)notification {
    // 键盘信息字典
    NSDictionary* info = [notification userInfo];
    
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        _inputView.frame = CGRectMake(0, self.view.fHeight - _inputView.fHeight, _inputView.fWidth, _inputView.fHeight);
        _touchView.alpha = 0.0;
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _scrollView) {
        NSInteger pag = scrollView.contentOffset.x / scrollView.bounds.size.width;
        if (pag == 0) {
            _inputView.commentButton.selected = YES;
            [self commentButtonClicked:_inputView.commentButton];
        }else {
            _inputView.commentButton.selected = NO;
            [self commentButtonClicked:_inputView.commentButton];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
