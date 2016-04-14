//
//  SCCommuntityPostedVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCCommuntityPostedVC.h"

@interface SCCommuntityPostedVC ()<UITextFieldDelegate, UITextViewDelegate>
{
    UITextField *_textFiled;
    UITextView *_textView;
    UIButton *_postdButton;
}

@end

@implementation SCCommuntityPostedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"发表帖子";
    
     _postdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _postdButton.frame = CGRectMake(self.navigationController.navigationBar.bounds.size.width - 40, 27, 40, 30);
    [_postdButton addTarget:self action:@selector(rightBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_postdButton setTitle:@"发帖" forState:UIControlStateNormal];
    [_postdButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _postdButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.m_navBar addSubview:_postdButton];
    _postdButton.enabled = NO;
    
    _textFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, self.m_navBar.bottom, self.view.fWidth, 44)];
    _textFiled.delegate = self;
    _textFiled.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [self.view addSubview:_textFiled];
    _textFiled.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _textFiled.fHeight)];
    _textFiled.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _textFiled.fHeight)];
    _textFiled.leftViewMode = UITextFieldViewModeAlways;
    _textFiled.rightViewMode = UITextFieldViewModeAlways;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, _textFiled.fHeight - 0.5, _textFiled.fWidth - 20, 0.5)];
    line.backgroundColor = k_Border_Color;
    [_textFiled addSubview:line];
    
    _textView = [[UITextView alloc] init];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [self.view addSubview:_textView];
    
}

-(void)rightBarButtonClicked:(UIButton *)sender {
    
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
