//
//  LWMineVC_iPhone.m
//  Athletics
//
//  Created by 李宛 on 16/4/9.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWMineVC_iPhone.h"

#import "SCCommonCell.h"
#import "SCLoginVC.h"
#import "SCSettingVC.h"
#import "SCMineInfoVC.h"
#import "SCUserInfoModel.h"

#import "SCMyPostsVC.h"
#import "SCAppointVC.h"

@interface LWMineVC_iPhone ()
{
    UIView          *_headerView;
    UIImageView     *_bgImageV;
    UIButton        *_setupButton;
    UIButton        *_messageButton;
    
    UIImageView     *_avatar;
    UIButton        *_loginButton;
    UILabel         *_nameLabel;
    UILabel         *_phoneLabel;
    
    SCUserModel *_model;
}

@end

static CGFloat avatarH = 88;
static CGFloat topHeight = 240;
static NSString *commonCellId = @"SCCommonCell";

@implementation LWMineVC_iPhone

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self animationWithDuration:1.1];

    if ([SCUserInfoManager isLogin]) {
        self.sessionTask = [SCNetwork userInfoSuccess:^(SCUserInfoModel *model) {
            _model = model.data;
            [SCUserInfoManager updateUserInfo:_model];
            
            [self updateUserInfo];
            
        } message:^(NSString *resultMsg) {
            [self postErrorMessage:resultMsg];
            
        }];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [kNotificationCenter addObserver:self
                            selector:@selector(p_loginSuccessfulNotif:)
                                name:kLoginSuccessfulNotification
                              object:nil];
    [kNotificationCenter addObserver:self
                            selector:@selector(p_logoutSuccessfulNotif:)
                                name:kLogoutSuccessfulNotification
                              object:nil];
    
    //隐藏导航条
    self.m_navBar.bg_alpha = 0.0f;
    self.m_navBar.current_color = k_Base_Color;
    
    _tableView.frame = CGRectMake(0, 0, self.view.fWidth, self.view.fHeight - 49);
    [self.view bringSubviewToFront:self.m_navBar];
    
    _tableView.separatorColor = k_Border_Color;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_tableView registerClass:[SCCommonCell class] forCellReuseIdentifier:commonCellId];
    
    _setupButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_setupButton setImage:[UIImage imageNamed:@"mine_set"] forState:UIControlStateNormal];
    [_setupButton setImage:[UIImage imageNamed:@"mine_set"] forState:UIControlStateHighlighted];
    [_setupButton addTarget:self action:@selector(p_setupButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.m_navBar addSubview:_setupButton];
    
    _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_messageButton setImage:[UIImage imageNamed:@"mine_message"] forState:UIControlStateNormal];
    [_messageButton setImage:[UIImage imageNamed:@"mine_message"] forState:UIControlStateHighlighted];
    [_messageButton addTarget:self action:@selector(p_messageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.m_navBar addSubview:_messageButton];
    CGSize buttonSize = CGSizeMake(40, 40);
    _WEAKSELF(ws);
    [_setupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.m_navBar).offset(5);
        make.size.mas_equalTo(buttonSize);
        make.bottom.equalTo(ws.m_navBar).offset(-2);
    }];
    [_messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.m_navBar).offset(-5);
        make.size.mas_equalTo(buttonSize);
        make.bottom.equalTo(ws.m_navBar).offset(-2);
    }];
    
    //64 + 15 + 88 + 10 + 30 + ..
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.fWidth, topHeight)];
    _headerView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = _headerView;
    
    UITapGestureRecognizer *userInfoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_userInfoTap:)];
    [_headerView addGestureRecognizer:userInfoTap];
    
    UIView *tableBackView = [[UIView alloc] initWithFrame:_tableView.bounds];
    tableBackView.backgroundColor = [UIColor clearColor];
    _bgImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tableBackView.fWidth, topHeight)];
    _bgImageV.image = [UIImage imageNamed:@"mine_background"];
    _bgImageV.contentMode = UIViewContentModeScaleAspectFill;
    _bgImageV.clipsToBounds = YES;
    [tableBackView addSubview:_bgImageV];
    [_tableView setBackgroundView:tableBackView];
    
    [self p_uiConfig];
    
}

