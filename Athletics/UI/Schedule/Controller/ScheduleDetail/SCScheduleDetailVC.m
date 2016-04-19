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

@interface SCScheduleDetailVC ()<UIScrollViewDelegate>
{
    UIView *_topView;
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
    UILabel     *_titleLabel;
    UIImageView *_leftImageV;
    UILabel     *_leftLabel;
    UIImageView *_rightImageV;
    UILabel     *_rightLabel;
    UILabel     *_scoreLabel;
    UILabel     *_stateLabel;
    UIButton    *_leftButton;
    UIButton    *_rightButton;
    UILabel     *_leftScoreLineLabel;
    UILabel     *_rightScoreLineLabel;
    UILabel     *_leftScoreLabel;
    UILabel     *_rightScoreLabel;
    UITableView *_tableView;
}


@property (nonatomic, strong) SCGuessListVC *guessListVC;
@property (nonatomic, strong) SCTeletextListVC *teletextListVC;
@property (nonatomic, strong) SCScheduleVideoListVC *videoListVC;


@end
static CGFloat imageW = 64.0f;
static CGFloat k_left = 10.0f;
static CGFloat kscore = 1.0;
@implementation SCScheduleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.m_navBar.bg_alpha = 0.0f;
    self.m_navBar.hiddenLine = YES;
    
    
    [self configTopView];
}

- (void)configTopView {
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.fWidth, 140)];
    _topView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_topView];
    
    [self.view bringSubviewToFront:self.m_navBar];
    
    _selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, _topView.bottom, self.view.fWidth, 44)];
    _selectedView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_selectedView];
    
    _guessButton = [self topicTypeButtonWithTitle:@"竞猜"];
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
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _selectedView.bottom, self.view.fWidth, self.view.fHeight - _topView.fHeight - _selectedView.fHeight)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(_scrollView.fWidth * 3, _scrollView.fHeight);
    [self.view addSubview:_scrollView];
    
    self.guessListVC = [[SCGuessListVC alloc] init];
    self.guessListVC.topHeight = _selectedView.bottom;
    self.guessListVC.view.frame = CGRectMake(0, 0, _scrollView.fWidth, _scrollView.fHeight);
    [_scrollView addSubview:self.guessListVC.view];
    
    self.teletextListVC = [[SCTeletextListVC alloc] init];
    self.teletextListVC.topHeight = _selectedView.bottom;
    self.teletextListVC.view.frame = CGRectMake(_scrollView.fWidth, 0, _scrollView.fWidth, _scrollView.fHeight);
    [_scrollView addSubview:self.teletextListVC.view];
    
    self.videoListVC = [[SCScheduleVideoListVC alloc] init];
    self.videoListVC.topHeight = _selectedView.bottom;
    self.videoListVC.view.frame = CGRectMake(_scrollView.fWidth * 2, 0, _scrollView.fWidth, _scrollView.fHeight);
    [_scrollView addSubview:self.videoListVC.view];
    
    
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
        if (!_falg1) {
//            [_firstVC upDateData];
            _falg1 = YES;
        }
        
    }else if (sender == _scheduleButton) {
        [_scrollView setContentOffset:CGPointMake(self.view.fWidth, 0) animated:YES];
        if (!_falg2) {
//            [_secondVC upDateData];
            _falg2 = YES;
        }
        
    }else if (sender == _videoButton) {
        [_scrollView setContentOffset:CGPointMake(self.view.fWidth * 2, 0) animated:YES];
        if (!_falg3) {
//            [_thirdVC upDateData];
            _falg3 = YES;
        }
        
    }
}

- (void)uiConfig {
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    UIView *contentView = [[UIView alloc]init];
    [_scrollView addSubview:contentView];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = k_Bg_Color;
    [contentView addSubview:_titleLabel];
    _leftImageV = [[UIImageView alloc] init];
    _leftImageV.contentMode = UIViewContentModeScaleAspectFill;
    _leftImageV.clipsToBounds = YES;
    [contentView addSubview:_leftImageV];
    
    _leftLabel = [[UILabel alloc] init];
    _leftLabel.textAlignment = NSTextAlignmentCenter;
    _leftLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [contentView addSubview:_leftLabel];
    
    _rightImageV = [[UIImageView alloc] init];
    _rightImageV.contentMode = UIViewContentModeScaleAspectFill;
    _rightImageV.clipsToBounds = YES;
    [contentView addSubview:_rightImageV];
    
    _rightLabel = [[UILabel alloc] init];
    _rightLabel.textAlignment = NSTextAlignmentCenter;
    _rightLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [contentView addSubview:_rightLabel];
    
    _scoreLabel = [[UILabel alloc] init];
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    _scoreLabel.font = [UIFont systemFontOfSize:kWord_Font_40px];
    [contentView addSubview:_scoreLabel];
    
    _stateLabel = [[UILabel alloc] init];
    _stateLabel.textAlignment = NSTextAlignmentCenter;
    _stateLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    [contentView addSubview:_stateLabel];
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftButton setImage:[UIImage imageNamed:@"news_suppourt_nor"] forState:UIControlStateNormal];
    [_leftButton setImage:[UIImage imageNamed:@"news_suppourt_press"] forState:UIControlStateSelected];
    [contentView addSubview:_leftButton];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.backgroundColor = [UIColor blueColor];
    [contentView addSubview:_rightButton];
    
    _leftScoreLabel = [[UILabel alloc]init];
    _leftScoreLabel.textColor = kWord_Color_High;
    _leftScoreLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    [contentView addSubview:_leftScoreLabel];


    _rightScoreLabel = [[UILabel alloc]init];
    _rightScoreLabel.textColor = kWord_Color_High;
    _rightScoreLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    [contentView addSubview:_rightScoreLabel];
    
    _leftScoreLineLabel = [[UILabel alloc]init];
    _leftScoreLineLabel.backgroundColor = [UIColor redColor];
    [contentView addSubview:_leftScoreLineLabel];
    
    _rightScoreLineLabel = [[UILabel alloc]init];
    _rightScoreLineLabel.backgroundColor = [UIColor redColor];
    [contentView addSubview:_rightScoreLineLabel];
    
    UIView  *backView = [[UIView alloc]init];
    backView.layer.borderColor = k_Bg_Color.CGColor;
    backView.layer.borderWidth = 1;
    [contentView addSubview:backView];
    
