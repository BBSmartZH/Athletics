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
#import "LWModifyPswdVC.h"
#import "SCFeedbackVC.h"

#import "UIAlertView+Blocks.h"

@interface SCSettingVC ()
{
    NSString *_imageCacheSizeStr;
}

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
    
    _imageCacheSizeStr = @"0K";
    NSUInteger size = [SDWebImageManager sharedManager].imageCache.getSize;
    if (size < 1024 * 1024) {
        _imageCacheSizeStr = [NSString stringWithFormat:@"%luK", (unsigned long)size / 1024];
    }else if (size < 1024 * 1024 * 1024) {
        _imageCacheSizeStr = [NSString stringWithFormat:@"%luM", (unsigned long)size / (1024 * 1024)];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if ([SCUserInfoManager isLogin]) {
            return 2;
        }
        return 1;
    }else if (section == 1) {
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
            if (indexPath.row == 0) {
                cell.leftLabel.text = @"账户";
                cell.rightLabel.text = [SCUserInfoManager userName];
            }else {
                cell.leftLabel.text = @"修改密码";
            }
        }else {
            cell.leftLabel.text = @"账户";
            cell.rightLabel.text = @"点击登录";
        }
    }else if (indexPath.section == 1) {
        cell.leftLabel.text = @"清除缓存";
        cell.rightLabel.text = _imageCacheSizeStr;
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
        if (indexPath.row == 0) {
            if ([SCUserInfoManager isLogin]) {
                //退出登录？
                [UIAlertView showWithTitle:@"提示" message:@"退出后无法收到推送，确认退出登录？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"退出"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                    if (buttonIndex == 1) {
                        self.sessionTask = [SCNetwork logoutSuccess:^(SCResponseModel *model) {} message:^(NSString *resultMsg) {}];
                        [SCUserInfoManager setIsLogin:NO];
                        kPostNotificationWithName(kLogoutSuccessfulNotification);
                        [_tableView reloadData];
                    }
                }];
            }else {
                //登录
                SCLoginVC *loginVC = [[SCLoginVC alloc] init];
                [loginVC loginWithPresentController:self successCompletion:^(BOOL result) {
                    if (result) {
                        [_tableView reloadData];
                    }
                }];
            }

        }else if (indexPath.row == 1) {
            if ([SCUserInfoManager isLogin]) {
                LWModifyPswdVC *modifyVC = [[LWModifyPswdVC alloc]init];
                [self.navigationController pushViewController:modifyVC animated:YES];
            }else {
                SCLoginVC *loginVC = [[SCLoginVC alloc] init];
                [loginVC loginWithPresentController:self successCompletion:^(BOOL result) {
                    if (result) {
                        [_tableView reloadData];
                    }
                }];
            }
        }

    }else if (indexPath.section == 1) {
        //清除缓存
        
        [[SDWebImageManager sharedManager].imageCache clearDiskOnCompletion:^{
            NSUInteger size = [SDWebImageManager sharedManager].imageCache.getSize;
            if (size < 1024 * 1024) {
                _imageCacheSizeStr = [NSString stringWithFormat:@"%luK", (unsigned long)size / 1024];
            }else if (size < 1024 * 1024 * 1024) {
                _imageCacheSizeStr = [NSString stringWithFormat:@"%luM", (unsigned long)size / (1024 * 1024)];
            }
            
            [self postMessage:@"清理成功"];
            
            [_tableView reloadData];
        }];
        
    }else {
        if (indexPath.row == 0) {
            //意见反馈
            SCFeedbackVC *feedbackVC = [[SCFeedbackVC alloc] init];
            [self.navigationController pushViewController:feedbackVC animated:YES];
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