- (void)p_uiConfig {
    
    _avatar = [[UIImageView alloc] init];
    _avatar.layer.cornerRadius = avatarH / 2.0;
    _avatar.clipsToBounds = YES;
    _avatar.layer.borderWidth = 3.0f;
    _avatar.layer.borderColor = [UIColor whiteColor].CGColor;
    [_headerView addSubview:_avatar];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginButton setTitle:@"点击登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(p_loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_30px];
    _loginButton.hidden = YES;
    [_headerView addSubview:_loginButton];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [_headerView addSubview:_nameLabel];
    
    _phoneLabel = [[UILabel alloc] init];
    _phoneLabel.textColor = [UIColor whiteColor];
    _phoneLabel.textAlignment = NSTextAlignmentCenter;
    _phoneLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [_headerView addSubview:_phoneLabel];
    
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headerView);
        make.size.mas_equalTo(CGSizeMake(avatarH, avatarH));
        make.top.equalTo(_headerView).offset(64 + 15);
    }];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_avatar.mas_bottom);
        make.height.mas_equalTo(@44);
        make.left.right.equalTo(_avatar);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_avatar.mas_bottom).offset(10);
        make.left.equalTo(_headerView).offset(30);
        make.right.equalTo(_headerView).offset(-30);
    }];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
        make.left.right.equalTo(_nameLabel);
    }];
    
    
    [self updateUserInfo];

}

- (void)updateUserInfo {
    if ([SCUserInfoManager isLogin]) {// 当前已经是登录状态，则不处理
        _nameLabel.hidden = NO;
        _phoneLabel.hidden = NO;
        _loginButton.hidden = YES;
        _nameLabel.text = [SCUserInfoManager userName];
        _phoneLabel.text = [SCUserInfoManager mobile].length > 7 ? [[SCUserInfoManager mobile] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]: @"";
        [_avatar scImageWithURL:[SCUserInfoManager avatar] placeholderImage:kImageWithName(@"mine_default_avatar")];
    }else {
        _nameLabel.text = nil;
        _nameLabel.hidden = YES;
        _phoneLabel.text = nil;
        _phoneLabel.hidden = YES;
        _loginButton.hidden = NO;
        [_avatar scImageWithURL:nil placeholderImage:kImageWithName(@"mine_default_avatar")];
    }
}

- (void)p_loginSuccessfulNotif:(NSNotification *)userInfo {
    if ([SCUserInfoManager isLogin]) {// 当前已经是登录状态，则不处理
        [self updateUserInfo];
    }
    [_tableView reloadData];
    
}

- (void)p_logoutSuccessfulNotif:(NSNotification *)userInfo {
    _model = nil;
    if (![SCUserInfoManager isLogin]) {// 当前已经是未登录状态，则不处理
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self updateUserInfo];
    }
    [_tableView reloadData];
}

- (void)p_userInfoTap:(UITapGestureRecognizer *)sender {
    if (![SCUserInfoManager isLogin]) {
        SCLoginVC *loginVC = [[SCLoginVC alloc] init];
        [loginVC loginWithPresentController:self successCompletion:^(BOOL result) {
            if (result) {
                
            }
        }];
    }else {
        SCMineInfoVC *infoVC = [[SCMineInfoVC alloc] init];
        infoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infoVC animated:YES];
    }
}

- (void)p_setupButtonClicked:(UIButton *)sender {
//    HYBSettingController *setVC = [[HYBSettingController alloc] init];
//    setVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:setVC animated:YES];
}

- (void)p_messageButtonClicked:(UIButton *)sender {
    if (![SCUserInfoManager isLogin]) {
        SCLoginVC *loginVC = [[SCLoginVC alloc] init];
        [loginVC loginWithPresentController:self successCompletion:^(BOOL result) {
            if (result) {
//                SCMyMessageVC_iPhone *messageVC = [[SCMyMessageVC_iPhone alloc] init];
//                messageVC.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:messageVC animated:YES];
            }
        }];
    }else {
//        SCMyMessageVC_iPhone *messageVC = [[SCMyMessageVC_iPhone alloc] init];
//        messageVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:messageVC animated:YES];
    }
}

