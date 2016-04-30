//
//  SCMineInfoVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/28.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCMineInfoVC.h"
#import "SCUserModel.h"
#import "SCChangeNameVC_iPhone.h"
#import "SCPhotoManager.h"
#import "SCUploadTokenModel.h"

#import "UIImage+Scale.h"
#import "SCQiNiuUploadManager.h"
@interface SCMineInfoVC ()
{
    UIButton    *_saveButton;
    UIImageView *_avatar;
    NSString    *_name;
    BOOL        _hasChangeImage;
}

@end

static NSString *cellId = @"Cell";

@implementation SCMineInfoVC

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"个人信息";
    
    _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_saveButton addTarget:self action:@selector(p_saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _saveButton.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [self.m_navBar addSubview:_saveButton];
    _saveButton.hidden = YES;
    CGSize buttonSize = CGSizeMake(40, 40);
    _WEAKSELF(ws);
    [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.m_navBar).offset(-5);
        make.size.mas_equalTo(buttonSize);
        make.bottom.equalTo(ws.m_navBar).offset(-2);
    }];
    
    _tableView.frame = CGRectMake(0, self.m_navBar.bottom, self.view.fWidth, self.view.fHeight - self.m_navBar.fHeight);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor = k_Border_Color;
    _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(_tableView.fWidth - 44 - 30, 10, 44, 44)];
    _avatar.layer.cornerRadius = 22;
    _avatar.clipsToBounds = YES;
    [_avatar scImageWithURL:[SCUserInfoManager avatar] placeholderImage:[UIImage imageNamed:@"mine_default_avatar"]];
    
    _name = [SCUserInfoManager userName];
}

- (void)p_saveButtonClicked:(UIButton *)sender {
    if ([SCGlobaUtil isEmpty:_name] || !_avatar.image) {
        [self postErrorMessage:@"用户名或头像为空"];
        return;
    }
    sender.enabled = NO;
    if (_hasChangeImage) {
        UIImage *image = _avatar.image;
        image = [image scaleToSize:CGSizeMake(_avatar.fWidth * 4, _avatar.fWidth * 4)];
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        
        MBProgressHUD *HUD = [SCProgressHUD MBHudWithText:@"获取上传token.." showAddTo:self.view delay:NO];
        _WEAKSELF(ws);
        self.sessionTask = [SCNetwork getUploadTokenWithSuccess:^(SCUploadTokenModel *model) {
            if (model.success.boolValue) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *dateStr = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@_%@.jpg", dateStr, [SCUserInfoManager uid]];
                fileName = [fileName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                [HUD hideAnimated:YES];
                MBProgressHUD *HUD = [SCProgressHUD MBHudWithText:@"上传头像中..." showAddTo:self.view delay:NO];
                
                [[SCQiNiuUploadManager shared] uploadWithData:imageData fileName:fileName token:model.data.uploadToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                    [HUD hideAnimated:YES];
                    NSString *downloadUrl = [NSString stringWithFormat:@"%@/%@", model.data.spaceUrl, key];
                    SCUserModel *model = [SCUserInfoManager userInfo];
                    model.avatar = downloadUrl;
                    [SCUserInfoManager setUserInfo:model];
                    [ws p_save];
                } option:nil];
                
            }else {
                [ws postErrorMessage:model.message];
                [HUD hideAnimated:YES];
                sender.enabled = YES;
            }
        } message:^(NSString *resultMsg) {
            [HUD hideAnimated:YES];
            [self postMessage:resultMsg];
            sender.enabled = YES;
        }];
    } else {
        [self p_save];
    }
}

- (void)p_save {
    MBProgressHUD *HUD = [SCProgressHUD MBHudWithText:@"保存中..." showAddTo:self.view delay:NO];
    
    self.sessionTask = [SCNetwork userUpdateWithAvatar:[SCUserInfoManager avatar] nickname:_name success:^(SCResponseModel *model) {
        [HUD hideAnimated:YES];
        _saveButton.enabled = YES;
        [self postMessage:@"保存成功"];
        SCUserModel *userModel = [SCUserInfoManager userInfo];
        userModel.name = _name;
        [SCUserInfoManager setUserInfo:userModel];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } message:^(NSString *resultMsg) {
        [HUD hideAnimated:YES];
        [self postMessage:resultMsg];
        _saveButton.enabled = YES;
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if ([cell.contentView.subviews containsObject:_avatar]) {
        [_avatar removeFromSuperview];
    }
    NSString *leftTitle = @"";
    NSString *rightTitle = @"";
    if (indexPath.row == 0) {
        leftTitle = @"头像";
        [cell.contentView addSubview:_avatar];
    }else if (indexPath.row == 1) {
        leftTitle = @"昵称";
        rightTitle = _name;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    cell.textLabel.textColor = kWord_Color_Event;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    cell.detailTextLabel.textColor = kWord_Color_Low;
    cell.textLabel.text = leftTitle;
    cell.detailTextLabel.text = rightTitle;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 64;
    }else {
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [[SCPhotoManager shared] showActionSheetInView:self.view fromController:self completion:^(UIImage *image) {
            _avatar.image = image;
            _saveButton.hidden = NO;
            _hasChangeImage = YES;
        } cancel:^{
            
        }];
    }else if (indexPath.row == 1) {
        
        SCChangeNameVC_iPhone *nameVC = [[SCChangeNameVC_iPhone alloc] init];
        nameVC.name = _name;
        nameVC.completion = ^(NSString *result) {
            if (![SCGlobaUtil isEmpty:result]) {
                _name = result;
                _saveButton.hidden = NO;
                [_tableView reloadData];
            }
        };
        [self.navigationController pushViewController:nameVC animated:YES];
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
