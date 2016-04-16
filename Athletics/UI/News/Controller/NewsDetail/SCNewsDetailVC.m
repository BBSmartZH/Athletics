//
//  SCNewsDetailVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNewsDetailVC.h"

#import "SCCommentListVC.h"

@interface SCNewsDetailVC ()
{
    
    UIView *_inputView;

    //Test
    UIButton *_commentButton;

}


@end

@implementation SCNewsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"资讯";
    
    _inputView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.fHeight - 44, self.view.fWidth, 44)];
    _inputView.backgroundColor = [UIColor cyanColor];
    _inputView.layer.borderWidth = .5f;
    _inputView.layer.borderColor = k_Border_Color.CGColor;
    [self.view addSubview:_inputView];
    
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentButton.backgroundColor = [UIColor redColor];
    [_commentButton setTitle:@"334评" forState:UIControlStateNormal];
    _commentButton.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    _commentButton.frame = CGRectMake(_inputView.fWidth - 10 - 60, 7, 60, 30);
    [_commentButton addTarget:self action:@selector(commentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_inputView addSubview:_commentButton];
    

}

- (void)commentButtonClicked:(UIButton *)sender {
    SCCommentListVC *commentVC = [[SCCommentListVC alloc] init];
    [self.navigationController pushViewController:commentVC animated:YES];
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
