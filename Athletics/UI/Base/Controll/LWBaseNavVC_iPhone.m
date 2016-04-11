//
//  LWBaseNavVC_iPhone.m
//  Link
//
//  Created by 李宛 on 16/3/10.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWBaseNavVC_iPhone.h"

@interface LWBaseNavVC_iPhone ()

@end

@implementation LWBaseNavVC_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
////    使导航条有效
    [self setNavigationBarHidden:NO];
//    隐藏导航条，但因为导航条有效，系统的返回按钮也有效，所以可以用系统的右滑手势返回。
    [self.navigationBar setHidden:YES];
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
