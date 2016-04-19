//
//  SCGuessListVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCGuessListVC.h"

@interface SCGuessListVC ()

@end

@implementation SCGuessListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.m_navBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor cyanColor];

    _tableView.frame = CGRectMake(0, 0, self.view.fWidth, self.view.fHeight - _topHeight);

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
