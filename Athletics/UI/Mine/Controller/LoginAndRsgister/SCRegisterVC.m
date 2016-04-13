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
    UIView      *_verificationView;
    int         _secondCountDown;
    NSTimer     *_countDownTimer;
    UIButton    *_verCodeButton;
    UIButton    *_nextButton;
}
@end

static CGFloat k_left = 15;

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
    
    self.title = @"登录";
    
    
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
