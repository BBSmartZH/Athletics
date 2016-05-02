//
//  SCScheduleVideoListVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCScheduleVideoListVC.h"

#import "SCVideoListCell.h"
#import "SCScheduleVideoListModel.h"
#import "SCScheduleDetailVC.h"
#import "SCFullVideoPlayingVC.h"
#import "LWBaseNavVC_iPhone.h"

@interface SCScheduleVideoListVC ()<SCVideoListCellDelegate>
{
    BOOL _isUpdated;
}

@end

@implementation SCScheduleVideoListVC

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.m_navBar.hidden = YES;
    
    _tableView.frame = CGRectMake(0, 0, self.view.fWidth, self.view.fHeight - _topHeight);
    
    [_tableView registerClass:[SCVideoListCell class] forCellReuseIdentifier:[SCVideoListCell cellIdentifier]];
    
    [self.view bringSubviewToFront:self.m_navBar];
    
}

- (BOOL)isUpdated {
    return _isUpdated;
}

- (void)upDateData {
    [self headerBeginRefreshing];
}

- (void)refreshData {
    
    if (self.sessionTask.state == NSURLSessionTaskStateRunning) {
        [self.sessionTask cancel];
        self.sessionTask = nil;
    }
    
    self.sessionTask = [SCNetwork matchUnitvideoListWithMatchUnitId:_matchUnitId page:_currentPageIndex success:^(SCScheduleVideoListModel *model) {
        [self headerEndRefreshing];
        _isUpdated = YES;
        
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
    
    if (self.sessionTask.state == NSURLSessionTaskStateRunning) {
        [self.sessionTask cancel];
        self.sessionTask = nil;
    }
    
    self.sessionTask = [SCNetwork matchUnitvideoListWithMatchUnitId:_matchUnitId page:_currentPageIndex success:^(SCScheduleVideoListModel *model) {
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

- (void)videoButtonClicked:(UIButton *)sender inCell:(SCVideoListCell *)inCell withModel:(SCScheduleVideoListDataModel *)model {
    
    SCFullVideoPlayingVC *fullVC = [[SCFullVideoPlayingVC alloc] init];
    fullVC.videoTitle = model.title;
    fullVC.playUrl = model.url;
    LWBaseNavVC_iPhone *navVC = [[LWBaseNavVC_iPhone alloc] initWithRootViewController:fullVC];
    [self.parentVC.navigationController presentViewController:navVC animated:NO completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _datasource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCScheduleVideoListDataModel *model = [_datasource objectAtIndex:indexPath.section];
    
    SCVideoListCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCVideoListCell cellIdentifier] forIndexPath:indexPath];
    cell.delegate = self;
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
    
//    SCScheduleVideoListDataModel *model = [_datasource objectAtIndex:indexPath.section];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCScheduleVideoListDataModel *model = [_datasource objectAtIndex:indexPath.section];

    return [SCVideoListCell heightForCellWith:model];
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
