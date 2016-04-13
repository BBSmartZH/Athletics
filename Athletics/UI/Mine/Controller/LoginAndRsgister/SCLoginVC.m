//
//  SCLoginVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCLoginVC.h"
#import "LWBaseNavVC_iPhone.h"

#import "SCRegisterVC.h"

@interface SCLoginVC ()<UITextFieldDelegate>
{
    UITextField *_mobileTextField;
    UIView      *_mobileView;
    UITextField *_passwordTextField;
    UIView      *_passwordView;
    UIButton    *_loginButton;
    UIButton    *_showPwdBtn;
    UIView      *_line;
    LoginSuccessBlock _completionBlock;
}


@end

@implementation SCLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = k_Border_Color;
    
    self.title = @"登录";
    
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.frame = self.view.bounds;
    _tableView.separatorColor = k_Border_Color;
    
    [self.view bringSubviewToFront:self.m_navBar];
    UIImageView *bgImagV = [[UIImageView alloc] initWithImage:nil];
    bgImagV.image = [UIImage imageNamed:@"logo_login"];
    bgImagV.frame  = CGRectMake((self.view.fWidth-292)/2.0, 90, 292, 121);
    [self.view addSubview:bgImagV];
    [self.view sendSubviewToBack:bgImagV];
    
    UIView *headerView = [[UIView alloc] init];
    
    CGFloat headerHeight = 240;
    CGFloat rowHeihht = 104;
    CGFloat footerHeight = self.view.fHeight - headerHeight - rowHeihht;
    headerView.frame = CGRectMake(0, 0, self.view.fWidth, headerHeight);
    _tableView.tableHeaderView = headerView;
    
    _tableView.rowHeight = rowHeihht;
    
    UIView *tableFootView = [[UIView alloc] init];
    tableFootView.backgroundColor = [UIColor clearColor];
    tableFootView.frame = CGRectMake(0, 0, self.view.fWidth, footerHeight);
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.backgroundColor = k_Base_Color;
    _loginButton.layer.cornerRadius = 5;
    _loginButton.frame = CGRectMake(15, 20, self.view.fWidth-30, 44);
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(p_loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_36px];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tableFootView addSubview:_loginButton];
    
    //忘记密码
    UIButton *forPassWordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forPassWordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forPassWordButton.frame = CGRectMake(_loginButton.left, _loginButton.bottom + 15, 70, 30);
    [forPassWordButton setTitle:@"忘记密码>" forState:UIControlStateNormal];
    forPassWordButton.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [forPassWordButton addTarget:self action:@selector(p_findPasswordButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [forPassWordButton setTitleColor:kWord_Color_Low forState:UIControlStateNormal];
    [tableFootView addSubview:forPassWordButton];
    
    //注册
    UIButton *registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registButton.frame = CGRectMake(_loginButton.right - 70, _loginButton.bottom + 15, 70, 30);
    [registButton setTitle:@"手机注册>" forState:UIControlStateNormal];
    registButton.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [registButton addTarget:self action:@selector(p_registButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [registButton setTitleColor:kWord_Color_Low forState:UIControlStateNormal];
    [tableFootView addSubview:registButton];
    
    _tableView.tableFooterView = tableFootView;
    
    
    
}

- (void)p_loginButtonClicked:(UIButton *)sender {
    if ([SCGlobaUtil isEmpty:_mobileTextField.text]) {
        [self postErrorMessage:@"请输入手机号"];
        return;
    }
    
    if ([SCGlobaUtil isEmpty:_passwordTextField.text]) {
        [self postErrorMessage:@"请输入密码"];
        return;
    }
    
    if (![SCGlobaUtil validateMobileNumber:_mobileTextField.text]) {
        [self postErrorMessage:@"请输入正确的手机号"];
        return;
    }
    
    if (_passwordTextField.text.length < 6 || _passwordTextField.text.length > 16) {
        [self postErrorMessage:@"请输入6-16位有效的密码"];
        return;
    }
    
    [self.view endEditing:YES];
    [self p_login];
}

#pragma mark - 登录

- (void)p_login {
    
    
    
    if (_completionBlock) {
        _completionBlock(YES);
    }
}

/*!
 * @brief 调用此方法来显示登录界面
 * @param presentController 显示登录界面的控制器类
 * @param successCompletion 登录成功后的回调block
 */
- (void)loginWithPresentController:(UIViewController *)presentController
                 successCompletion:(LoginSuccessBlock)successCompletion {
    _completionBlock = [successCompletion copy];
    [_mobileTextField becomeFirstResponder];
    self.isPresented = YES;
    UINavigationController *nav = self.navigationController;
    if (nav == nil) {
        nav = [[LWBaseNavVC_iPhone alloc] initWithRootViewController:self];
    }
    nav.navigationBar.hidden = YES;
    [presentController presentViewController:nav animated:YES completion:NULL];
}

- (void)p_findPasswordButtonClicked:(UIButton *)sender {
    
}

- (void)p_registButtonClicked:(UIButton *)sender {
    SCRegisterVC *registerVC = [[SCRegisterVC alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
#pragma mark 创建cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *loginView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, self.view.fWidth-30, 104)];
    loginView.backgroundColor = [UIColor whiteColor];
    loginView.tag = 10000;
    loginView.layer.cornerRadius = 5;
    [cell.contentView addSubview:loginView];
    cell.backgroundColor = [UIColor clearColor];
    UIView *inforView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, self.view.fWidth-30, 104)];
    [cell.contentView addSubview:inforView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(inforView.frame)/2.0, CGRectGetWidth(inforView.frame), 0.5)];
    lineView.backgroundColor = k_Border_Color;
    [inforView addSubview:lineView];
    
    CGRect frame = CGRectMake(0, 0,CGRectGetWidth(inforView.frame),CGRectGetHeight(inforView.frame)/2.0);
    _mobileTextField = [self textFieldWithFrame:frame type:1];
    //    _mobileTextField.text = @"13810247666";
    _mobileTextField.keyboardType = UIKeyboardTypePhonePad;
    [inforView addSubview:_mobileTextField];
    
    frame = CGRectMake(0, CGRectGetMaxY(_mobileTextField.frame), CGRectGetWidth(_mobileTextField.frame), CGRectGetHeight(_mobileTextField.frame));
    _passwordTextField = [self textFieldWithFrame:frame type:2];
    //    _passwordTextField.text = @"123456";
    [inforView addSubview:_passwordTextField];
    
    
    return cell;
}

- (void)p_showPwdBtnClicked:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    _passwordTextField.secureTextEntry = !_passwordTextField.secureTextEntry;
}

- (UITextField *)textFieldWithFrame:(CGRect)frame type:(int)type {
    NSString *holder = type == 1 ? @"请输入手机号" : @"请输入密码";
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.placeholder = holder;
    textField.font = [UIFont systemFontOfSize:kWord_Font_28px];
    textField.textColor = kWord_Color_Event;
    textField.secureTextEntry = (type == 2);
    textField.delegate = self;
    textField.backgroundColor = [UIColor clearColor];
    textField.leftView.backgroundColor = [UIColor clearColor];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.returnKeyType = type == 1 ? UIReturnKeyNext : UIReturnKeyDone;
    
    
    UIImage *img = type == 1 ? [UIImage imageNamed:@"icon_phone"]:[UIImage imageNamed:@"icon_password"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (textField.fHeight - img.size.height) / 2.0, img.size.width, img.size.height)];
    imageView.image = img;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,imageView.fWidth+20, textField.fHeight)];
    [textField.leftView addSubview:imageView];
    
    
    return textField;
}

#pragma mark 限制手机和密码输入长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _mobileTextField) {
        if (_mobileTextField.text.length + string.length > 11 ) {
            return NO;
        }
    }else{
        if (_passwordTextField.text.length + string.length >16) {
            return NO;
        }
        if ([string isEqualToString:@"\n"]) {
            [self.view endEditing:YES];
            [self p_loginButtonClicked:nil];
            return NO;
        }
    }
    return YES;
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
