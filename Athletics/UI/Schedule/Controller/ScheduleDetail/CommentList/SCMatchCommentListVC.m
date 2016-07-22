//
//  SCMatchCommentListVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/28.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCMatchCommentListVC.h"

#import "LWCommentListCell.h"
#import "LrdOutputView.h"
#import "SCNewsCommentListModel.h"
#import "SCLoginVC.h"

@interface SCMatchCommentListVC ()<LrdOutputViewDelegate, LWCommentListCellDelegate>
{
    BOOL _isUpdated;
}

@property (nonatomic, strong) LrdOutputView *outPutView;


@end

@implementation SCMatchCommentListVC

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

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

- (BOOL)isUpdated {
    return _isUpdated;
}

- (void)upDateData {
    [self headerBeginRefreshing];
}

- (void)refreshData {
    [super refreshData];
    
    if (self.sessionTask.state == NSURLSessionTaskStateRunning) {
        [self.sessionTask cancel];
        self.sessionTask = nil;
    }
    
    self.sessionTask = [SCNetwork matchCommentListWithMatchUnitId:_matchUnitId page:_currentPageIndex success:^(SCNewsCommentListModel *model) {
        [self headerEndRefreshing];
        _isUpdated = YES;
        
        [_datasource removeAllObjects];
        [_datasource addObjectsFromArray:model.data];
        [_tableView reloadData];
        
        if (_currentPageIndex < [SCGlobaUtil getFloat:model.paging.total] / [SCGlobaUtil getInt:model.paging.size]) {
            _currentPageIndex++;
            [self footerHidden:NO];
        }else {
            [self noticeNoMoreData];
        }
        
    } message:^(NSString *resultMsg) {
        [self headerEndRefreshing];
        [self postMessage:resultMsg];
    }];
    
}

- (void)loadModeData {
    [super loadModeData];
    
    if (self.sessionTask.state == NSURLSessionTaskStateRunning) {
        [self.sessionTask cancel];
        self.sessionTask = nil;
    }
    
    self.sessionTask = [SCNetwork matchCommentListWithMatchUnitId:_matchUnitId page:_currentPageIndex success:^(SCNewsCommentListModel *model) {
        [self footerEndRefreshing];
        
        [_datasource addObjectsFromArray:model.data];
        [_tableView reloadData];
        
        if (_currentPageIndex < [SCGlobaUtil getFloat:model.paging.total] / [SCGlobaUtil getInt:model.paging.size]) {
            _currentPageIndex++;
        }else {
            [self noticeNoMoreData];
        }
        
    } message:^(NSString *resultMsg) {
        [self footerEndRefreshing];
        [self postMessage:resultMsg];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCNewsCommentListDataModel *model = [_datasource objectAtIndex:indexPath.row];
    LWCommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:[LWCommentListCell cellidentifier] forIndexPath:indexPath];
    cell.delegate = self;
    [cell createLayoutWith:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCNewsCommentListDataModel *model = [_datasource objectAtIndex:indexPath.row];

    return [tableView fd_heightForCellWithIdentifier:[LWCommentListCell cellidentifier] cacheByIndexPath:indexPath configuration:^(LWCommentListCell *cell) {
        [cell createLayoutWith:model];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //弹出回复或举报
    [self.parentVC.view endEditing:YES];
    
    LWCommentListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    CGRect rect = [cell.avatar convertRect:cell.avatar.frame toView:[UIApplication sharedApplication].keyWindow];
    
    CGFloat x = rect.origin.x / 2.0;
    CGFloat y = rect.origin.y + rect.size.height;
    
    LrdCellModel *one = [[LrdCellModel alloc] initWithTitle:@"举报" imageName:@"report_image"];
    self.outPutView = [[LrdOutputView alloc] initWithDataArray:@[one] origin:CGPointMake(x, y) width:100 height:36 direction:kLrdOutputViewDirectionLeft];
    _outPutView.delegate = self;
    _outPutView.dismissOperation = ^(){
        //设置成nil，以防内存泄露
        _outPutView = nil;
    };
    
    [self.outPutView pop];
}

#pragma mark - LWCommentListCellDelegate
- (void)praiseButtonClicked:(UIButton *)sender withModel:(SCNewsCommentListDataModel *)model {
    if (![SCUserInfoManager isLogin]) {
        SCLoginVC *loginVC = [[SCLoginVC alloc] init];
        [loginVC loginWithPresentController:self.parentVC successCompletion:^(BOOL result) {
            if (result) {
                [self headerBeginRefreshing];
            }
        }];
    }else {
        if (![SCUserInfoManager isMyWith:model.userId]) {
            sender.userInteractionEnabled = NO;
            [SCNetwork matchCommentLikeWithMatchUnitId:model.matchCommentId success:^(SCResponseModel * aModel) {
                [self postMessage:@"点赞成功"];
                sender.userInteractionEnabled = YES;
                sender.enabled = NO;
                model.isLike = @"1";
                model.likeCount = [NSString stringWithFormat:@"%d", [SCGlobaUtil getInt:model.likeCount] + 1];
                [_tableView reloadData];
            } message:^(NSString *resultMsg) {
                sender.userInteractionEnabled = YES;
                [self postMessage:resultMsg];
            }];
        }else {
            [self postMessage:@"亲，不能给自己点赞哦~~"];
        }
    }

}

#pragma mark - LrdOutputViewDelegate
- (void)didSelectedAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"你选择了%ld行", indexPath.row);
    //举报
    SCNewsCommentListDataModel *model = [_datasource objectAtIndex:indexPath.row];
    
    if (![SCUserInfoManager isLogin]) {
        SCLoginVC *loginVC = [[SCLoginVC alloc] init];
        [loginVC loginWithPresentController:self.parentVC successCompletion:^(BOOL result) {
            if (result) {
                MBProgressHUD *HUD = [SCProgressHUD MBHudWithText:@"举报中" showAddTo:self.parentVC.view delay:NO];
                [SCNetwork userReportWithCommentId:model.matchCommentId type:3 success:^(SCResponseModel *model) {
                    [HUD hideAnimated:YES];
                    [self.parentVC postMessage:@"举报成功"];
                } message:^(NSString *resultMsg) {
                    [HUD hideAnimated:YES];
                    [self.parentVC postMessage:resultMsg];
                }];
            }
        }];
    }else {
        MBProgressHUD *HUD = [SCProgressHUD MBHudWithText:@"举报中" showAddTo:self.parentVC.view delay:NO];
        [SCNetwork userReportWithCommentId:model.matchCommentId type:3 success:^(SCResponseModel *model) {
            [HUD hideAnimated:YES];
            [self.parentVC postMessage:@"举报成功"];
        } message:^(NSString *resultMsg) {
            [HUD hideAnimated:YES];
            [self.parentVC postMessage:resultMsg];
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
