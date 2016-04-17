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


#import "SCNewsVC.h"//资讯
#import "LWCommunityVC_iPhone.h"//论坛
#import "LWScheduleVC_iPhone.h"//赛事
#import "SCVideoVC.h"//视频
#import "LWMineVC_iPhone.h"//我的

@interface LWTabBarVC_iPhone ()
{
    UITabBarItem *_firstItem;
    UITabBarItem *_secondItem;
    UITabBarItem *_thirdItem;
    UITabBarItem *_fourthItem;
    UITabBarItem *_fifthItem;
    UITabBarItem *_selectedItem;
    
    LWBaseNavVC_iPhone  *_currentNav;
}

@end

@implementation LWTabBarVC_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    LWEventsVC_iPhone *eventsVC = [[LWEventsVC_iPhone alloc]init];
//    LWBaseNavVC_iPhone *eventsNC = [[LWBaseNavVC_iPhone alloc]initWithRootViewController:eventsVC];
    
    SCNewsVC *newsVC = [[SCNewsVC alloc]init];
    LWBaseNavVC_iPhone *newsNC = [[LWBaseNavVC_iPhone alloc]initWithRootViewController:newsVC];
    
    LWCommunityVC_iPhone *communityVC = [[LWCommunityVC_iPhone alloc]init];
    LWBaseNavVC_iPhone *communityNC = [[LWBaseNavVC_iPhone alloc]initWithRootViewController:communityVC];
    
    LWScheduleVC_iPhone *scheduleVC = [[LWScheduleVC_iPhone alloc]init];
    LWBaseNavVC_iPhone *scheduleNC = [[LWBaseNavVC_iPhone alloc]initWithRootViewController:scheduleVC];
    
    SCVideoVC *videoVC = [[SCVideoVC alloc]init];
    LWBaseNavVC_iPhone *videoNC = [[LWBaseNavVC_iPhone alloc]initWithRootViewController:videoVC];
    
    LWMineVC_iPhone *mineVC = [[LWMineVC_iPhone alloc]init];
    LWBaseNavVC_iPhone *mineNC = [[LWBaseNavVC_iPhone alloc]initWithRootViewController:mineVC];
    
    self.viewControllers = @[newsNC,communityNC,scheduleNC, videoNC,mineNC];
    //    设置tabbar的字体颜色
    self.tabBar.tintColor = [UIColor blueColor];
    
//    UITabBarItem *item1 = [[UITabBarItem alloc]initWithTitle:@"赛事" image:[UIImage imageNamed:@"iconfont-xinwen(1).png"] tag:100];
//    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTitle:@"社区" image:[UIImage imageNamed:@"iconfont-yuedu(1).png"] tag:101];
//    UITabBarItem *item3 = [[UITabBarItem alloc]initWithTitle:@"赛程" image:[UIImage imageNamed:@"iconfont-bofang(1).png"] tag:102];
//     UITabBarItem *item4 = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"iconfont-bofang(1).png"] tag:103];
    
    _firstItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"tab_news_nor"] selectedImage:[UIImage imageNamed:@"tab_news_highlight"]];
    _secondItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"tab_community_nor"] selectedImage:[UIImage imageNamed:@"tab_community_highlight"]];
    _thirdItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"tab_live_nor"] selectedImage:[UIImage imageNamed:@"tab_live_highlight"]];
    _fourthItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"tab_schedule_nor"] selectedImage:[UIImage imageNamed:@"tab_schedule_highlight"]];
    _fifthItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"tab_me_nor"] selectedImage:[UIImage imageNamed:@"tab_me_highlight"]];

    

    newsNC.tabBarItem = _firstItem;
    _selectedItem = _firstItem;
    _currentNav = newsNC;
    communityNC.tabBarItem = _secondItem;
    scheduleNC.tabBarItem = _thirdItem;
    videoNC.tabBarItem = _fourthItem;
    mineNC.tabBarItem = _fifthItem;
    
    //统一设置背景
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundColor:[UIColor whiteColor]];
    self.tabBar.translucent = NO;

    
}

- (BOOL)shouldAutorotate{
    return self.selectedViewController.shouldAutorotate;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    if (item == _firstItem) {
        _currentNav = [self.viewControllers objectAtIndex:0];
    }else if (item == _secondItem) {
        _currentNav = [self.viewControllers objectAtIndex:1];
    }else if (item == _thirdItem) {
        _currentNav = [self.viewControllers objectAtIndex:2];
    }else if (item == _fourthItem) {
        _currentNav = [self.viewControllers objectAtIndex:3];
    }else if (item == _fifthItem) {
        _currentNav = [self.viewControllers objectAtIndex:4];
    }
    
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
        
    }else if (item == _fifthItem) {
        NSLog(@"点击了 _fifthItem");
        
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
