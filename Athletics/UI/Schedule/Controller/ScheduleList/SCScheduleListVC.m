//
//  SCScheduleListVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCScheduleListVC.h"

#import "SCScheduleListCell.h"

#import "SCScheduleDetailVC.h"
#import "SCMatchListModel.h"

@interface SCScheduleListVC ()<SCScheduleListCellDelegate>
{
    SCMatchListModel *_model;
}
@end

@implementation SCScheduleListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _liveTitle;
    
    [_tableView registerClass:[SCScheduleListCell class] forCellReuseIdentifier:[SCScheduleListCell cellIdentifier]];

    _tableView.frame = CGRectMake(0, self.m_navBar.bottom, self.view.fWidth, self.view.fHeight - self.m_navBar.fHeight);
    
    _tableView.separatorColor = k_Border_Color;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self headerBeginRefreshing];
}

-(void)refreshData
{
    self.sessionTask = [SCNetwork matchCourseListWithMatchId:_matchId page:_currentPageIndex success:^(SCMatchListModel *model){
        [self headerEndRefreshing];
        
        [_datasource removeAllObjects];
        [_datasource addObjectsFromArray:model.data];
        [_tableView reloadData];
        
        if (_currentPageIndex < [SCGlobaUtil getInt:model.paging.total] / [SCGlobaUtil getInt:model.paging.size]) {
            _currentPageIndex ++;
            [self footerHidden:NO];
        }else {
            [self noticeNoMoreData];
        }
    } message:^(NSString *resultMsg) {
        [self headerEndRefreshing];
        [self postErrorMessage:resultMsg];
    }];
}

-(void)loadModeData
{
    self.sessionTask = [SCNetwork matchCourseListWithMatchId:_matchId page:_currentPageIndex success:^(SCMatchListModel *model) {
        
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _datasource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    SCMatchGroupListModel *model = [_datasource objectAtIndex:section];
    
    return model.matchUnit.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCScheduleListCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCScheduleListCell cellIdentifier] forIndexPath:indexPath];
    cell.delegate = self;
    SCMatchGroupListModel *model = [_datasource objectAtIndex:indexPath.section];
    SCMatchListDataModel *listModel = [model.matchUnit objectAtIndex:indexPath.row];
    
    [cell createLayoutWith:listModel];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SCMatchGroupListModel *model =[_datasource objectAtIndex:section];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.fWidth, 24)];
    view.backgroundColor = k_Bg_Color;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.fWidth, view.fHeight)];
    label.font = [UIFont systemFontOfSize:kWord_Font_24px];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kWord_Color_High;
    label.text = model.name;
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:[SCScheduleListCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SCScheduleListCell *cell) {
        
        SCMatchGroupListModel *model = [_datasource objectAtIndex:indexPath.section];
        SCMatchListDataModel *listModel = [model.matchUnit objectAtIndex:indexPath.row];
        
        [cell createLayoutWith:listModel];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 24.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCMatchGroupListModel *model = [_datasource objectAtIndex:indexPath.section];
    SCMatchListDataModel *listModel = [model.matchUnit objectAtIndex:indexPath.row];
    SCScheduleDetailVC *detailVC = [[SCScheduleDetailVC alloc]init];
    detailVC.matchUnitId = listModel.matchUnitId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)appointButtonClicked:(UIButton *)sender type:(SCMacthAppointType)type model:(SCMatchListDataModel *)model {
    int aType = 1;
    if (type == SCMacthAppointTypeCancel) {
        aType = 2;
    }
    sender.enabled = NO;
    [SCNetwork matchAppointmentAddWithMatchUnitId:model.matchUnitId type:type success:^(SCResponseModel *aModel) {
        sender.enabled = YES;
        NSString *message = @"预约成功";
        sender.selected = YES;
        model.appoint = @"1";
        if (aType == 2) {
            message = @"取消预约成功";
            sender.selected = NO;
            model.appoint = @"0";
        }
        [self postMessage:message];
    } message:^(NSString *resultMsg) {
        sender.enabled = YES;
        [self postMessage:resultMsg];
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
