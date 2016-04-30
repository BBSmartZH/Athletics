//
//  SCScheduleDetailVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCScheduleDetailVC.h"

#import "SCGuessListVC.h"
#import "SCTeletextListVC.h"
#import "SCScheduleVideoListVC.h"
#import "SCMatchCommentListVC.h"
#import "SCCommentInputView.h"
#import "SCMatchDetailModel.h"
#import "SCLoginVC.h"

@interface SCScheduleDetailVC ()<SCCommentInputViewDelegate, UIScrollViewDelegate>
{
    UIImageView *_topBgImageView;

    UIView *_selectedView;
    UIButton *_guessButton;//竞猜
    UIButton *_scheduleButton;//赛况
    UIButton *_videoButton;//视频
    UIButton *_currentButton;
    UIView   *_slideLine;
    UIScrollView *_scrollView;
    BOOL       _falg1;
    BOOL       _falg2;
    BOOL       _falg3;
    NSArray *_buttonArray;
    
//    UIScrollView *_scrollView;
    UIImageView *_leftImageV;
    UILabel     *_leftLabel;
    UIImageView *_rightImageV;
    UILabel     *_rightLabel;
    UILabel     *_stateLabel;
    UILabel     *_scoreLine;
    UILabel     *_leftScoreLabel;
    UILabel     *_rightScoreLabel;
    UILabel     *_markLabel;
    UIImageView *_markImageV;
    UITableView *_tableView;
    
    SCMatchDetailDataModel *_model;
}

@property (nonatomic, strong) SCCommentInputView *inputView;
@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) SCGuessListVC *guessListVC;
@property (nonatomic, strong) SCTeletextListVC *teletextListVC;
@property (nonatomic, strong) SCScheduleVideoListVC *videoListVC;
@property (nonatomic, strong) SCMatchCommentListVC *commentListVC;


@end
static CGFloat imageW = 64.0f;
static CGFloat k_left = 10.0f;
@implementation SCScheduleDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboareWillShowNotif:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboareWillHiddenNotif:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (SCCommentInputView *)inputView {
    if (!_inputView) {
        _inputView = [[SCCommentInputView alloc] initWithFrame:CGRectMake(0, self.view.fHeight - 44, self.view.fWidth, 44)];
        _inputView.backgroundColor = k_Bg_Color;
        _inputView.delegate = self;
        _inputView.layer.borderWidth = .5f;
        _inputView.layer.borderColor = k_Border_Color.CGColor;
        _inputView.isComment = NO;
        _inputView.inputTextView.placeHolder = @"别憋着，来两句..";
    }
    return _inputView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.fWidth, 160)];
        
        _topBgImageView = [[UIImageView alloc] init];
        _topBgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _topBgImageView.clipsToBounds = YES;
        _topBgImageView.backgroundColor = [UIColor cyanColor];
        [_topView addSubview:_topBgImageView];
        
        [_topBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(_topView);
        }];
        
        _leftImageV = [[UIImageView alloc] init];
        _leftImageV.contentMode = UIViewContentModeScaleAspectFill;
        _leftImageV.clipsToBounds = YES;
        [_topView addSubview:_leftImageV];
        
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.font = [UIFont boldSystemFontOfSize:kWord_Font_30px];
        _leftLabel.textColor = [UIColor whiteColor];
        [_topView addSubview:_leftLabel];
        
        _rightImageV = [[UIImageView alloc] init];
        _rightImageV.contentMode = UIViewContentModeScaleAspectFill;
        _rightImageV.clipsToBounds = YES;
        [_topView addSubview:_rightImageV];
        
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.font = [UIFont boldSystemFontOfSize:kWord_Font_30px];
        _rightLabel.textColor = [UIColor whiteColor];
        [_topView addSubview:_rightLabel];
        
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
        _stateLabel.textColor = [UIColor whiteColor];
        [_topView addSubview:_stateLabel];
        
        _leftScoreLabel = [[UILabel alloc]init];
        _leftScoreLabel.textColor = kWord_Color_High;
        _leftScoreLabel.font = [UIFont boldSystemFontOfSize:kWord_Font_28px];
        _leftScoreLabel.textColor = [UIColor whiteColor];
        [_topView addSubview:_leftScoreLabel];
        
        
        _rightScoreLabel = [[UILabel alloc]init];
        _rightScoreLabel.textColor = kWord_Color_High;
        _rightScoreLabel.font = [UIFont boldSystemFontOfSize:kWord_Font_28px];
        _rightScoreLabel.textColor = [UIColor whiteColor];
        [_topView addSubview:_rightScoreLabel];
        
        _scoreLine = [[UILabel alloc]init];
        _scoreLine.backgroundColor = [UIColor whiteColor];
        [_topView addSubview:_scoreLine];
        
        [_leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_topView).offset(5);
            make.left.equalTo(_topView).offset(40);
            make.size.mas_equalTo(CGSizeMake(imageW, imageW));
        }];
        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_leftImageV.mas_bottom).offset(k_left);
            make.left.equalTo(_topView).offset(20);
            make.centerX.equalTo(_leftImageV);
        }];
        [_leftScoreLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
        [_leftScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_leftImageV);
            make.left.equalTo(_leftImageV.mas_right).offset(15);
        }];
        [_rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_leftImageV);
            make.right.equalTo(_topView).offset(-40);
            make.size.mas_equalTo(CGSizeMake(imageW, imageW));
        }];
        [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_rightImageV.mas_bottom).offset(k_left);
            make.right.equalTo(_topView).offset(-20);
            make.centerX.equalTo(_rightImageV);
        }];
        [_rightScoreLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
        [_rightScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_rightImageV);
            make.right.equalTo(_rightImageV.mas_left).offset(-15);
        }];
        [_scoreLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_leftImageV);
            make.left.equalTo(_leftScoreLabel.mas_right).offset(15);
            make.right.equalTo(_rightScoreLabel.mas_left).offset(-15);
            make.height.mas_equalTo(@.5f);
        }];
        [_stateLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
        [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_topView);
            make.centerY.equalTo(_leftLabel).offset(-10);
        }];
        
        _markImageV = [[UIImageView alloc] init];
        _markImageV.contentMode = UIViewContentModeScaleAspectFill;
        _markImageV.layer.cornerRadius = 4.0f;
        _markImageV.clipsToBounds = YES;
        [_topView addSubview:_markImageV];
        
        _markLabel = [[UILabel alloc]init];
        _markLabel.textColor = [UIColor whiteColor];
        _markLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
        _markLabel.textColor = [UIColor whiteColor];
        [_markImageV addSubview:_markLabel];
        [_markImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_topView);
            make.centerY.equalTo(_scoreLine);
        }];
        [_markLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
        [_markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_markImageV);
            make.centerX.equalTo(_markImageV);
            make.height.equalTo(_markImageV).offset(-4);
            make.width.equalTo(_markImageV).offset(-8);
        }];
    }
    return _topView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[[IQKeyboardManager sharedManager] disabledDistanceHandlingClasses] addObject:[self class]];
    [[[IQKeyboardManager sharedManager] disabledToolbarClasses] addObject:[self class]];
    
    self.m_navBar.bg_alpha = 0.0f;
    self.m_navBar.hiddenLine = YES;
    self.m_navBar.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_30px];
    
    [self p_preparData];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchTap:)];
