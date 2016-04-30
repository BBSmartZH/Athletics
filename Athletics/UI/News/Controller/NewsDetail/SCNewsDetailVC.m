//
//  SCNewsDetailVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNewsDetailVC.h"

#import "SCNewsDetailTextCell.h"
#import "SCNewsDetailImageCell.h"
#import "SCNewsDetailVideoCell.h"
#import "SCNewsCell.h"
#import "LWPhotosNormalCell.h"
#import "SCPostsAdCell.h"
#import "SCNewsDetailModel.h"

#import "SCNewsPhotosPackVC.h"
#import "SCNewsArticlePackVC.h"

@interface SCNewsDetailVC ()
{
    UILabel *_titleLabel;
    UILabel *_timeLabel;
    UILabel *_relatedLabel;
    SCNewsDetailDataModel *_model;
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
    
    _WEAKSELF(ws);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(ws.view);
    }];
    
    [self prepareData];

}

- (void)prepareData {
    
    [self startActivityAnimation];
    self.sessionTask = [SCNetwork newsInfoWithNewsId:_newsId success:^(SCNewsDetailModel *model) {
        [self stopActivityAnimation];
        _model = model.data;
        [_tableView reloadData];
    } message:^(NSString *resultMsg) {
        [self postMessage:resultMsg];
        [self stopActivityAnimation];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = 1;
    if (_model.relate.count) {
        count++;
    }
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _model.content.count;
    }
    return _model.relate.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SCContentListModel *contentModel = [_model.content objectAtIndex:indexPath.row];
        
        if ([SCGlobaUtil getInt:contentModel.type] == 2) {
            SCNewsDetailImageCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCNewsDetailImageCell cellIdentifier] forIndexPath:indexPath];
            [cell createLayoutWith:contentModel];
        }else if ([SCGlobaUtil getInt:contentModel.type] == 3) {
            SCNewsDetailVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCNewsDetailVideoCell cellIdentifier] forIndexPath:indexPath];
            [cell createLayoutWith:contentModel];
        }
        
//        SCPostsAdCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCPostsAdCell cellIdentifier] forIndexPath:indexPath];
//        [cell createLayoutWith:@1];
        
        SCNewsDetailTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCNewsDetailTextCell cellIdentifier] forIndexPath:indexPath];
        [cell createLayoutWith:contentModel];
        return cell;
    }else {
        SCNewsListDataModel *model = [_model.relate objectAtIndex:indexPath.row];
        
        if ([SCGlobaUtil getInt:model.type] == 3) {
            if (model.images.count > 0) {
                LWPhotosNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:[LWPhotosNormalCell cellIdentifier] forIndexPath:indexPath];
                [cell createLayoutWith:model];
                return cell;
            }
        }
        SCNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCNewsCell cellIdentifier] forIndexPath:indexPath];
        [cell createLayoutWith:model];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SCContentListModel *contentModel = [_model.content objectAtIndex:indexPath.row];
        
        if ([SCGlobaUtil getInt:contentModel.type] == 2) {
            return [SCNewsDetailImageCell cellHeightWith:contentModel];
        }else if ([SCGlobaUtil getInt:contentModel.type] == 3) {
            return [SCNewsDetailVideoCell cellHeightWith:contentModel];
        }
        
        //        SCPostsAdCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCPostsAdCell cellIdentifier] forIndexPath:indexPath];
        //        [cell createLayoutWith:@1];
//        return [SCPostsAdCell cellHeightWith:@1];

        return [tableView fd_heightForCellWithIdentifier:[SCNewsDetailTextCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SCNewsDetailTextCell *cell) {
            [cell createLayoutWith:contentModel];
        }];
    }else {
        SCNewsListDataModel *model = [_model.relate objectAtIndex:indexPath.row];
        
        if ([SCGlobaUtil getInt:model.type] == 3) {
            if (model.images.count > 0) {
                return [LWPhotosNormalCell heightForRowWithPhotosWithCounts:(int)model.images.count];
            }
        }
        return [tableView fd_heightForCellWithIdentifier:[SCNewsCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SCNewsCell *cell) {
            [cell createLayoutWith:model];
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_model) {
        if (section == 0) {
            CGFloat height = 0.0;
            height += 20;
            
            height += ([SCGlobaUtil sizeWithText:_model.title width:_tableView.fWidth - 20 attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:kWord_Font_32px]}].height);
            
            height += 10;
            
            height += ([SCGlobaUtil sizeWithText:_model.pub_time width:_tableView.fWidth - 20 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:kWord_Font_20px]}].height);
            
            height += 15;
            
            return height;
        }else {
            return 64;
        }
    }
    return 0.01;
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
        _titleLabel.text = _model.title;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = kWord_Color_High;
        [view addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
        _timeLabel.textColor = kWord_Color_Low;
        _timeLabel.text = _model.pub_time;
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
    if (_model.relate.count && indexPath.section == 1) {
        SCNewsListDataModel *model = [_datasource objectAtIndex:indexPath.row];
        
        if ([SCGlobaUtil getInt:model.type] == 3 && model.images.count > 0) {
            SCNewsPhotosPackVC *photosVC = [[SCNewsPhotosPackVC alloc] init];
            photosVC.newsId = model.newsId;
            photosVC.hidesBottomBarWhenPushed = YES;
            [self.parentVC.navigationController pushViewController:photosVC animated:YES];
        }else {
            SCNewsArticlePackVC *articleVC = [[SCNewsArticlePackVC alloc] init];
            articleVC.newsId = model.newsId;
            articleVC.hidesBottomBarWhenPushed = YES;
            [self.parentVC.navigationController pushViewController:articleVC animated:YES];
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
