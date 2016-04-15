//
//  SCPostsDetailVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/15.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCPostsDetailVC.h"


#import "SCPostsTextImageCell.h"
#import "SCPostsTopView.h"
#import "SCPostsAdCell.h"

@interface SCPostsDetailVC ()<SCPostsTopViewDelegate>
{
    UILabel *_testLabel;
    SCPostsTopView *_headerView;
    UIView *view;
}

@end

@implementation SCPostsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"帖子详情";
    
    [_tableView registerClass:[SCPostsTextImageCell class] forCellReuseIdentifier:[SCPostsTextImageCell cellIdentifier]];
    [_tableView registerClass:[SCPostsAdCell class] forCellReuseIdentifier:[SCPostsAdCell cellIdentifier]];
    
    _tableView.frame = CGRectMake(0, self.m_navBar.bottom, self.view.fWidth, self.view.fHeight - self.m_navBar.fHeight);
    _headerView = [[SCPostsTopView alloc] initWithFrame:CGRectMake(0, 0, _tableView.fWidth, 0)];
    _headerView.delegate = self;
    [_headerView setModel:@1];
    _headerView.frame = CGRectMake(0, 0, _headerView.fWidth, [_headerView topViewHeight]);
    _tableView.tableHeaderView = _headerView;
    
    
    
    
}

- (void)postsTopViewHeightChanged {
    
    [UIView animateWithDuration:0.25 animations:^{
        _headerView.frame = CGRectMake(_headerView.left, _headerView.top, _headerView.fWidth, [_headerView topViewHeight]);
    }];

    [_tableView beginUpdates];
    [_tableView setTableHeaderView:_headerView];
    [_tableView endUpdates];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < 10) {
        SCPostsTextImageCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCPostsTextImageCell cellIdentifier] forIndexPath:indexPath];
        if (indexPath.row % 2 == 0) {
            [cell createLayoutWith:@1];
            
        }else {
            [cell createLayoutWith:@2];
            
        }
        return cell;
    }
    SCPostsAdCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCPostsAdCell cellIdentifier] forIndexPath:indexPath];
    if (indexPath.row % 2 == 0) {
        [cell createLayoutWith:@1];
        
    }else {
        [cell createLayoutWith:@2];
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 10) {
        NSNumber *model;
        if (indexPath.row % 2 == 0) {
            model = @1;
        }else {
            model = @2;
        }
        return [SCPostsTextImageCell cellHeightWith:model];
    }
    
    NSNumber *model;
    if (indexPath.row % 2 == 0) {
        model = @1;
    }else {
        model = @2;
    }
    return [SCPostsAdCell cellHeightWith:model];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)postsTopCellClickedShowModeWith:(NSIndexPath *)indexPath {
    if (indexPath) {
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
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
