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
#import "SCNewsBannerListModel.h"

@interface SCNewsContentVC ()
{
    BOOL _needUpdate;
    SCNewsBannerListModel *_bannerModel;
    NSMutableArray *_titleArray;
    NSMutableArray *_imageUrlArray;
}

@property (nonatomic, strong) SCAdView *adView;

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
    
    _imageUrlArray = [NSMutableArray array];
    _titleArray = [NSMutableArray array];
}

- (SCAdView *)adView {
    if (!_adView) {
        _adView = [[SCAdView alloc] initWithFrame:CGRectMake(0, 0, _tableView.fWidth, _tableView.fWidth * 0.4)];
        _adView.placeHoldImage = [UIImage imageNamed:@"place"];
        _adView.pageControlShowStyle = SCPageControlShowStyleRight;
        _adView.adTitleStyle = SCAdTitleShowStyleLeft;
        _adView.tapAdCallBack = ^(NSInteger index) {
            NSLog(@"%ld", (long)index);
        };
        _tableView.tableHeaderView = _adView;
    }
    return _adView;
}

- (void)getMatchBanner {
    
    [SCNetwork newsBannerListWithChannelId:_channelId type:1 success:^(SCNewsBannerListModel *model) {
        _bannerModel = model;
        
        [_imageUrlArray removeAllObjects];
        [_titleArray removeAllObjects];
        
        for (int i = 0; i < _bannerModel.data.count; i++) {
            SCNewsBannerListDataModel *dataModel = [_bannerModel.data objectAtIndex:i];
            [_imageUrlArray addObject:dataModel.imgUrl];
            [_titleArray addObject:dataModel.title];
        }
        if (_imageUrlArray.count > 0) {
            self.adView.imageLinkURL = _imageUrlArray;
            self.adView.adTitleArray = _titleArray;
            _tableView.tableHeaderView = self.adView;
        }else {
            _tableView.tableHeaderView = nil;
        }
    } message:^(NSString *resultMsg) {
        [self postMessage:resultMsg];
    }];
}

- (BOOL)isUpdated {
    return !_needUpdate;
}

- (void)updateData {
    [self headerBeginRefreshing];
    
}

- (void)refreshData {
    [self getMatchBanner];
    
    self.sessionTask = [SCNetwork newsListWithChannelId:_channelId page:_currentPageIndex success:^(SCNewsListModel *model) {
        [self headerEndRefreshing];
        _needUpdate = NO;

        [_datasource removeAllObjects];
        [_datasource addObjectsFromArray:model.data];
        [_tableView reloadData];
        
        if (_currentPageIndex < [SCGlobaUtil getInt:model.paging.total] / [SCGlobaUtil getInt:model.paging.size]) {
            _currentPageIndex++;
            [self footerHidden:NO];
        }else {
            [self noticeNoMoreData];
        }
        
    } message:^(NSString *resultMsg) {
        [self headerEndRefreshing];
        [self postMessage:resultMsg];
    }];
}

- (void)loadModeData {
    self.sessionTask = [SCNetwork newsListWithChannelId:_channelId page:_currentPageIndex success:^(SCNewsListModel *model) {
        [self footerEndRefreshing];
        
        [_datasource addObjectsFromArray:model.data];
        [_tableView reloadData];
        
        if (_currentPageIndex < [SCGlobaUtil getInt:model.paging.total] / [SCGlobaUtil getInt:model.paging.size]) {
            _currentPageIndex++;
        }else {
            [self noticeNoMoreData];
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
        if (model.images.count > 0) {
            LWPhotosNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:[LWPhotosNormalCell cellIdentifier] forIndexPath:indexPath];
            [cell createLayoutWith:model];
            return cell;
        }
    }
    
    SCNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCNewsCell cellIdentifier] forIndexPath:indexPath];
    [cell createLayoutWith:model];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCNewsListDataModel *model = [_datasource objectAtIndex:indexPath.row];
    
    if ([SCGlobaUtil getInt:model.type] == 3) {
        if (model.images.count > 0) {
            return [LWPhotosNormalCell heightForRowWithPhotosWithCounts:(int)model.images.count];
        }
    }
    
    return [tableView fd_heightForCellWithIdentifier:[SCNewsCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SCNewsCell *cell) {
        [cell createLayoutWith:model];
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SCNewsListDataModel *model = [_datasource objectAtIndex:indexPath.row];

    if ([SCGlobaUtil getInt:model.type] == 3 && model.images.count > 0) {
        SCNewsPhotosPackVC *photosVC = [[SCNewsPhotosPackVC alloc] init];
        photosVC.newsId = model.newsId;
        photosVC.hidesBottomBarWhenPushed = YES;
        [self.parentVC.navigationController pushViewController:photosVC animated:YES];
    }else {
        SCNewsArticlePackVC *articleVC = [[SCNewsArticlePackVC alloc] init];
        articleVC.newsId = model.newsId;
        articleVC.hidesBottomBarWhenPushed = YES;
        [self.parentVC.navigationController pushViewController:articleVC animated:YES];
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
