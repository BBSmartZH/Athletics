//
//  SCNewsContentVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNewsContentVC.h"

#import "SCAdView.h"
#import "SCNewsCell.h"
#import "LWPhotosNormalCell.h"
#import "SCNewsPhotosPackVC.h"
#import "SCNewsArticlePackVC.h"

#import "SCNewsListModel.h"

@interface SCNewsContentVC ()
{
    SCAdView *_adView;
    BOOL _needUpdate;
}

@end

@implementation SCNewsContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.m_navBar.hidden = YES;
    
    _needUpdate = YES;
    
    [_tableView registerClass:[SCNewsCell class] forCellReuseIdentifier:[SCNewsCell cellIdentifier]];
    [_tableView registerClass:[LWPhotosNormalCell class] forCellReuseIdentifier:[LWPhotosNormalCell cellIdentifier]];

    _tableView.frame = CGRectMake(0, 0, self.view.fWidth, self.view.fHeight - self.m_navBar.fHeight - 49);
    _tableView.separatorColor = k_Border_Color;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    _adView = [[SCAdView alloc] initWithFrame:CGRectMake(0, 0, _tableView.fWidth, _tableView.fWidth * 0.4)];
    _adView.placeHoldImage = [UIImage imageNamed:@"place"];
    _adView.pageControlShowStyle = SCPageControlShowStyleRight;
    _adView.adTitleStyle = SCAdTitleShowStyleLeft;
    _adView.tapAdCallBack = ^(NSInteger index) {
        NSLog(@"%ld", (long)index);
    };
    _tableView.tableHeaderView = _adView;
    
    NSArray *imagesURL = @[
                           @"http://img.dota2.com.cn/dota2/38/5b/385bdfec72352d362c86ae46d95e0dca1461307283.jpg",
                           @"http://img.dota2.com.cn/dota2/de/fc/defc5969e325b72d5fb155a5a75370ec1461307258.jpg",
                           @"http://www.dota2.com.cn/resources/jpg/150205/10251423116795949.jpg"
                           ];
    
    NSArray *titles = @[@"Empire.Ramzes专访",
                        @"ESL ONE马尼拉前瞻",
                        @"意见反馈",
                        ];
    
    _adView.adTitleArray = titles;
    _adView.imageLinkURL = imagesURL;
    
    
}

- (BOOL)isUpdated {
    return !_needUpdate;
}

- (void)updateData {
    [self headerBeginRefreshing];
    
}

- (void)refreshData {
    _needUpdate = NO;
    
    self.sessionTask = [SCNetwork newsListWithChannelId:_channelId page:_currentPageIndex success:^(SCNewsListModel *model) {
        [self headerEndRefreshing];
        
        [_datasource removeAllObjects];
        [_datasource addObjectsFromArray:model.data];
        [_tableView reloadData];
        
        if (_currentPageIndex < [SCGlobaUtil getFloat:model.paging.total] / [SCGlobaUtil getInt:model.paging.size]) {
            _currentPageIndex++;
            [self footerHidden:NO];
        }
        
    } message:^(NSString *resultMsg) {
        [self headerEndRefreshing];
        [self postMessage:resultMsg];
    }];
    
    
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self headerEndRefreshing];
//        
//        [_tableView reloadData];
//
//        _needUpdate = YES;
//    });
}

- (void)loadModeData {
    self.sessionTask = [SCNetwork newsListWithChannelId:@"" page:_currentPageIndex success:^(SCNewsListModel *model) {
        [self footerEndRefreshing];
        
        [_datasource addObjectsFromArray:model.data];
        [_tableView reloadData];
        
        if (_currentPageIndex < [SCGlobaUtil getFloat:model.paging.total] / [SCGlobaUtil getInt:model.paging.size]) {
            _currentPageIndex++;
        }
        
    } message:^(NSString *resultMsg) {
        [self footerEndRefreshing];
        [self postMessage:resultMsg];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCNewsListDataModel *model = [_datasource objectAtIndex:indexPath.row];
    
    if ([SCGlobaUtil getInt:model.type] == 3) {
        LWPhotosNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:[LWPhotosNormalCell cellIdentifier] forIndexPath:indexPath];
        [cell createLayoutWith:model];
        return cell;
    }
    
    SCNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCNewsCell cellIdentifier] forIndexPath:indexPath];
    [cell createLayoutWith:model];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCNewsListDataModel *model = [_datasource objectAtIndex:indexPath.row];
    
    if ([SCGlobaUtil getInt:model.type] == 3) {

//        return [LWPhotosNormalCell heightForRowWithPhotosWithCounts:(int)(model.images.count)];
        return [LWPhotosNormalCell heightForRowWithPhotosWithCounts:2];
    }
    
    return [tableView fd_heightForCellWithIdentifier:[SCNewsCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SCNewsCell *cell) {
        [cell createLayoutWith:model];
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row % 2 == 0) {
        SCNewsArticlePackVC *articleVC = [[SCNewsArticlePackVC alloc] init];
        articleVC.hidesBottomBarWhenPushed = YES;
        [self.parentVC.navigationController pushViewController:articleVC animated:YES];
    }else {
        SCNewsPhotosPackVC *photosVC = [[SCNewsPhotosPackVC alloc] init];
        photosVC.hidesBottomBarWhenPushed = YES;
        [self.parentVC.navigationController pushViewController:photosVC animated:YES];
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
