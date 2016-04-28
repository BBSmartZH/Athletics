//
//  SCMatchCommentListVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/28.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCMatchCommentListVC.h"

#import "LWCommentListCell.h"

@interface SCMatchCommentListVC ()

@end

@implementation SCMatchCommentListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.m_navBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor clearColor];
    
    _tableView.frame = CGRectMake(0, 0, self.view.fWidth, self.view.fHeight - _topHeight);
    _tableView.separatorColor = k_Border_Color;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_tableView registerClass:[LWCommentListCell class] forCellReuseIdentifier:[LWCommentListCell cellidentifier]];
    
}

- (void)upDateData {
    [self refreshData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LWCommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:[LWCommentListCell cellidentifier] forIndexPath:indexPath];
    
    [cell createLayoutWith:@1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:[LWCommentListCell cellidentifier] cacheByIndexPath:indexPath configuration:^(LWCommentListCell *cell) {
        [cell createLayoutWith:@1];
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
