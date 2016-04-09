//
//  LWNavigationVC_iPhone.m
//  Athletics
//
//  Created by 李宛 on 16/4/9.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWTabBarVC_iPhone.h"
#import "LWEventsVC_iPhone.h"
#import "LWCommunityVC_iPhone.h"
#import "LWScheduleVC_iPhone.h"
#import "LWMineVC_iPhone.h"
@interface LWTabBarVC_iPhone ()

@end

@implementation LWTabBarVC_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LWEventsVC_iPhone *eventsVC = [[LWEventsVC_iPhone alloc]init];
    UINavigationController *eventsNC = [[UINavigationController alloc]initWithRootViewController:eventsVC];
    LWCommunityVC_iPhone *communityVC = [[LWCommunityVC_iPhone alloc]init];
    UINavigationController *communityNC = [[UINavigationController alloc]initWithRootViewController:communityVC];
    LWScheduleVC_iPhone *scheduleVC = [[LWScheduleVC_iPhone alloc]init];
    UINavigationController *scheduleNC = [[UINavigationController alloc]initWithRootViewController:scheduleVC];
    LWMineVC_iPhone *mineVC = [[LWMineVC_iPhone alloc]init];
    UINavigationController *mineNC = [[UINavigationController alloc]initWithRootViewController:mineVC];
//    UITabBarController *barController = [[UITabBarController alloc]init];
    self.viewControllers = @[eventsNC,communityNC,scheduleNC,mineNC];
    //    设置tabbar的字体颜色
    self.tabBar.tintColor = [UIColor blueColor];
    
    UITabBarItem *item1 = [[UITabBarItem alloc]initWithTitle:@"赛事" image:[UIImage imageNamed:@"iconfont-xinwen(1).png"] tag:100];
    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTitle:@"社区" image:[UIImage imageNamed:@"iconfont-yuedu(1).png"] tag:101];
    UITabBarItem *item3 = [[UITabBarItem alloc]initWithTitle:@"赛程" image:[UIImage imageNamed:@"iconfont-bofang(1).png"] tag:102];
     UITabBarItem *item4 = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"iconfont-bofang(1).png"] tag:103];
    eventsNC.tabBarItem = item1;
    communityNC.tabBarItem = item2;
    scheduleNC.tabBarItem = item3;
    mineNC.tabBarItem = item4;
    
    //    统一设置背景
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundColor:[UIColor whiteColor]];
    self.tabBar.translucent = NO;

    
    
    
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
