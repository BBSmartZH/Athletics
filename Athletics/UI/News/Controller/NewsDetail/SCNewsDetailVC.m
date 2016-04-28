//
//  SCNewsDetailVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNewsDetailVC.h"

#import "SCCommentListVC.h"
#import "SCNewsDetailTextCell.h"
#import "SCNewsDetailImageCell.h"
#import "SCNewsDetailVideoCell.h"
#import "SCNewsCell.h"
#import "LWPhotosNormalCell.h"
#import "SCPostsAdCell.h"

@interface SCNewsDetailVC ()
{
    UILabel *_titleLabel;
    UILabel *_timeLabel;
    UILabel *_relatedLabel;
}


@end

@implementation SCNewsDetailVC

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.m_navBar.hidden = YES;
    
    [_tableView registerClass:[SCNewsDetailTextCell class] forCellReuseIdentifier:[SCNewsDetailTextCell cellIdentifier]];
    [_tableView registerClass:[SCNewsDetailImageCell class] forCellReuseIdentifier:[SCNewsDetailImageCell cellIdentifier]];
    [_tableView registerClass:[SCNewsDetailVideoCell class] forCellReuseIdentifier:[SCNewsDetailVideoCell cellIdentifier]];
    [_tableView registerClass:[SCPostsAdCell class] forCellReuseIdentifier:[SCPostsAdCell cellIdentifier]];
   
    [_tableView registerClass:[SCNewsCell class] forCellReuseIdentifier:[SCNewsCell cellIdentifier]];
    [_tableView registerClass:[LWPhotosNormalCell class] forCellReuseIdentifier:[LWPhotosNormalCell cellIdentifier]];
    
//    _tableView.frame = CGRectMake(0, 0, self.view.fWidth, self.view.fHeight);
    _WEAKSELF(ws);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(ws.view);
    }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 10) {
            SCNewsDetailVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCNewsDetailVideoCell cellIdentifier] forIndexPath:indexPath];
            [cell createLayoutWith:@1];
            return cell;
        }else if (indexPath.row == 1 || indexPath.row == 3) {
            SCNewsDetailImageCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCNewsDetailImageCell cellIdentifier] forIndexPath:indexPath];
            [cell createLayoutWith:@1];
            return cell;
        }else if (indexPath.row == 6) {
            SCPostsAdCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCPostsAdCell cellIdentifier] forIndexPath:indexPath];
            [cell createLayoutWith:@1];
        }
        SCNewsDetailTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCNewsDetailTextCell cellIdentifier] forIndexPath:indexPath];
        [cell createLayoutWith:@1];
        return cell;
    }else {
        if (indexPath.row % 2 == 0) {
            SCNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCNewsCell cellIdentifier] forIndexPath:indexPath];
            [cell createLayoutWith:@1];
            return cell;
        }
        LWPhotosNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:[LWPhotosNormalCell cellIdentifier] forIndexPath:indexPath];
        [cell createLayoutWith:@1];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            return [SCNewsDetailVideoCell cellHeightWith:@1];
        }else if (indexPath.row == 3 || indexPath.row == 5) {
            return [SCNewsDetailImageCell cellHeightWith:@1];
        }else if (indexPath.row == 6) {
            return [SCPostsAdCell cellHeightWith:@1];
        }
        return [tableView fd_heightForCellWithIdentifier:[SCNewsDetailTextCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SCNewsDetailTextCell *cell) {
            [cell createLayoutWith:@1];
        }];
    }else {
        if (indexPath.row % 2 == 0) {
            return [tableView fd_heightForCellWithIdentifier:[SCNewsCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SCNewsCell *cell) {
                [cell createLayoutWith:@1];
            }];
        }
        return [LWPhotosNormalCell heightForRowWithPhotosWithCounts:2];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        CGFloat height = 0.0;
        height += 20;
        
        height += ([SCGlobaUtil sizeWithText:@"6.87全新游戏性更新   马尼拉特锦赛预选赛本周开锣" width:_tableView.fWidth - 20 attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:kWord_Font_32px]}].height);
        
        height += 10;

        height += ([SCGlobaUtil sizeWithText:@"2016-04-26 18:00" width:_tableView.fWidth - 20 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:kWord_Font_20px]}].height);
        
        height += 15;

        return height;
    }else {
        return 64;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.fWidth, 0)];
        view.backgroundColor = [UIColor whiteColor];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:kWord_Font_32px];
        _titleLabel.text = @"这是标题标题这是标题标题这是标题标题这是标题标题这是标题标题这是标题标题这是标题标题这是标题标题这是标题标题";
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = kWord_Color_High;
        [view addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
        _timeLabel.textColor = kWord_Color_Low;
        _timeLabel.text = @"2016-04-08 18:00";
        [view addSubview:_timeLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(15);
            make.right.equalTo(view).offset(-15);
            make.top.equalTo(view).offset(20);
        }];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_titleLabel);
            make.top.equalTo(_titleLabel.mas_bottom).offset(10);
            make.bottom.equalTo(view).offset(-15);
        }];
        
        return view;
    }else {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        _relatedLabel = [[UILabel alloc] init];
        _relatedLabel.text = @"相关阅读";
        _relatedLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
        _relatedLabel.textColor = kWord_Color_High;
        [view addSubview:_relatedLabel];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = k_Border_Color;
        [view addSubview:line];
        
        [_relatedLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
        [_relatedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(view.mas_bottom);
            make.left.equalTo(view).offset(10);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_relatedLabel);
            make.right.equalTo(view);
            make.height.mas_equalTo(@.5f);
            make.left.equalTo(_relatedLabel.mas_right).offset(30);
        }];
        
        return view;
    }
    return NULL;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
