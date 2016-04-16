//
//  SCScheduleDetailVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCScheduleDetailVC.h"

@interface SCScheduleDetailVC ()
{
    UIScrollView *_scrollView;
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

@end
static CGFloat imageW = 64.0f;
static CGFloat k_left = 10.0f;
static CGFloat kscore = 1.0;
@implementation SCScheduleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uiConfig];
    [self p_preparData];

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
