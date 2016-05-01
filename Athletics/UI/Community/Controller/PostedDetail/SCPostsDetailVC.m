//
//  SCPostsDetailVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/15.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCPostsDetailVC.h"
#import "SCPostsDetailVC.h"
#import "SCTopicReplayListModel.h"
#import "SCPostsTextImageCell.h"
#import "SCPostsTopView.h"
#import "SCPostsAdCell.h"
#import "LandlordCell.h"
#import "LWCommentsCell.h"
#import "LWLineCell.h"
#import "SCCommentInputView.h"
#import "SCCommunityDetailModel.h"
#import "LrdOutputView.h"
#import "SCLoginVC.h"
#import "SCBaseWebVC.h"

@interface SCPostsDetailVC ()<SCCommentInputViewDelegate, SCPostsTopViewDelegate, LrdOutputViewDelegate>
{
    UILabel *_testLabel;
    SCPostsTopView *_headerView;
    UIButton *_supportButton;
    UILabel  *_supportLabel;
    UIImageView *_imageV;
    SCCommunityDetailDataModel  *_model;
    int       k;
    int _floorSort;
    NSString *_provId;
    int _reportType;
    NSString *_reportId;
}

@property (nonatomic, strong) SCCommentInputView *inputView;
@property (nonatomic, strong) LrdOutputView *outPutView;

@end

@implementation SCPostsDetailVC

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboareWillShowNotif:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboareWillHiddenNotif:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (SCCommentInputView *)inputView {
    if (!_inputView) {
        _inputView = [[SCCommentInputView alloc] initWithFrame:CGRectMake(0, self.view.fHeight - 44, self.view.fWidth, 44)];
        _inputView.backgroundColor = k_Bg_Color;
        _inputView.delegate = self;
        _inputView.layer.borderWidth = .5f;
        _inputView.layer.borderColor = k_Border_Color.CGColor;
        _inputView.isComment = NO;
        _inputView.inputTextView.placeHolder = @"别憋着，来两句..";
    }
    return _inputView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[[IQKeyboardManager sharedManager] disabledDistanceHandlingClasses] addObject:[self class]];
    [[[IQKeyboardManager sharedManager] disabledToolbarClasses] addObject:[self class]];
    
    self.title = @"帖子详情";
    [_tableView registerClass:[SCPostsTextImageCell class] forCellReuseIdentifier:[SCPostsTextImageCell cellIdentifier]];
    [_tableView registerClass:[SCPostsAdCell class] forCellReuseIdentifier:[SCPostsAdCell cellIdentifier]];
    [_tableView registerClass:[LandlordCell class] forCellReuseIdentifier:[LandlordCell cellIdentifier]];
    [_tableView registerClass:[LWCommentsCell class] forCellReuseIdentifier:[LWCommentsCell cellIdentifier]];
    [_tableView registerClass:[LWLineCell class] forCellReuseIdentifier:[LWLineCell cellIdentifier]];
    
    [self.view addSubview:self.inputView];
    
    _tableView.frame = CGRectMake(0, self.m_navBar.bottom, self.view.fWidth, self.view.fHeight - self.m_navBar.fHeight - _inputView.fHeight);
    _headerView = [[SCPostsTopView alloc] initWithFrame:CGRectMake(0, 0, _tableView.fWidth, 0)];
    _headerView.delegate = self;
    _tableView.tableHeaderView = _headerView;
    
    [self headerBeginRefreshing];
}

- (void)postsTopViewHeightChanged {
    
    [UIView animateWithDuration:0.25 animations:^{
        _headerView.frame = CGRectMake(_headerView.left, _headerView.top, _headerView.fWidth, [_headerView topViewHeight]);
    }];

    [_tableView beginUpdates];
    [_tableView setTableHeaderView:_headerView];
    [_tableView endUpdates];
}

