//
//  SCScheduleListVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCScheduleListVC.h"

#import "SCScheduleListCell.h"

@interface SCScheduleListVC ()

@end

@implementation SCScheduleListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"上海特锦赛";
    
    [_tableView registerClass:[SCScheduleListCell class] forCellReuseIdentifier:[SCScheduleListCell cellIdentifier]];

    _tableView.frame = CGRectMake(0, self.m_navBar.bottom, self.view.fWidth, self.view.fHeight - self.m_navBar.fHeight);
    
    _tableView.separatorColor = k_Border_Color;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if (section == 1) {
        return 4;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCScheduleListCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCScheduleListCell cellIdentifier] forIndexPath:indexPath];
    
    [cell createLayoutWith:@1];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.fWidth, 24)];
    view.backgroundColor = k_Bg_Color;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.fWidth, view.fHeight)];
    label.font = [UIFont systemFontOfSize:kWord_Font_24px];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kWord_Color_High;
    label.text = @"上海特锦赛 BO3   4月18日";
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:[SCScheduleListCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SCScheduleListCell *cell) {
        [cell createLayoutWith:@1];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 24.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
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
