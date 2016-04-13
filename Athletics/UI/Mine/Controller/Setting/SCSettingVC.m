//
//  SCSettingVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCSettingVC.h"

#import "SCCommonCell.h"
#import "SCAboutVC.h"
#import "SCLoginVC.h"

@interface SCSettingVC ()

@end

static NSString *commonCellId = @"SCCommonCell";

@implementation SCSettingVC

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    
    _tableView.separatorColor = k_Border_Color;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_tableView registerClass:[SCCommonCell class] forCellReuseIdentifier:commonCellId];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:commonCellId forIndexPath:indexPath];
    
    cell.leftImage = nil;
    cell.leftLabel.text = @"";
    cell.rightLabel.text = @"";
    if (indexPath.section == 0) {
        if ([SCUserInfoManager isLogin]) {
            cell.leftLabel.text = @"账户";
            cell.rightLabel.text = @"昵称";
        }else {
            cell.leftLabel.text = @"账户";
            cell.rightLabel.text = @"点击登录";
        }
    }else if (indexPath.section == 1) {
        cell.leftLabel.text = @"清除缓存";
    }else {
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"意见反馈";
        }else if (indexPath.row == 1) {
            cell.leftLabel.text = @"用着不错，给个好评";
        }else {
            cell.leftLabel.text = @"关于";
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 15.0f;
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 15.0f;
    }
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if ([SCUserInfoManager isLogin]) {
            //退出登录？
            
        }else {
            //登录
            SCLoginVC *loginVC = [[SCLoginVC alloc] init];
            [loginVC loginWithPresentController:self successCompletion:^(BOOL result) {
                if (result) {
                    [_tableView reloadData];
                }
            }];
        }
    }else if (indexPath.section == 1) {
        //清除缓存
        
    }else {
        if (indexPath.row == 0) {
            //意见反馈
            
        }else if (indexPath.row == 1) {
            //用着不错，给个好评
            
        }else {
            //关于
            SCAboutVC *aboutVC = [[SCAboutVC alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
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
