//
//  LWNavigationVC_iPhone.m
//  Athletics
//
//  Created by 李宛 on 16/4/9.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWTabBarVC_iPhone.h"
#import "LWBaseNavVC_iPhone.h"
#import "LWEventsVC_iPhone.h"
#import "LWCommunityVC_iPhone.h"
#import "LWScheduleVC_iPhone.h"
#import "LWMineVC_iPhone.h"

@interface LWTabBarVC_iPhone ()
{
    UITabBarItem *_firstItem;
    UITabBarItem *_secondItem;
    UITabBarItem *_thirdItem;
    UITabBarItem *_fourthItem;
    UITabBarItem *_selectedItem;
}

@end

@implementation LWTabBarVC_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LWEventsVC_iPhone *eventsVC = [[LWEventsVC_iPhone alloc]init];
    LWBaseNavVC_iPhone *eventsNC = [[LWBaseNavVC_iPhone alloc]initWithRootViewController:eventsVC];
    
    LWCommunityVC_iPhone *communityVC = [[LWCommunityVC_iPhone alloc]init];
    LWBaseNavVC_iPhone *communityNC = [[LWBaseNavVC_iPhone alloc]initWithRootViewController:communityVC];
    
    LWScheduleVC_iPhone *scheduleVC = [[LWScheduleVC_iPhone alloc]init];
    LWBaseNavVC_iPhone *scheduleNC = [[LWBaseNavVC_iPhone alloc]initWithRootViewController:scheduleVC];
    
    LWMineVC_iPhone *mineVC = [[LWMineVC_iPhone alloc]init];
    LWBaseNavVC_iPhone *mineNC = [[LWBaseNavVC_iPhone alloc]initWithRootViewController:mineVC];
    
    self.viewControllers = @[eventsNC,communityNC,scheduleNC,mineNC];
    //    设置tabbar的字体颜色
    self.tabBar.tintColor = [UIColor blueColor];
    
//    UITabBarItem *item1 = [[UITabBarItem alloc]initWithTitle:@"赛事" image:[UIImage imageNamed:@"iconfont-xinwen(1).png"] tag:100];
//    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTitle:@"社区" image:[UIImage imageNamed:@"iconfont-yuedu(1).png"] tag:101];
//    UITabBarItem *item3 = [[UITabBarItem alloc]initWithTitle:@"赛程" image:[UIImage imageNamed:@"iconfont-bofang(1).png"] tag:102];
//     UITabBarItem *item4 = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"iconfont-bofang(1).png"] tag:103];
    
    _firstItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"tab_live_nor"] selectedImage:[UIImage imageNamed:@"tab_live_highlight"]];
    _secondItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"tab_live_nor"] selectedImage:[UIImage imageNamed:@"tab_live_highlight"]];
    _thirdItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"tab_live_nor"] selectedImage:[UIImage imageNamed:@"tab_live_highlight"]];
    _fourthItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"tab_live_nor"] selectedImage:[UIImage imageNamed:@"tab_live_highlight"]];

    

    eventsNC.tabBarItem = _firstItem;
    _selectedItem = _firstItem;
    communityNC.tabBarItem = _secondItem;
    scheduleNC.tabBarItem = _thirdItem;
    mineNC.tabBarItem = _fourthItem;
    
    //    统一设置背景
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundColor:[UIColor whiteColor]];
    self.tabBar.translucent = NO;

    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (item != _selectedItem) {
        _selectedItem = item;
        return;
    }
    if (item == _firstItem) {
        NSLog(@"点击了 _firstItem");
    }else if (item == _secondItem) {
        NSLog(@"点击了 _secondItem");

    }else if (item == _thirdItem) {
        NSLog(@"点击了 _thirdItem");

    }else if (item == _fourthItem) {
        NSLog(@"点击了 _fourthItem");

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
