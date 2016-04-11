//
//  LWEventsVC_iPhone.m
//  Athletics
//
//  Created by 李宛 on 16/4/9.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWEventsVC_iPhone.h"
#import "LWCustomizeVC_iPhone.h"

#import "SCEventsVC.h"

@interface LWEventsVC_iPhone ()
{
    UIView *_topBarView;
    UIScrollView *_topScrollView;
}

@end

@implementation LWEventsVC_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarButton.frame = CGRectMake(self.navigationController.navigationBar.bounds.size.width - 30, 27, 30, 30);
    [rightBarButton addTarget:self action:@selector(rightBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [rightBarButton setTitle:@"+" forState:UIControlStateNormal];
    [rightBarButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    rightBarButton.titleLabel.font = [UIFont systemFontOfSize:30];
    [self.m_navBar addSubview:rightBarButton];
    
    
    
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 27, self.view.frame.size.width - 45, 30)];
    _topScrollView.backgroundColor = [UIColor redColor];
    [self.m_navBar addSubview:_topScrollView];

   
}

-(void)rightBarButtonClicked:(UIButton *)sender
{
//    LWCustomizeVC_iPhone *customizeVC = [[LWCustomizeVC_iPhone alloc]init];
//    [self.navigationController pushViewController:customizeVC animated:YES];
    
    SCEventsVC *customizeVC = [[SCEventsVC alloc]init];
    [self.navigationController pushViewController:customizeVC animated:YES];
    
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
