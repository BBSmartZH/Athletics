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

@interface SCScheduleContentVC ()
{
    SCAdView *_adView;
}

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
    
    
    [_tableView registerClass:[SCScheduleCell class] forCellReuseIdentifier:[SCScheduleCell cellIdentifier]];
    
    _tableView.frame = CGRectMake(0, 0, self.view.fWidth, self.view.fHeight - self.m_navBar.fHeight - 49);
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    _adView = [[SCAdView alloc] initWithFrame:CGRectMake(0, 0, _tableView.fWidth, _tableView.fWidth * 0.4)];
    _adView.placeHoldImage = [UIImage imageNamed:@"place"];
    _adView.pageControlShowStyle = SCPageControlShowStyleRight;
    _adView.adTitleStyle = SCAdTitleShowStyleLeft;
    _adView.tapAdCallBack = ^(NSInteger index) {
        NSLog(@"%ld", (long)index);
    };
    _tableView.tableHeaderView = _adView;
    
    
    [_tableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCScheduleCell cellIdentifier] forIndexPath:indexPath];
    [cell createLayoutWith:@1];
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
    return [tableView fd_heightForCellWithIdentifier:[SCScheduleCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SCScheduleCell *cell) {
        [cell createLayoutWith:@1];
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