//    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    firstButton.imageView.image = [UIImage imageNamed:@""];
//    firstButton.imageView.backgroundColor = [UIColor yellowColor];
//    [firstButton setTitle:@"进程" forState:UIControlStateNormal];
//    [backView addSubview:firstButton];
//    
//    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    secondButton.imageView.image = [UIImage imageNamed:@""];
//    secondButton.imageView.backgroundColor = [UIColor yellowColor];
//    [secondButton setTitle:@"竞猜" forState:UIControlStateNormal];
//    [backView addSubview:secondButton];
//    
//    UIButton *thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    thirdButton.imageView.image = [UIImage imageNamed:@""];
//    thirdButton.imageView.backgroundColor = [UIColor yellowColor];
//    [thirdButton setTitle:@"视频" forState:UIControlStateNormal];
//    [backView addSubview:thirdButton];
    
    
    
    _WEAKSELF(ws);
    CGFloat imageWidth = imageW * ([UIScreen mainScreen].bounds.size.width / 320.0);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.m_navBar.mas_bottom);
        make.left.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
    }];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView);
        make.left.right.equalTo(contentView);
    }];
    [_leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(15);
        make.left.equalTo(contentView).offset(20);
        make.size.mas_equalTo(CGSizeMake(imageWidth, imageWidth));
    }];
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftImageV.mas_bottom).offset(k_left);
        make.left.equalTo(contentView).offset(k_left);
        make.centerX.equalTo(_leftImageV);
    }];
    [_rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftImageV);
        make.right.equalTo(contentView).offset(-20);
        make.size.equalTo(_leftImageV);
    }];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_rightImageV);
        make.centerY.equalTo(_leftLabel);
    }];
    [_scoreLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(_leftImageV);
    }];
    [_stateLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scoreLabel.mas_bottom).offset(k_left);
        make.centerX.equalTo(_scoreLabel);
    }];
    
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_leftLabel);
        make.top.equalTo(_leftLabel.mas_bottom).offset(k_left);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_rightLabel);
        make.top.equalTo(_rightLabel.mas_bottom).offset(k_left);
        make.size.mas_equalTo(CGSizeMake(24, 24));

    }];
    
    [_leftScoreLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftButton.mas_right).offset(k_left);
        make.centerY.equalTo(_leftButton);
        make.width.equalTo(_rightScoreLineLabel).multipliedBy(kscore);
        make.height.mas_equalTo(@2);
    }];
    
    [_rightScoreLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftScoreLineLabel.mas_right);
        make.right.equalTo(_rightButton.mas_left).offset(-k_left);
        make.centerY.equalTo(_rightButton);
        make.height.equalTo(_leftScoreLineLabel);
    }];
    
    [_leftScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftScoreLineLabel.mas_bottom).offset(k_left);
        make.left.equalTo(_leftScoreLineLabel).offset(k_left);
        make.right.equalTo(_rightScoreLabel.mas_left);
    }];
    
    [_rightScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_leftScoreLabel);
        make.right.equalTo(_rightScoreLineLabel).offset(-k_left);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_leftScoreLabel).offset(k_left);
    }];
    
}

-(void)p_preparData{
    _titleLabel.text = @"季后赛BO54月13日";
    _leftImageV.backgroundColor = [UIColor cyanColor];
    _rightImageV.backgroundColor = [UIColor cyanColor];
    
    _leftLabel.text = @"IG";
    _rightLabel.text = @"LGD";
    _scoreLabel.text = @"2:1";
    _stateLabel.text = @"看视频";
    _leftScoreLabel.text = @"123";
    _rightScoreLabel.text = @"234";
    
    kscore = 123/234;
    
    
    
    
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