- (void)p_loginButtonClick:(UIButton *)sender {
    SCLoginVC *loginVC = [[SCLoginVC alloc] init];
    [loginVC loginWithPresentController:self successCompletion:^(BOOL result) {
        if (result) {
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - TableViewDatasouse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if (section == 1) {
        return 1;
    }else if (section == 2) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:commonCellId];
    
    cell.leftImage = nil;
    cell.leftLabel.text = @"";
    cell.rightLabel.text = @"";
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.leftImage = [UIImage imageNamed:@"icon_member_combo"];
            cell.leftLabel.text = @"我的帖子";
        }else {
            cell.leftImage = [UIImage imageNamed:@"icon_member_combo"];
            cell.leftLabel.text = @"我的预约";
        }
    }
//    else if (indexPath.section == 1) {
//        cell.leftImage = [UIImage imageNamed:@"icon_member_combo"];
//        cell.leftLabel.text = @"消息";
//    }
    else {
        cell.leftImage = [UIImage imageNamed:@"icon_member_combo"];
        cell.leftLabel.text = @"设置";
    }
    
    return cell;
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 15.0f;
    }
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //section = 1
    
    NSInteger section = indexPath.section;
    
    if (section == 0) {
//        if (section == 0 || section == 1) {
        //未登录需要登录
        if (![SCUserInfoManager isLogin]) {
            SCLoginVC *loginVC = [[SCLoginVC alloc] init];
            [loginVC loginWithPresentController:self successCompletion:^(BOOL result) {
                if (result) {
                    if (indexPath.section == 0) {
                        if (indexPath.row == 0) {
                            SCMyPostsVC *postsVC = [[SCMyPostsVC alloc] init];
                            postsVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:postsVC animated:YES];
                        }else if (indexPath.row == 1) {
                            SCAppointVC *appointVC = [[SCAppointVC alloc] init];
                            appointVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:appointVC animated:YES];
                        }
                    }else if (indexPath.section == 1) {
                        
                    }
                }
            }];
        }else {
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    SCMyPostsVC *postsVC = [[SCMyPostsVC alloc] init];
                    postsVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:postsVC animated:YES];
                }else if (indexPath.row == 1) {
                    SCAppointVC *appointVC = [[SCAppointVC alloc] init];
                    appointVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:appointVC animated:YES];
                }
            }else if (indexPath.section == 1) {
                
            }
        }
    }else {
        SCSettingVC *settingVC = [[SCSettingVC alloc] init];
        settingVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _tableView) {
        if (scrollView.contentOffset.y <= topHeight) {
            _bgImageV.frame = CGRectMake(0, 0, _tableView.fWidth, topHeight - scrollView.contentOffset.y);
            if (scrollView.contentOffset.y > 0) {
                CGFloat alpha = scrollView.contentOffset.y / (topHeight - 64);
                self.m_navBar.bg_alpha = alpha <= 1.0 ? alpha : 1.0;
            }else {
                self.m_navBar.bg_alpha = 0.0f;
            }
        }
    }
}

#pragma mark - 给头像增加特效
- (void)animationWithDuration:(NSTimeInterval)duration {
    if ([SCUserInfoManager isLogin]) {
        CGAffineTransform animateTransform = CGAffineTransformScale(CGAffineTransformIdentity, .6, .6);
        _avatar.layer.affineTransform = animateTransform;
        
        if (kIsIOS7OrLater) {
            [UIView animateWithDuration:duration
                                  delay:0.0
                 usingSpringWithDamping:0.4
                  initialSpringVelocity:0.0
                                options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 _avatar.layer.affineTransform = CGAffineTransformIdentity;
                             } completion:^(BOOL finished) {
                             }];
        }else {
            [UIView animateWithDuration:0.4 animations:^{
                _avatar.layer.affineTransform = CGAffineTransformIdentity;
            }];
        }
    } else{
        CATransform3D transform3D = CATransform3DIdentity;
        transform3D.m34 = -1/1000;
        CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
        CAKeyframeAnimation *animationRotation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.y"];
        animationRotation.values = @[@(0),@(M_PI_4),@(0),@(-M_PI_4),@(0),];
        animationRotation.duration = 1.2;
        animationRotation.timingFunction = fn;
        
        CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
        animationGroup.animations = @[animationRotation];
        animationGroup.duration = animationRotation.duration;
        animationGroup.delegate = self;
        animationGroup.beginTime = CACurrentMediaTime() + .5;
        
        [_avatar.layer addAnimation:animationGroup forKey:@"transform.rotation.y"];
        
    }
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
