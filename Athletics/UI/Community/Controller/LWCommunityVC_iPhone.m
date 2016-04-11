//
//  LWCommunityVC_iPhone.m
//  Athletics
//
//  Created by 李宛 on 16/4/9.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWCommunityVC_iPhone.h"
#import "LWNewsTabVC.h"
@interface LWCommunityVC_iPhone ()

@end

@implementation LWCommunityVC_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarButton.frame = CGRectMake(self.navigationController.navigationBar.bounds.size.width - 30, 27, 30, 30);
    [rightBarButton addTarget:self action:@selector(rightBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [rightBarButton setTitle:@"+" forState:UIControlStateNormal];
    [rightBarButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    rightBarButton.titleLabel.font = [UIFont systemFontOfSize:30];
    [self.m_navBar addSubview:rightBarButton];
    // Do any additional setup after loading the view.
}
-(void)rightBarButtonClicked:(UIButton*)sender
{
    LWNewsTabVC *vc = [[LWNewsTabVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
