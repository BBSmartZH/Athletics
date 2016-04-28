//
//  SCVideoContentVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCVideoContentVC.h"

#import "SCVideoCell.h"
#import "SCVideoDetailVC.h"
#import "SCVideoListModel.h"

@interface SCVideoContentVC ()
{
    UIView *_selectedView;
    UIButton *_matchButton;//赛事
    UIButton *_newsButton;//资讯
    UIButton *_amusementButton;//娱乐
    UIButton *_currentButton;
    UIView   *_slideLine;
    BOOL _needUpdate;
}

@end

@implementation SCVideoContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.m_navBar.hidden = YES;
    
    _needUpdate = YES;

    
    _selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.fWidth, 44)];
    _selectedView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_selectedView];
    
    
    _matchButton = [self videoTypeButtonWithTitle:@"赛事"];
    _matchButton.frame = CGRectMake(0, 0, _selectedView.fWidth / 3.0, _selectedView.fHeight);
    [_selectedView addSubview:_matchButton];
    
    _newsButton = [self videoTypeButtonWithTitle:@"资讯"];
    _newsButton.frame = CGRectMake(_matchButton.right, 0, _matchButton.fWidth, _matchButton.fHeight);
    [_selectedView addSubview:_newsButton];
    
    _amusementButton = [self videoTypeButtonWithTitle:@"娱乐"];
    _amusementButton.frame = CGRectMake(_newsButton.right, 0, _newsButton.fWidth, _newsButton.fHeight);
    [_selectedView addSubview:_amusementButton];
    
    
    UIView *selectedLine = [[UIView alloc] initWithFrame:CGRectMake(0, _selectedView.fHeight - 0.5, _selectedView.fWidth, 0.5)];
    selectedLine.backgroundColor = k_Border_Color;
    [_selectedView addSubview:selectedLine];
    
    _slideLine = [[UIView alloc] init];
    _slideLine.backgroundColor = k_Base_Color;
    [_selectedView addSubview:_slideLine];
    _slideLine.frame = CGRectMake(10,  _selectedView.fHeight - 2, _matchButton.fWidth - 20, 2);
    
    
    [_tableView registerClass:[SCVideoCell class] forCellReuseIdentifier:[SCVideoCell cellIdentifier]];
    
    _tableView.frame = CGRectMake(0, _selectedView.bottom, self.view.fWidth, self.view.fHeight - self.m_navBar.fHeight - _selectedView.fHeight - 49);
    _tableView.separatorColor = k_Border_Color;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    
    
}

- (BOOL)isUpdated {
    return !_needUpdate;
}

- (void)updateData {
    [self headerBeginRefreshing];

}

- (void)refreshData {
    _needUpdate = NO;
    
    
    self.sessionTask = [SCNetwork matchVideoListWithChannelId:@"" type:0 page:_currentPageIndex success:^(SCVideoListModel *model) {
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
    self.sessionTask = [SCNetwork matchVideoListWithChannelId:@"" type:0 page:_currentPageIndex success:^(SCVideoListModel *model) {
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

- (UIButton *)videoTypeButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kWord_Color_High forState:UIControlStateNormal];
    [button setTitleColor:k_Base_Color forState:UIControlStateSelected];
    [button addTarget:self action:@selector(videoTypeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_32px];
    
    return button;
}

- (void)videoTypeButtonClicked:(UIButton *)sender {
    if (sender.isSelected) {
        return;
    }
    
    _currentButton.selected = NO;
    _currentButton = sender;
    _currentButton.selected = YES;
    CGRect rect = CGRectZero;
    if (sender == _matchButton) {
        rect = CGRectMake(_matchButton.left + 10, _slideLine.top, _slideLine.fWidth, _slideLine.fHeight);
    }else if (sender == _newsButton) {
        rect = CGRectMake(_newsButton.left + 10, _slideLine.top, _slideLine.fWidth, _slideLine.fHeight);
    }else if (sender == _amusementButton) {
        rect = CGRectMake(_amusementButton.left + 10, _slideLine.top, _slideLine.fWidth, _slideLine.fHeight);
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _slideLine.frame = rect;
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCVideoListDataModel *model = [_datasource objectAtIndex:indexPath.row];
    SCVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCVideoCell cellIdentifier] forIndexPath:indexPath];
    [cell createLayoutWith:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SCVideoDetailVC *detailVC = [[SCVideoDetailVC alloc] init];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.parentVC.navigationController pushViewController:detailVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCVideoListDataModel *model = [_datasource objectAtIndex:indexPath.row];

    return [tableView fd_heightForCellWithIdentifier:[SCVideoCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SCVideoCell *cell) {
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
