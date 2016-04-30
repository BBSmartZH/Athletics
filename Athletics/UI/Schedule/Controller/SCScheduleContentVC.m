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
    
}

- (SCAdView *)adView {
    if (!_adView) {
        _titleArray = [NSMutableArray array];
        _imageUrlArray = [NSMutableArray array];

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
    
//    NSArray *imagesURL = @[
//                           @"http://img.dota2.com.cn/dota2/38/5b/385bdfec72352d362c86ae46d95e0dca1461307283.jpg",
//                           @"http://img.dota2.com.cn/dota2/de/fc/defc5969e325b72d5fb155a5a75370ec1461307258.jpg",
//                           @"http://www.dota2.com.cn/resources/jpg/150205/10251423116795949.jpg"
//                           ];
//    
//    NSArray *titles = @[@"Empire.Ramzes专访",
//                        @"ESL ONE马尼拉前瞻",
//                        @"意见反馈",
//                        ];

    
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
    [self getMatchBanner];
    
    _needUpdate = NO;
    
    self.sessionTask = [SCNetwork matchLiveListWithChannelId:@"1" page:_currentPageIndex success:^(SCMatchLiveListModel *model) {
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
    
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self headerEndRefreshing];
        [_tableView reloadData];

        _needUpdate = YES;
    });
}

- (void)loadModeData {
    self.sessionTask = [SCNetwork matchLiveListWithChannelId:@"" page:_currentPageIndex success:^(SCMatchLiveListModel *model) {
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _datasource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCMatchLiveListDataModel *model = [_datasource objectAtIndex:indexPath.row];
    
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
    
    SCScheduleListVC *listVC = [[SCScheduleListVC alloc] init];
    listVC.hidesBottomBarWhenPushed = YES;
    [self.parentVC.navigationController pushViewController:listVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCMatchLiveListDataModel *model = [_datasource objectAtIndex:indexPath.row];

    return [tableView fd_heightForCellWithIdentifier:[SCScheduleCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SCScheduleCell *cell) {
        [cell createLayoutWith:model];
    }];
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
