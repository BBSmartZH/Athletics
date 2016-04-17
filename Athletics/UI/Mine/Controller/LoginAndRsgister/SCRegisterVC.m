//
//  SCRegisterVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCRegisterVC.h"

@interface SCRegisterVC ()<UITextFieldDelegate>
{
    UITextField *_phoneTextField;
    UITextField *_verificationTextField;
    UITextField *_passwordTextField;
    UIView      *_verificationView;
    int         _secondCountDown;
    NSTimer     *_countDownTimer;
    UIButton    *_verCodeButton;
    UIButton    *_nextButton;
}
@end

static CGFloat k_left = 15;
static  NSString *cellId = @"cellId";
@implementation SCRegisterVC

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        //
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.type == 1) {
        self.title = @"手机注册";

    }else{
        self.title = @"忘记密码";

    }
    
    CGFloat rowHeihht = 121;
    CGFloat footerHeight = self.view.fHeight - rowHeihht;
    _tableView.rowHeight = rowHeihht;

    UIView *tableFootView = [[UIView alloc] init];
    tableFootView.backgroundColor = [UIColor clearColor];
    tableFootView.frame = CGRectMake(0, 0, self.view.fWidth, footerHeight);
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextButton.backgroundColor = k_Base_Color;
    _nextButton.layer.cornerRadius = 5;
    _nextButton.frame = CGRectMake(15, 20, self.view.fWidth-30, 44);
    [_nextButton setTitle:@"提交" forState:UIControlStateNormal];
    [_nextButton addTarget:self action:@selector(p_registerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _nextButton.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_36px];
    [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tableFootView addSubview:_nextButton];
    
    _tableView.tableFooterView = tableFootView;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.fWidth, 121)];
    backView.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:backView];
    _phoneTextField = [self textFieldWithFrame:CGRectMake(0, 0, self.view.fWidth, 40) type:1];
    [backView addSubview:_phoneTextField];

    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_phoneTextField.frame), self.view.fWidth-10, 0.5)];
    lineView.backgroundColor = k_Border_Color;
    [backView addSubview:lineView];
    
    _verificationTextField = [self textFieldWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), self.view.fWidth, 40) type:3];
    [backView addSubview:_verificationTextField];

    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_verificationTextField.frame), self.view.fWidth-10, 0.5)];
    lineView2.backgroundColor = k_Border_Color;
    [backView addSubview:lineView2];
    _passwordTextField = [self textFieldWithFrame:CGRectMake(0, CGRectGetMaxY(lineView2.frame), self.view.fWidth, 40) type:2];
    [backView addSubview:_passwordTextField];
    return cell;
}

- (UITextField *)textFieldWithFrame:(CGRect)frame type:(int)type {
    NSString *holder;

    if (type == 1) {
        holder = @"请输入手机号";
    }else if (type == 2){
        if (self.type == 2) {
            holder = @"请重新设置密码";
        }else{
        holder = @"请输入密码";
        }
    }else if(type == 3){
        holder = @"请输入验证码";
    }
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.backgroundColor = [UIColor whiteColor];
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
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, textField.fHeight)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kWord_Color_High;
    NSString *labelText;
    if (type == 1) {
        labelText = @"手机号";
    }else if (type == 2){
        labelText = @"密码";
    }else if(type == 3){
        labelText = @"验证码";
    }
    label.font = [UIFont systemFontOfSize:kWord_Font_28px];
    label.text = labelText;
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,60+20, textField.fHeight)];
    [textField.leftView addSubview:label];
    if (type == 3) {
        textField.rightView = [[UIView alloc]initWithFrame:CGRectMake(self.view.fWidth -100, 0, 100, textField.fHeight)];
        textField.rightViewMode = UITextFieldViewModeAlways;
        _verCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _verCodeButton.frame = CGRectMake(0, 10, 80, 20);
        _verCodeButton.backgroundColor = [UIColor blueColor];
        _verCodeButton.layer.cornerRadius = 5;
        _verCodeButton.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
        [_verCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_verCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [textField.rightView addSubview:_verCodeButton];

    }
    
    
    return textField;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.02;
}

#pragma mark 限制手机和密码输入长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _phoneTextField) {
        if (_phoneTextField.text.length + string.length > 11 ) {
            return NO;
        }
    }else if(textField ==_passwordTextField){
        if (_passwordTextField.text.length + string.length >16) {
            return NO;
        }
        if ([string isEqualToString:@"\n"]) {
            [self.view endEditing:YES];
            [self p_registerButtonClicked:nil];
            return NO;
        }
    }
    return YES;
}

- (void)p_registerButtonClicked:(UIButton *)sender {
    if ([SCGlobaUtil isEmpty:_phoneTextField.text]) {
        [self postErrorMessage:@"请输入手机号"];
        return;
    }
    if ([SCGlobaUtil isEmpty:_verificationTextField.text]) {
        [self postErrorMessage:@"请输入验证码"];
        return;
    }
    
    if ([SCGlobaUtil isEmpty:_passwordTextField.text]) {
        [self postErrorMessage:@"请输入密码"];
        return;
    }
   
    if (![SCGlobaUtil validateMobileNumber:_phoneTextField.text]) {
        [self postErrorMessage:@"请输入正确的手机号"];
        return;
    }
    
    if (_passwordTextField.text.length < 6 || _passwordTextField.text.length > 16) {
        [self postErrorMessage:@"请输入6-16位有效的密码"];
        return;
    }
    
    [self.view endEditing:YES];
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