//    [self.view addGestureRecognizer:tap];
    
    
}

//- (void)touchTap:(UITapGestureRecognizer *)tap {
//    [self.view endEditing:YES];
//}

- (void)configTopView {
    
    [self.view addSubview:self.topView];
    
    [self.view bringSubviewToFront:self.m_navBar];
    
    _selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, _topView.bottom, self.view.fWidth, 44)];
    _selectedView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_selectedView];
    
    _guessButton = [self topicTypeButtonWithTitle:@"评论"];
    _guessButton.frame = CGRectMake(0, 0, _selectedView.fWidth / 3.0, _selectedView.fHeight);
    [_selectedView addSubview:_guessButton];
    
    _scheduleButton = [self topicTypeButtonWithTitle:@"赛况"];
    _scheduleButton.frame = CGRectMake(_guessButton.right, 0, _guessButton.fWidth, _guessButton.fHeight);
    [_selectedView addSubview:_scheduleButton];
    
    _videoButton = [self topicTypeButtonWithTitle:@"视频"];
    _videoButton.frame = CGRectMake(_scheduleButton.right, 0, _scheduleButton.fWidth, _scheduleButton.fHeight);
    [_selectedView addSubview:_videoButton];
    
    _buttonArray = @[_guessButton, _scheduleButton, _videoButton];
    
    
    UIView *selectedLine = [[UIView alloc] initWithFrame:CGRectMake(0, _selectedView.fHeight - 0.5, _selectedView.fWidth, 0.5)];
    selectedLine.backgroundColor = k_Border_Color;
    [_selectedView addSubview:selectedLine];
    
    _slideLine = [[UIView alloc] init];
    _slideLine.backgroundColor = k_Base_Color;
    [_selectedView addSubview:_slideLine];
    _slideLine.frame = CGRectMake(10,  _selectedView.fHeight - 2, _guessButton.fWidth - 20, 2);
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _selectedView.bottom, self.view.fWidth, self.view.fHeight - _topView.fHeight - _selectedView.fHeight - _inputView.fHeight)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(_scrollView.fWidth * 3, _scrollView.fHeight);
    [self.view addSubview:_scrollView];
    
    
    self.commentListVC = [[SCMatchCommentListVC alloc] init];
    self.commentListVC.parentVC = self;
    self.commentListVC.matchUnitId = _matchUnitId;
    self.commentListVC.topHeight = _selectedView.bottom + _inputView.fHeight;
    self.commentListVC.view.frame = CGRectMake(0, 0, _scrollView.fWidth, _scrollView.fHeight);
    [_scrollView addSubview:self.commentListVC.view];
    
    self.teletextListVC = [[SCTeletextListVC alloc] init];
    self.teletextListVC.parentVC = self;
    self.teletextListVC.matchUnitId = _matchUnitId;
    self.teletextListVC.topHeight = _selectedView.bottom + _inputView.fHeight;
    self.teletextListVC.view.frame = CGRectMake(_scrollView.fWidth, 0, _scrollView.fWidth, _scrollView.fHeight);
    [_scrollView addSubview:self.teletextListVC.view];
    
    self.videoListVC = [[SCScheduleVideoListVC alloc] init];
    self.videoListVC.parentVC = self;
    self.videoListVC.matchUnitId = _matchUnitId;
    self.videoListVC.topHeight = _selectedView.bottom + _inputView.fHeight;
    self.videoListVC.view.frame = CGRectMake(_scrollView.fWidth * 2, 0, _scrollView.fWidth, _scrollView.fHeight);
    [_scrollView addSubview:self.videoListVC.view];
    
    [self.view bringSubviewToFront:self.inputView];
    
    [self selectedButtonClicked:_scheduleButton];
}