- (void)postsTopViewClickedWith:(id)model {
    //回复或者举报
    if ([_inputView.inputTextView isFirstResponder]) {
        [self.view endEditing:YES];
    }
    CGRect rect = [_headerView.avatar convertRect:_headerView.avatar.frame toView:[UIApplication sharedApplication].keyWindow];
    
    CGFloat x = rect.origin.x / 2.0;
    CGFloat y = rect.origin.y + rect.size.height;
    
    _floorSort = 0;
    _provId = @"";
    _reportType = 5;
    _reportId = _topicId;
    LrdCellModel *one = [[LrdCellModel alloc] initWithTitle:@"回复" imageName:@"item_school"];
    LrdCellModel *two = [[LrdCellModel alloc] initWithTitle:@"举报" imageName:@"item_battle"];
    self.outPutView = [[LrdOutputView alloc] initWithDataArray:@[one, two] origin:CGPointMake(x, y) width:80 height:36 direction:kLrdOutputViewDirectionLeft];
    _outPutView.delegate = self;
    _outPutView.dismissOperation = ^(){
        //设置成nil，以防内存泄露
        _outPutView = nil;
    };
    
    [self.outPutView pop];
}

-(void)refreshData
{
    [SCNetwork topicInfoWithTopicId:_topicId success:^(SCCommunityDetailModel *model) {
        _model = model.data;
        k = (int)_model.images.count;
       [self headerEndRefreshing];
        
        [self loadCommentData];

        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        [_headerView setModel:_model];
        _headerView.frame = CGRectMake(0, 0, _headerView.fWidth, [_headerView topViewHeight]);
        _tableView.tableHeaderView = _headerView;
    } message:^(NSString *resultMsg) {
        [self headerEndRefreshing];
        [self postMessage:resultMsg];
    }];
    
}

- (void)loadCommentData {
    if (self.sessionTask.state == NSURLSessionTaskStateRunning) {
        [self.sessionTask cancel];
        self.sessionTask = nil;
    }
    
    self.sessionTask = [SCNetwork topicCommentListWithTopicId:_topicId page:_currentPageIndex success:^(SCTopicReplayListModel *model) {
        [_datasource removeAllObjects];
        [_datasource addObjectsFromArray:model.data];
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        if (_currentPageIndex < [SCGlobaUtil getInt:model.paging]) {
            _currentPageIndex ++;
            [self footerHidden:NO];
        }else{
            [self noticeNoMoreData];
        }
    } message:^(NSString *resultMsg) {
        [self postMessage:resultMsg];
    }];
}

