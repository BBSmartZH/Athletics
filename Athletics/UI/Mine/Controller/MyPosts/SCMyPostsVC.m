//
//  SCMyPostsVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/28.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCMyPostsVC.h"
#import "SCCommunityListModel.h"
#import "SCPostsTextCell.h"
#import "SCPostsImageCell.h"

#import "SCPostsDetailVC.h"

@interface SCMyPostsVC ()

@end

@implementation SCMyPostsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的帖子";
    
    [_tableView registerClass:[SCPostsTextCell class] forCellReuseIdentifier:[SCPostsTextCell cellIdentifier]];
    [_tableView registerClass:[SCPostsImageCell class] forCellReuseIdentifier:[SCPostsImageCell cellIdentifier]];
    
    _tableView.frame = CGRectMake(0, self.m_navBar.bottom, self.view.fWidth, self.view.fHeight - self.m_navBar.fHeight);
    _tableView.separatorColor = k_Border_Color;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self headerBeginRefreshing];
}

-(void)refreshData
{
    if (self.sessionTask.state == NSURLSessionTaskStateRunning) {
        [self.sessionTask cancel];
        self.sessionTask = nil;
    }
    self.sessionTask = [SCNetwork userTopicListWithPage:_currentPageIndex Success:^(SCCommunityListModel *model) {
        [self headerEndRefreshing];
        [_datasource removeAllObjects];
        [_datasource addObjectsFromArray:model.data];
        [_tableView reloadData];
        if (_currentPageIndex < [SCGlobaUtil getInt:model.paging.total]/[SCGlobaUtil getInt:model.paging.size]) {
            _currentPageIndex ++;
            [self headerHidden:NO];
        }else {
            [self noticeNoMoreData];
        }

    } message:^(NSString *resultMsg) {
        [self headerEndRefreshing];
        [self postErrorMessage:resultMsg];
    }];
}

-(void)loadModeData{
    if (self.sessionTask.state == NSURLSessionTaskStateRunning) {
        [self.sessionTask cancel];
        self.sessionTask = nil;
    }
    self.sessionTask = [SCNetwork userTopicListWithPage:_currentPageIndex Success:^(SCCommunityListModel *model) {
        [self footerEndRefreshing];
        [_datasource addObjectsFromArray:model.data];
        [_tableView reloadData];
        if (_currentPageIndex < [SCGlobaUtil getInt:model.paging.total]/[SCGlobaUtil getInt:model.paging.size]) {
            _currentPageIndex ++;
        }else {
            [self noticeNoMoreData];
        }

    } message:^(NSString *resultMsg) {
        [self footerEndRefreshing];
        [self postErrorMessage:resultMsg];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCCommunityListDataModel *model = [_datasource objectAtIndex:indexPath.row];
    if (model.images.count > 0) {
        SCPostsImageCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCPostsImageCell cellIdentifier] forIndexPath:indexPath];
        SCCommunityListDataModel *model = [_datasource objectAtIndex:indexPath.row];
        [cell createLayoutWith:model];
        return cell;
    }else {
        SCPostsTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCPostsTextCell cellIdentifier] forIndexPath:indexPath];
        SCCommunityListDataModel *model = [_datasource objectAtIndex:indexPath.row];
        [cell createLayoutWith:model];
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SCCommunityListDataModel *model = [_datasource objectAtIndex:indexPath.row];
    SCPostsDetailVC *detailVC = [[SCPostsDetailVC alloc] init];
    detailVC.topicId = model.tid;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SCCommunityListDataModel *model = [_datasource objectAtIndex:indexPath.row];
    
    if (model.images.count > 0) {
        return [tableView fd_heightForCellWithIdentifier:[SCPostsImageCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SCPostsImageCell *cell) {
            [cell createLayoutWith:model];
        }];
    }else {
        return [tableView fd_heightForCellWithIdentifier:[SCPostsTextCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SCPostsTextCell *cell) {
            [cell createLayoutWith:model];
        }];
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
