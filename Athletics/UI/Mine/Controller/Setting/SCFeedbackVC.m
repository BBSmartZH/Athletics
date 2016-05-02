//
//  SCFeedbackVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/21.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCFeedbackVC.h"
#import "SCMessageTextView.h"

@interface SCFeedbackVC ()<UITextViewDelegate, UIAlertViewDelegate>
{
    SCMessageTextView *_textView;
}

@end

@implementation SCFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"意见反馈";
    
    [self uiConfig];
}

- (void)uiConfig
{
    self.title = @"意见反馈";
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.m_navBar.bottom + 10, self.view.fWidth - 20, 40)];
    titleLabel.text = @"请留下您的宝贵意见";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.view addSubview:titleLabel];
    
    _textView = [[SCMessageTextView alloc] initWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom, titleLabel.fWidth, 150 * ([UIScreen mainScreen].bounds.size.height / 568))];
    _textView.placeHolder = @"输入你想说的话";
    _textView.layer.cornerRadius = 5;
    _textView.layer.borderWidth = 0.5;
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.textColor = [UIColor lightGrayColor];
    _textView.layer.borderColor = k_Base_Color.CGColor;
    _textView.delegate = self;
    _textView.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_textView];
    
    
    UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    enterButton.frame = CGRectMake(self.view.fWidth - 150, _textView.bottom + 10, 140, 40);
    [enterButton addTarget:self action:@selector(enterSubmit:) forControlEvents:UIControlEventTouchUpInside];
    [enterButton setTitle:@"提  交" forState:UIControlStateNormal];
    enterButton.backgroundColor = k_Base_Color;
    enterButton.layer.cornerRadius = 5;
    [self.view addSubview:enterButton];
    
}

- (void)enterSubmit:(UIButton *)enterButton
{
    if ([SCGlobaUtil isEmpty:_textView.text ]) {
        [self postMessage:@"请填写您的宝贵意见"];
    }
    else {
        [self startActivityAnimation];
        self.sessionTask = [SCNetwork feedbackWithContent:_textView.text Success:^(SCResponseModel *model) {
            [self stopActivityAnimation];
            [self postErrorMessage:@"提交成功，感谢反馈"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];

            });
        } message:^(NSString *resultMsg) {
            [self postErrorMessage:resultMsg];
        }];
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