-(void)loadModeData
{
    
    if (self.sessionTask.state == NSURLSessionTaskStateRunning) {
        [self.sessionTask cancel];
        self.sessionTask = nil;
    }
    
    self.sessionTask = [SCNetwork topicCommentListWithTopicId:_topicId page:_currentPageIndex success:^(SCTopicReplayListModel *model) {
        [self footerEndRefreshing];
        [_datasource addObjectsFromArray:model.data];
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        if (_currentPageIndex < [SCGlobaUtil getInt:model.paging.total]/[SCGlobaUtil getInt:model.paging.size]) {
            _currentPageIndex ++;
        }else{
            [self noticeNoMoreData];
        }
    } message:^(NSString *resultMsg) {
        [self footerEndRefreshing];
        [self postMessage:resultMsg];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (_model.ad) {
            return _model.images.count + 1;
        }
        return _model.images.count;
    }
    return _datasource.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row < _model.images.count) {
            SCImageModel *imageModel = [_model.images objectAtIndex:indexPath.row];
            
            SCPostsTextImageCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCPostsTextImageCell cellIdentifier] forIndexPath:indexPath];
            [cell createLayoutWith:imageModel];
            return cell;
        }
        SCPostsAdCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCPostsAdCell cellIdentifier] forIndexPath:indexPath];
        [cell createLayoutWith:_model.ad];
        return cell;
    }else {
        //评论
        SCTopicReplayListDataModel *replayModel = [_datasource objectAtIndex:indexPath.row];
        
        if ([SCGlobaUtil getInt:replayModel.provId] != 0 && ![SCGlobaUtil isEmpty:replayModel.provId]) {
            LWCommentsCell  *cell = [tableView dequeueReusableCellWithIdentifier:[LWCommentsCell cellIdentifier]forIndexPath:indexPath];
            [cell createLayoutWith:replayModel];
            return cell;
        }
        
        LandlordCell *cell = [tableView dequeueReusableCellWithIdentifier:[LandlordCell cellIdentifier]forIndexPath:indexPath];
        [cell createLayoutWith:replayModel];
        return cell;
    }
    return NULL;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row < _model.images.count) {
            SCImageModel *imageModel = [_model.images objectAtIndex:indexPath.row];
            
            return [SCPostsTextImageCell cellHeightWith:imageModel];
        }
        return [SCPostsAdCell cellHeightWith:_model.ad];
    }else {
        //评论
        SCTopicReplayListDataModel *replayModel = [_datasource objectAtIndex:indexPath.row];
        
        if ([SCGlobaUtil getInt:replayModel.provId] != 0 && ![SCGlobaUtil isEmpty:replayModel.provId]) {
            return [_tableView fd_heightForCellWithIdentifier:[LWCommentsCell cellIdentifier] configuration:^(id cell) {
                [cell createLayoutWith:replayModel];
            }];
        }
        
        return [tableView fd_heightForCellWithIdentifier:[LandlordCell cellIdentifier] configuration:^(id cell) {
            [cell createLayoutWith:replayModel];
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (_model) {
        if (section == 0) {
            int minSpace = 15;
            int counts = 0;
            counts = (kScreenWidth -minSpace)/(32+minSpace);

            if (k == 0) {
                return 120;
            }else if ( k >0 && k < counts){
                return 167.0f;
            }else{
                return 214.0f;
            }
        }
    }
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (_model) {
        if (section == 0) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor whiteColor];
            _supportLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2.0-50, 20, 100, 20)];
            _supportLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
            _supportLabel.textAlignment = NSTextAlignmentCenter;
            _supportLabel.textColor = kWord_Color_Low;
            _supportLabel.text = _model.likeCount;
            [view addSubview:_supportLabel];
            
            _supportButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _supportButton.frame = CGRectMake(kScreenWidth/2.0-25, CGRectGetMaxY(_supportLabel.frame)+10, 50, 50);
            [_supportButton setImage:[UIImage imageNamed:@"news_suppourt_nor"] forState:UIControlStateNormal];
            [_supportButton setImage:[UIImage imageNamed:@"news_suppourt_press"] forState:UIControlStateDisabled];
            [_supportButton addTarget:self action:@selector(supportButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            _supportButton.layer.cornerRadius = 25;
            _supportButton.layer.borderColor = k_Border_Color.CGColor;
            _supportButton.layer.borderWidth = .5f;
            
            if ([SCGlobaUtil getInt:_model.isLike] == 1) {
                _supportButton.enabled = NO;
            }else {
                _supportButton.enabled = YES;
            }
            
            [view addSubview:_supportButton];
            
            int minSpace = 15;
            int counts = 0;
            counts = (kScreenWidth -minSpace)/(32+minSpace);
            
            for (int i = 0 ; i < k; i++) {
                _imageV = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-32*counts)/(counts+1) *(i%counts+1)+i%counts*32,CGRectGetMaxY(_supportButton.frame)+15+i/counts*(15+32) , 32, 32)];
                
                _imageV.clipsToBounds = YES;
                _imageV.contentMode = UIViewContentModeScaleAspectFill;
                _imageV.layer.cornerRadius = 16;
                SCTopicLikeModel *likeModel = [_model.topicLikes objectAtIndex:i];
                [_imageV scImageWithURL:likeModel.userAvatar placeholderImage:nil];
                [view addSubview:_imageV];
            }
            if (k==0) {
                view.frame = CGRectMake(0, 0, _tableView.fWidth,120);
                
            }else if(k > 0 && k < counts){
                view.frame = CGRectMake(0, 0, _tableView.fWidth,167);
                
            }else{
                view.frame = CGRectMake(0, 0, _tableView.fWidth,214);
                
            }
            
            return view;
        }
    }

    return NULL;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if ([_inputView.inputTextView isFirstResponder]) {
            [self.view endEditing:YES];
        }
        
        if (indexPath.section == 0) {
            if (indexPath.row == _model.images.count) {
                //AD
                if (![SCGlobaUtil isEmpty:_model.ad.url]) {
                    SCBaseWebVC *webVC = [[SCBaseWebVC alloc] init];
                    webVC.webUrl = _model.ad.url;
                    [self.navigationController pushViewController:webVC animated:YES];
                }
            }
        }
    }
    
    if (indexPath.section > 0) {
        SCTopicReplayListDataModel *replayModel = [_datasource objectAtIndex:indexPath.row];
        if (![SCUserInfoManager isMyWith:replayModel.uid]) {
            _floorSort = [SCGlobaUtil getInt:replayModel.floorSort];
            _provId = replayModel.provId;
            if ([SCGlobaUtil getInt:replayModel.provId] != 0 && ![SCGlobaUtil isEmpty:replayModel.provId]) {
                if ([_inputView.inputTextView isFirstResponder]) {
                    [self.view endEditing:YES];
                }else {
                    [_inputView.inputTextView becomeFirstResponder];
                    _inputView.inputTextView.text = nil;
                    _inputView.inputTextView.placeHolder = [NSString stringWithFormat:@"回复：%@", replayModel.userName];
                }
            }else {
                //弹出回复或举报
                _reportType = 2;
                _reportId = replayModel.commentId;
                if ([_inputView.inputTextView isFirstResponder]) {
                    [self.view endEditing:YES];
                }
                LandlordCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                
                CGRect rect = [cell.avatar convertRect:cell.avatar.frame toView:[UIApplication sharedApplication].keyWindow];
                
                CGFloat x = rect.origin.x / 2.0;
                CGFloat y = rect.origin.y + rect.size.height;
                
                LrdCellModel *one = [[LrdCellModel alloc] initWithTitle:@"回复" imageName:@"item_school"];
                LrdCellModel *two = [[LrdCellModel alloc] initWithTitle:@"举报" imageName:@"item_battle"];
                self.outPutView = [[LrdOutputView alloc] initWithDataArray:@[one, two] origin:CGPointMake(x, y) width:80 height:36 direction:kLrdOutputViewDirectionLeft];
                _outPutView.delegate = self;
                _outPutView.dismissOperation = ^(){
                    //设置成nil，以防内存泄露
                    _outPutView = nil;
                };
                
                [self.outPutView pop];
            }
        }else {
            if ([_inputView.inputTextView isFirstResponder]) {
                [self.view endEditing:YES];
            }
        }
    }
}

