//
//  SCScheduleContentVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCScheduleContentVC.h"

#import "SCAdView.h"
#import "SCScheduleCell.h"
#import "SCScheduleListVC.h"

#import "SCMatchLiveListModel.h"
#import "SCMatchBannerModel.h"
#import "SCBaseWebVC.h"

@interface SCScheduleContentVC ()
{
    BOOL _needUpdate;
    SCMatchBannerModel *_bannerModel;
    NSMutableArray *_titleArray;
    NSMutableArray *_imageUrlArray;
}

@property (nonatomic, strong) SCAdView *adView;


@end

@implementation SCScheduleContentVC

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.m_navBar.hidden = YES;
    
    _needUpdate = YES;
    
    [_tableView registerClass:[SCScheduleCell class] forCellReuseIdentifier:[SCScheduleCell cellIdentifier]];
    
    _tableView.frame = CGRectMake(0, 0, self.view.fWidth, self.view.fHeight - self.m_navBar.fHeight - 49);
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    _imageUrlArray = [NSMutableArray array];
    _titleArray = [NSMutableArray array];
    
    _listUpView = [self scroll2TopViewWithAction:@selector(upToTop)];
    
    _emptyView = [self emptyDatasourceDefaultViewWithText:@"暂无该类赛事活动"];
    [_tableView setBackgroundView:_emptyView];
}

- (void)upToTop {
    [_tableView setContentOffset:CGPointZero animated:YES];
}

- (SCAdView *)adView {
    if (!_adView) {
        _adView = [[SCAdView alloc] initWithFrame:CGRectMake(0, 0, _tableView.fWidth, _tableView.fWidth * 0.4)];
        _adView.placeHoldImage = [UIImage imageNamed:@"default_image"];
        _adView.pageControlShowStyle = SCPageControlShowStyleRight;
        _adView.adTitleStyle = SCAdTitleShowStyleLeft;
        
        _WEAKSELF(ws);
        _adView.tapAdCallBack = ^(NSInteger index) {
            [ws adViewClickedWith:index];
        };
        
        _tableView.tableHeaderView = _adView;
    }
    return _adView;
}

- (void)adViewClickedWith:(NSInteger)index {
    SCMatchBannerDataModel *model = [_bannerModel.data objectAtIndex:index];
    //url
    if (![SCGlobaUtil isEmpty:model.url]) {
        SCBaseWebVC *weVC = [[SCBaseWebVC alloc] init];
        weVC.webUrl = model.url;
        weVC.hidesBottomBarWhenPushed = YES;
        [self.parentVC.navigationController pushViewController:weVC animated:YES];
    }
}

- (void)getMatchBanner {
    
    [SCNetwork matchBannerWithSuccess:^(SCMatchBannerModel *model) {
        _bannerModel = model;
        
        [_imageUrlArray removeAllObjects];
        [_titleArray removeAllObjects];
        
        for (int i = 0; i < _bannerModel.data.count; i++) {
            SCMatchBannerDataModel *dataModel = [_bannerModel.data objectAtIndex:i];
            [_imageUrlArray addObject:dataModel.pic];
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
        
    }];
}

- (BOOL)isUpdated {
    return !_needUpdate;
}

- (void)updateData {
    [self headerBeginRefreshing];
}

- (void)refreshData {
    [super refreshData];
    
    [self getMatchBanner];

    if (self.sessionTask.state == NSURLSessionTaskStateRunning) {
        [self.sessionTask cancel];
        self.sessionTask = nil;
    }
    
    if (!_datasource.count) {
        _emptyView.hidden = NO;
    }else {
        _emptyView.hidden = YES;
    }
    
    self.sessionTask = [SCNetwork matchLiveListWithChannelId:_channelId page:_currentPageIndex success:^(SCMatchLiveListModel *model) {
        [self headerEndRefreshing];
        _needUpdate = NO;

        [_datasource removeAllObjects];
        [_datasource addObjectsFromArray:model.data];
        [_tableView reloadData];
        
        if (_currentPageIndex < [SCGlobaUtil getFloat:model.paging.total] / [SCGlobaUtil getInt:model.paging.size]) {
            _currentPageIndex++;
            [self footerHidden:NO];
        }else {
            [self noticeNoMoreData];
        }
        if (!_datasource.count) {
            _emptyView.hidden = NO;
        }else {
            _emptyView.hidden = YES;
        }
        
    } message:^(NSString *resultMsg) {
        [self headerEndRefreshing];
        [self postMessage:resultMsg];
    }];
}

- (void)loadModeData {
    [super loadModeData];
    
    if (self.sessionTask.state == NSURLSessionTaskStateRunning) {
        [self.sessionTask cancel];
        self.sessionTask = nil;
    }
    
    self.sessionTask = [SCNetwork matchLiveListWithChannelId:_channelId page:_currentPageIndex success:^(SCMatchLiveListModel *model) {
        [self footerEndRefreshing];
        
        [_datasource addObjectsFromArray:model.data];
        [_tableView reloadData];
        
        if (_currentPageIndex < [SCGlobaUtil getFloat:model.paging.total] / [SCGlobaUtil getInt:model.paging.size]) {
            _currentPageIndex++;
        }else {
            [self noticeNoMoreData];
        }
        
    } message:^(NSString *resultMsg) {
        [self footerEndRefreshing];
        [self postMessage:resultMsg];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _datasource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCMatchLiveListDataModel *model = [_datasource objectAtIndex:indexPath.section];
    
    SCScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCScheduleCell cellIdentifier] forIndexPath:indexPath];
    [cell createLayoutWith:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10.0f;
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SCMatchLiveListDataModel *model = [_datasource objectAtIndex:indexPath.section];
    SCScheduleListVC *listVC = [[SCScheduleListVC alloc] init];
    listVC.matchId =  model.matchId;
    listVC.liveTitle = model.title;
    listVC.hidesBottomBarWhenPushed = YES;
    [self.parentVC.navigationController pushViewController:listVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCMatchLiveListDataModel *model = [_datasource objectAtIndex:indexPath.section];

    return [tableView fd_heightForCellWithIdentifier:[SCScheduleCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SCScheduleCell *cell) {
        [cell createLayoutWith:model];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_tableView == scrollView) {
        if (scrollView.contentOffset.y >= 250) {
            [UIView animateWithDuration:0.25 animations:^{
                _listUpView.alpha = 1.0;
            }];
        }else {
            [UIView animateWithDuration:0.25 animations:^{
                _listUpView.alpha = 0.0;
            }];
        }
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
