//
//  SCBaseRefreshVC_iPhone.h
//  Athletics
//
//  Created by 李宛 on 16/4/9.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWBaseTableVC_iPhone.h"
#import "MJRefresh.h"

@interface SCBaseRefreshVC_iPhone : LWBaseTableVC_iPhone
{
    int _currentPageIndex;
    int _totalPages;
}

/**
 *  header开始刷新
 */
- (void)headerBeginRefreshing;

/**
 *  header停止刷新
 */
- (void)headerEndRefreshing;
/**
 *  footer停止刷新
 */
- (void)footerEndRefreshing;

/**
 *  隐藏header
 */
- (void)headerHidden:(BOOL)hidden;
/**
 *  隐藏footer
 */
- (void)footerHidden:(BOOL)hidden;
/**
 *  header正在刷新
 */
- (BOOL)headerIsRefreshing;
/**
 *  footer正在加载
 */
- (BOOL)footerIsRefreshing;
/**
 *  footer已加载全部
 */
- (void)noticeNoMoreData;/**
                          *  footer清除已加载全部
                          */
- (void)resetNoMoreData;

/**
 *  子类重写
 */
- (void)refreshData;

/**
 *  子类重写
 */
- (void)loadModeData;

@end
