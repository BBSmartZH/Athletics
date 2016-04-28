//
//  SCChangeNameVC_iPhone.m
//  MrzjClient
//
//  Created by mrzj_sc on 15/11/30.
//  Copyright © 2015年 mrzj_sc. All rights reserved.
//

#import "SCChangeNameVC_iPhone.h"

@interface SCChangeNameVC_iPhone ()<UITextFieldDelegate>
{
    UITextField *_nameTF;
    UIButton    *_saveButton;
}

@end

@implementation SCChangeNameVC_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改用户名";
    
    _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_saveButton addTarget:self action:@selector(p_saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _saveButton.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [self.m_navBar addSubview:_saveButton];
    _saveButton.hidden = YES;
    CGSize buttonSize = CGSizeMake(40, 40);
    _WEAKSELF(ws);
    [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.m_navBar).offset(-5);
        make.size.mas_equalTo(buttonSize);
        make.bottom.equalTo(ws.m_navBar).offset(-2);
    }];
    
    _tableView.frame = CGRectMake(0, self.m_navBar.bottom, self.view.fWidth, self.view.fHeight - self.m_navBar.fHeight);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_nameTextDidChangeNotif:) name:UITextFieldTextDidChangeNotification object:nil];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.fWidth, 74)];
    _tableView.tableHeaderView = headerView;
    
    _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 15, headerView.fWidth, 44)];
    _nameTF.textColor = kWord_Color_Event;
    _nameTF.backgroundColor = [UIColor whiteColor];
    _nameTF.font = [UIFont systemFontOfSize:kWord_Font_28px];
    _nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameTF.text = _name;
    _nameTF.delegate = self;
    _nameTF.leftViewMode = UITextFieldViewModeAlways;
    [headerView addSubview:_nameTF];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, _nameTF.fHeight)];
    _nameTF.leftView = leftView;
    
}

- (void)p_saveButtonClicked:(UIButton *)sender {
    if (_completion) {
        _completion(_nameTF.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)p_nameTextDidChangeNotif:(NSNotification *)info {
    if ([_name isEqualToString:_nameTF.text]) {
        _saveButton.hidden = YES;
    }else {
        _saveButton.hidden = NO;
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