- (void)postsTopCellClickedShowModeWith:(NSIndexPath *)indexPath {
    if (indexPath) {
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)supportButtonClicked:(UIButton *)sender {
    //点赞
    if (![SCUserInfoManager isMyWith:_model.userId]) {
        [SCNetwork topicLikeAddWithTopicId:_topicId success:^(SCResponseModel *model) {
            [self postMessage:@"点赞成功"];
            _model.isLike = @"1";
            _model.likeCount = [NSString stringWithFormat:@"%d", [SCGlobaUtil getInt:_model.likeCount] + 1];
            _supportLabel.text = _model.likeCount;
            sender.enabled = NO;
        } message:^(NSString *resultMsg) {
            [self postMessage:resultMsg];
        }];
    }else {
        [self postMessage:@"亲，不能给自己点哦~~"];
    }
}

#pragma mark - LrdOutputViewDelegate
- (void)didSelectedAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"你选择了%ld行", indexPath.row);
    if (indexPath.row == 0) {
        //回复
        if (![SCUserInfoManager isLogin]) {
            SCLoginVC *loginVC = [[SCLoginVC alloc] init];
            [loginVC loginWithPresentController:self successCompletion:^(BOOL result) {
                if (result) {
                    [_inputView.inputTextView becomeFirstResponder];
                }
            }];
        }else {
            [_inputView.inputTextView becomeFirstResponder];
        }
    }else {
        //举报
        if (![SCUserInfoManager isLogin]) {
            SCLoginVC *loginVC = [[SCLoginVC alloc] init];
            [loginVC loginWithPresentController:self successCompletion:^(BOOL result) {
                if (result) {
                    MBProgressHUD *HUD = [SCProgressHUD MBHudWithText:@"举报中" showAddTo:self.view delay:NO];
                    
                    [SCNetwork userReportWithCommentId:_reportId type:_reportType success:^(SCResponseModel *model) {
                        [HUD hideAnimated:YES];
                        [self postMessage:@"举报成功"];
                    } message:^(NSString *resultMsg) {
                        [HUD hideAnimated:YES];
                        [self postMessage:resultMsg];
                    }];
                }
            }];
        }else {
            MBProgressHUD *HUD = [SCProgressHUD MBHudWithText:@"举报中" showAddTo:self.view delay:NO];
            [SCNetwork userReportWithCommentId:_reportId type:_reportType success:^(SCResponseModel *model) {
                [HUD hideAnimated:YES];
                [self postMessage:@"举报成功"];
            } message:^(NSString *resultMsg) {
                [HUD hideAnimated:YES];
                [self postMessage:resultMsg];
            }];
        }
    }
}

