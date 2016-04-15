//
//  SCCommuntityContentVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCCommuntityContentVC.h"

#import "SCPostsTextCell.h"
#import "SCPostsImageCell.h"

#import "SCPostsDetailVC.h"

@interface SCCommuntityContentVC ()
{
    UIView *_selectedView;
    UIButton *_defaultButton;//默认
    UIButton *_essenceButton;//精华
    UIButton *_latestButton;//最新
    UIButton *_currentButton;
    UIView   *_slideLine;
}

@end

@implementation SCCommuntityContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.m_navBar.hidden = YES;
    
    _selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.fWidth, 44)];
    _selectedView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_selectedView];
    
    
    _defaultButton = [self topicTypeButtonWithTitle:@"默认"];
    _defaultButton.frame = CGRectMake(0, 0, _selectedView.fWidth / 3.0, _selectedView.fHeight);
    [_selectedView addSubview:_defaultButton];
    
    _essenceButton = [self topicTypeButtonWithTitle:@"精华"];
    _essenceButton.frame = CGRectMake(_defaultButton.right, 0, _defaultButton.fWidth, _defaultButton.fHeight);
    [_selectedView addSubview:_essenceButton];
    
    _latestButton = [self topicTypeButtonWithTitle:@"最新"];
    _latestButton.frame = CGRectMake(_essenceButton.right, 0, _essenceButton.fWidth, _essenceButton.fHeight);
    [_selectedView addSubview:_latestButton];
    
    
    UIView *selectedLine = [[UIView alloc] initWithFrame:CGRectMake(0, _selectedView.fHeight - 0.5, _selectedView.fWidth, 0.5)];
    selectedLine.backgroundColor = k_Border_Color;
    [_selectedView addSubview:selectedLine];
    
    _slideLine = [[UIView alloc] init];
    _slideLine.backgroundColor = k_Base_Color;
    [_selectedView addSubview:_slideLine];
    _slideLine.frame = CGRectMake(10,  _selectedView.fHeight - 2, _defaultButton.fWidth - 20, 2);
    
    
    [_tableView registerClass:[SCPostsTextCell class] forCellReuseIdentifier:[SCPostsTextCell cellIdentifier]];
    [_tableView registerClass:[SCPostsImageCell class] forCellReuseIdentifier:[SCPostsImageCell cellIdentifier]];
    
    _tableView.frame = CGRectMake(0, _selectedView.bottom, self.view.fWidth, self.view.fHeight - self.m_navBar.fHeight - _selectedView.fHeight - 49);
    _tableView.separatorColor = k_Border_Color;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    
    [_tableView reloadData];
    
}

- (UIButton *)topicTypeButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kWord_Color_High forState:UIControlStateNormal];
    [button setTitleColor:k_Base_Color forState:UIControlStateSelected];
    [button addTarget:self action:@selector(topicTypeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    
    return button;
}

- (void)topicTypeButtonClicked:(UIButton *)sender {
    if (sender.isSelected) {
        return;
    }
    
    _currentButton.selected = NO;
    _currentButton = sender;
    _currentButton.selected = YES;
    CGRect rect = CGRectZero;
    if (sender == _defaultButton) {
        rect = CGRectMake(_defaultButton.left + 10, _slideLine.top, _slideLine.fWidth, _slideLine.fHeight);
    }else if (sender == _essenceButton) {
        rect = CGRectMake(_essenceButton.left + 10, _slideLine.top, _slideLine.fWidth, _slideLine.fHeight);
    }else if (sender == _latestButton) {
        rect = CGRectMake(_latestButton.left + 10, _slideLine.top, _slideLine.fWidth, _slideLine.fHeight);
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _slideLine.frame = rect;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSNumber *number = @0;
    if (indexPath.row % 4 == 0) {
        number = @0;
    }else if (indexPath.row % 4 == 1) {
        number = @1;
    }else if (indexPath.row % 4 == 2) {
        number = @2;
    }else {
        number = @3;
    }
    
    if (number.integerValue > 0) {
        SCPostsImageCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCPostsImageCell cellIdentifier] forIndexPath:indexPath];
        [cell createLayoutWith:number];
        return cell;
    }else {
        SCPostsTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCPostsTextCell cellIdentifier] forIndexPath:indexPath];
        [cell createLayoutWith:number];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SCPostsDetailVC *detailVC = [[SCPostsDetailVC alloc] init];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.parentVC.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSNumber *number = @0;
    if (indexPath.row % 4 == 0) {
        number = @0;
    }else if (indexPath.row % 4 == 1) {
        number = @1;
    }else if (indexPath.row % 4 == 2) {
        number = @2;
    }else {
        number = @3;
    }
    
    if (number.integerValue > 0) {
        return [tableView fd_heightForCellWithIdentifier:[SCPostsImageCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SCPostsImageCell *cell) {
            [cell createLayoutWith:number];
        }];
    }else {
        return [tableView fd_heightForCellWithIdentifier:[SCPostsTextCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SCPostsTextCell *cell) {
            [cell createLayoutWith:number];
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
