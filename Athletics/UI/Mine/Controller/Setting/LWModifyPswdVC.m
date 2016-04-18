//
//  LWModifyPswdVC.m
//  Athletics
//
//  Created by 李宛 on 16/4/18.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWModifyPswdVC.h"

@interface LWModifyPswdVC ()<UITextFieldDelegate>
{
    UITextField  *_primaryCodeTextF;
    UITextField  *_newCodeTextF;
    UITextField  *_confirmCodeTextF;
    UIButton     *_saveButton;
}
@end
static NSString *cellID = @"cellID";
@implementation LWModifyPswdVC

-(instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    CGFloat rowHeihht = 121;
    CGFloat footerHeight = 60;
    _tableView.rowHeight = rowHeihht;
    
    UIView *tableFootView = [[UIView alloc] init];
    tableFootView.backgroundColor = [UIColor clearColor];
    tableFootView.frame = CGRectMake(0, 0, self.view.fWidth, footerHeight);
    _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveButton.backgroundColor = k_Base_Color;
    _saveButton.layer.cornerRadius = 5;
    _saveButton.frame = CGRectMake(15, 20, self.view.fWidth-30, 44);
    [_saveButton setTitle:@"提交" forState:UIControlStateNormal];
    [_saveButton addTarget:self action:@selector(p_saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _saveButton.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_36px];
    [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tableFootView addSubview:_saveButton];
    
    _tableView.tableFooterView = tableFootView;

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];
    
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.fWidth, 121)];
    backView.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:backView];
    _primaryCodeTextF = [self textFieldWithFrame:CGRectMake(0, 0, self.view.fWidth, 40) type:1];
    [backView addSubview:_primaryCodeTextF];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_primaryCodeTextF.frame), self.view.fWidth-10, 0.5)];
    lineView.backgroundColor = k_Border_Color;
    [backView addSubview:lineView];
    
    _newCodeTextF = [self textFieldWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), self.view.fWidth, 40) type:2];
    [backView addSubview:_newCodeTextF];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_newCodeTextF.frame), self.view.fWidth-10, 0.5)];
    lineView2.backgroundColor = k_Border_Color;
    [backView addSubview:lineView2];
    _confirmCodeTextF = [self textFieldWithFrame:CGRectMake(0, CGRectGetMaxY(lineView2.frame), self.view.fWidth, 40) type:3];
    [backView addSubview:_confirmCodeTextF];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.02;
}

- (UITextField *)textFieldWithFrame:(CGRect)frame type:(int)type {
    NSString *holder;
    
    if (type == 1) {
        holder = @"请输入原密码";
    }else if (type == 2){
            holder = @"请输入密码";
    }else if(type == 3){
        holder = @"请再次输入新密码";
    }
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.backgroundColor = [UIColor whiteColor];
    textField.placeholder = holder;
    textField.font = [UIFont systemFontOfSize:kWord_Font_28px];
    textField.textColor = kWord_Color_Event;
    textField.secureTextEntry = YES;
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
        labelText = @"原密码";
    }else if (type == 2){
        labelText = @"新密码";
    }else if(type == 3){
        labelText = @"确认密码";
    }
    label.font = [UIFont systemFontOfSize:kWord_Font_28px];
    label.text = labelText;
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,60+20, textField.fHeight)];
    [textField.leftView addSubview:label];
    return textField;
}
         
#pragma mark 限制手机和密码输入长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
        if (textField.text.length + string.length >16) {
            return NO;
        }
        if ([string isEqualToString:@"\n"]) {
            [self.view endEditing:YES];
            [self p_saveButtonClicked:nil];
            return NO;
        }
    return YES;
}

- (void)p_saveButtonClicked:(UIButton *)sender {
    if ([SCGlobaUtil isEmpty:_primaryCodeTextF.text]) {
        [self postErrorMessage:@"原密码不能为空"];
        return;
    }else if (_primaryCodeTextF.text.length < 6){
        [self postErrorMessage:@"原密码少于6位"];
        return;
    }
    if ([SCGlobaUtil isEmpty:_newCodeTextF.text]) {
        [self postErrorMessage:@"请输新密码"];
        return;
    }else if (_newCodeTextF.text.length < 6){
        [self postErrorMessage:@"新密码少于6位"];
    }
    
    if ([SCGlobaUtil isEmpty:_confirmCodeTextF.text]) {
        [self postErrorMessage:@"请再次输入密码"];
        return;
    }else if (![_newCodeTextF.text isEqualToString:_confirmCodeTextF.text]){
        [self postErrorMessage:@"两次密码输入不一致"];
    }

    if (_newCodeTextF.text.length < 6 || _newCodeTextF.text.length > 16) {
        [self postErrorMessage:@"请输入6-16位有效的密码"];
        return;
    }
    
    [self.view endEditing:YES];
}

//回收键盘

-(void)fingerTapped:(UITapGestureRecognizer*)sender
{
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
