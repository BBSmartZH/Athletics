//
//  SCCommentListVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/16.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCCommentListVC.h"

#import "LWCommentListCell.h"
#import "SCNewsCommentListModel.h"

@interface SCCommentListVC ()
{
    UIView *_inputView;
    
    //Test
    UIButton *_commentButton;
}

@end

@implementation SCCommentListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.m_navBar.hidden = YES;
    self.title = @"评论";
    
    _inputView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.fHeight - 44, self.view.fWidth, 44)];
    _inputView.backgroundColor = [UIColor cyanColor];
    _inputView.layer.borderWidth = .5f;
    _inputView.layer.borderColor = k_Border_Color.CGColor;
    [self.view addSubview:_inputView];
    
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentButton.backgroundColor = [UIColor redColor];
    [_commentButton setTitle:@"原文" forState:UIControlStateNormal];
    _commentButton.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    _commentButton.frame = CGRectMake(_inputView.fWidth - 10 - 60, 7, 60, 30);
    [_commentButton addTarget:self action:@selector(commentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_inputView addSubview:_commentButton];
    
    [_tableView registerClass:[LWCommentListCell class] forCellReuseIdentifier:[LWCommentListCell cellidentifier]];
    _tableView.frame = CGRectMake(0, 0, self.view.fWidth, self.view.fHeight - _inputView.fHeight);
    _tableView.separatorColor = k_Border_Color;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    
}

- (void)commentButtonClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshData {
    
    
    self.sessionTask = [SCNetwork newsCommentListWithNewsId:@"" page:_currentPageIndex success:^(SCNewsCommentListModel *model) {
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
    
}

- (void)loadModeData {
    self.sessionTask = [SCNetwork newsCommentListWithNewsId:@"" page:_currentPageIndex success:^(SCNewsCommentListModel *model) {
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
    
    SCNewsCommentListDataModel *model = [_datasource objectAtIndex:indexPath.row];
    
    LWCommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:[LWCommentListCell cellidentifier] forIndexPath:indexPath];
    
    [cell createLayoutWith:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCNewsCommentListDataModel *model = [_datasource objectAtIndex:indexPath.row];

    return [tableView fd_heightForCellWithIdentifier:[LWCommentListCell cellidentifier] cacheByIndexPath:indexPath configuration:^(LWCommentListCell *cell) {
        [cell createLayoutWith:model];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
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
