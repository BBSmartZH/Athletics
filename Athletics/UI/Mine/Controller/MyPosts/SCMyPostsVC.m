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
}

-(void)refreshData
{
    self.sessionTask = [SCNetwork ]
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
    
    number = @1;
    
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
    [self.navigationController pushViewController:detailVC animated:YES];
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
    number = @1;
    
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