- (void)inputViewDidChangedFrame:(CGRect)frame {
    _inputView.frame = frame;
}

- (void)inputTextViewWillBeginEditing:(SCMessageTextView *)inputTextView {
    if (![SCUserInfoManager isLogin]) {
        [self.view endEditing:YES];
        SCLoginVC *loginVC = [[SCLoginVC alloc] init];
        [loginVC loginWithPresentController:self successCompletion:^(BOOL result) {
            if (result) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [_inputView.inputTextView becomeFirstResponder];
                });
            }
        }];
    }
}

- (void)inputTextViewDidSendMessage:(SCMessageTextView *)inputTextView {
    
    MBProgressHUD *HUD = [SCProgressHUD MBHudWithText:@"回复中" showAddTo:self.view delay:NO];
    
    [SCNetwork topicCommentAddWithTopicId:_topicId parentId:_provId comment:inputTextView.text floorSort:_floorSort success:^(SCResponseModel *model) {
        [HUD hideAnimated:YES];
        _inputView.inputTextView.text = nil;
        [self postMessage:@"发表成功"];
        [self loadCommentData];
    } message:^(NSString *resultMsg) {
        [HUD hideAnimated:YES];
        [self postMessage:resultMsg];
    }];
}

#pragma mark - keyboard
- (void)keyboareWillShowNotif:(NSNotification *)notification {
    // 键盘信息字典
    NSDictionary* info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardHeight = CGRectGetHeight([aValue CGRectValue]);
    
    [UIView animateWithDuration:duration animations:^{
        _inputView.frame = CGRectMake(0, self.view.fHeight - keyboardHeight - _inputView.fHeight, _inputView.fWidth, _inputView.fHeight);
    }];
}

- (void)keyboareWillHiddenNotif:(NSNotification *)notification {
    // 键盘信息字典
    NSDictionary* info = [notification userInfo];
    
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        _inputView.frame = CGRectMake(0, self.view.fHeight - _inputView.fHeight, _inputView.fWidth, _inputView.fHeight);
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