- (UIButton *)topicTypeButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kWord_Color_High forState:UIControlStateNormal];
    [button setTitleColor:k_Base_Color forState:UIControlStateSelected];
    [button addTarget:self action:@selector(selectedButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_32px];
    
    return button;
}

- (void)selectedButtonClicked:(UIButton *)sender {
    if (sender.isSelected) {
        return;
    }
    
    _currentButton.selected = NO;
    _currentButton = sender;
    _currentButton.selected = YES;
    if (sender == _guessButton) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        if (![_commentListVC isUpdated]) {
            [_commentListVC upDateData];
        }
    }else if (sender == _scheduleButton) {
        [_scrollView setContentOffset:CGPointMake(self.view.fWidth, 0) animated:YES];
        if (!_falg2) {
            [_teletextListVC upDateData];
            _falg2 = YES;
        }
        
    }else if (sender == _videoButton) {
        [_scrollView setContentOffset:CGPointMake(self.view.fWidth * 2, 0) animated:YES];
        if (!_falg3) {
            [_videoListVC upDateData];
            _falg3 = YES;
        }
        
    }
}



-(void)p_preparData{
    
    [self startActivityAnimation];
    self.sessionTask = [SCNetwork matchUnitQuaryWithMatchUnitId:_matchUnitId success:^(SCMatchDetailModel *model) {
        [self stopActivityAnimation];
        _model = model.data;
        
        [self.view addSubview:self.inputView];
        [self configTopView];
        [self updateData];
        
    } message:^(NSString *resultMsg) {
        [self stopActivityAnimation];
        [self postMessage:resultMsg];
    }];
}

- (void)updateData {
    self.title = _model.name;
    [_leftImageV scImageWithURL:_model.leftTeamBadge placeholderImage:nil];
    [_rightImageV scImageWithURL:_model.rightTeamBadge placeholderImage:nil];
    
    _leftLabel.text = _model.leftTeamName;
    _rightLabel.text = _model.rightTeamName;
    _stateLabel.text = [self stringForStatus:_model.status];
    _leftScoreLabel.text = _model.leftTeamGoal;
    _rightScoreLabel.text = _model.rightTeamGoal;
    _markImageV.backgroundColor = [UIColor redColor];
    _markLabel.text = @"BO3";
}

- (NSString *)stringForStatus:(NSString *)status {
    NSInteger state = [SCGlobaUtil getInt:status];
    switch (state) {
        case 1:
            return @"未开始";
            break;
        case 2:
            return @"已结束";
            break;
        case 3:
            return @"正在进行";
            break;
        case 4:
            return @"已取消";
            break;
        default:
            return @"";
            break;
    }
}

- (void)inputViewDidChangedFrame:(CGRect)frame {
    _inputView.frame = frame;
}

- (void)inputTextViewDidSendMessage:(SCMessageTextView *)inputTextView {
    
    MBProgressHUD *HUD = [SCProgressHUD MBHudWithText:@"评价中" showAddTo:self.view delay:NO];
    
    [SCNetwork matchCommentAddWithMatchUnitId:_matchUnitId comment:inputTextView.text success:^(SCResponseModel *model) {
        [HUD hideAnimated:YES];
        [self postMessage:@"发表成功"];
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
    }];
}

- (void)keyboareWillHiddenNotif:(NSNotification *)notification {
    // 键盘信息字典
    NSDictionary* info = [notification userInfo];
    
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        _inputView.frame = CGRectMake(0, self.view.fHeight - _inputView.fHeight, _inputView.fWidth, _inputView.fHeight);
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _scrollView) {
        NSInteger pag = scrollView.contentOffset.x / scrollView.fWidth;
        UIButton *button = [_buttonArray objectAtIndex:pag];
        [self selectedButtonClicked:button];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        if (_scrollView.contentOffset.x >=0 && _scrollView.contentOffset.x <= _scrollView.fWidth * 2) {
            int contentX = _scrollView.contentOffset.x;
            CGFloat buttonWidth = (self.view.fWidth - (_buttonArray.count - 1) * 1) / _buttonArray.count;
            _slideLine.frame = CGRectMake(contentX / _scrollView.fWidth * (buttonWidth + 1) + 10, _slideLine.top, _slideLine.fWidth, _slideLine.fHeight);
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
