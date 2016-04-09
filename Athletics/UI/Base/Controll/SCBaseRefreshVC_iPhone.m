//
//  SCBaseRefreshVC_iPhone.m
//  Athletics
//
//  Created by 李宛 on 16/4/9.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCBaseRefreshVC_iPhone.h"

@interface SCBaseRefreshVC_iPhone ()

@end

@implementation SCBaseRefreshVC_iPhone
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if ([self headerIsRefreshing]) {
        [self headerEndRefreshing];
    }
    if ([self footerIsRefreshing]) {
        [self footerEndRefreshing];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    MJRefreshNormalHeader *header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    //设置自动切换透明度（在导航栏下面自动隐藏）
    header.automaticallyChangeAlpha = YES;
    //隐藏刷新时间
    header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.mj_header = header;
    
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadModeData)];
    footer.automaticallyChangeAlpha = YES;
    // 禁止自动加载
    footer.automaticallyRefresh = YES;
    _tableView.mj_footer = footer;
    _tableView.mj_footer.hidden = YES;
    
}
/**
 *  header 开始刷新
 */

-(void)headerBeginRefreshing
{
    if ([self headerIsRefreshing]) {
        [self headerEndRefreshing];
    }
    if ([self footerIsRefreshing]) {
        [self footerEndRefreshing];
    }
    [_tableView.mj_header beginRefreshing];
}

/**
 *  header停止刷新
 */
-(void)headerEndRefreshing
{
    [_tableView.mj_header endRefreshing];
}
/**
 *  footer停止刷新
 */
-(void)footerEndRefreshing
{
    [_tableView.mj_footer endRefreshing];
}
/**
 *  隐藏header
 */
- (void)headerHidden:(BOOL)hidden {
    _tableView.mj_header.hidden = hidden;
}
/**
 *  隐藏footer
 */
- (void)footerHidden:(BOOL)hidden {
    _tableView.mj_footer.hidden = hidden;
}
/**
 *  header正在刷新
 */
- (BOOL)headerIsRefreshing {
    return _tableView.mj_header.isRefreshing;
}
/**
 *  footer正在加载
 */
- (BOOL)footerIsRefreshing {
    return _tableView.mj_footer.isRefreshing;
}


/**
 *  footer已加载全部
 */
- (void)noticeNoMoreData {
    if ([self headerIsRefreshing]) {
        [self headerEndRefreshing];
    }
    if ([self footerIsRefreshing]) {
        [self footerEndRefreshing];
    }
    [self footerHidden:NO];
    _tableView.mj_footer.alpha = 1.0;
    [_tableView.mj_footer endRefreshingWithNoMoreData];
}
/**
 *  footer清除已加载全部
 */
- (void)resetNoMoreData {
    [_tableView.mj_footer resetNoMoreData];
}

/**
 *  子类重写
 */
- (void)refreshData {
    if ([self footerIsRefreshing]) {
        [self footerEndRefreshing];
    }
    [self resetNoMoreData];
    [self footerHidden:YES];
    _currentPageIndex = 1;
}

/**
 *  子类重写
 */
- (void)loadModeData {
    if ([self headerIsRefreshing]) {
        [self headerEndRefreshing];
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
