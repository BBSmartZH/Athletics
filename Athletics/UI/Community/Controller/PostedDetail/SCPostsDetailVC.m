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

@interface SCPostsDetailVC ()<SCCommentInputViewDelegate, SCPostsTopViewDelegate, LrdOutputViewDelegate>
{
    UILabel *_testLabel;
    SCPostsTopView *_headerView;
    UIButton *_supportButton;
    UILabel  *_supportLabel;
    UIImageView *_imageV;
    SCCommunityDetailDataModel  *_model;
    int       k;
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
    k = 0;

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

- (void)prepareData {
    [SCNetwork topicInfoWithTopicId:_topicId success:^(SCCommunityDetailModel *model) {
        _model = model.data;
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        [_headerView setModel:_model];
        _headerView.frame = CGRectMake(0, 0, _headerView.fWidth, [_headerView topViewHeight]);
        _tableView.tableHeaderView = _headerView;
    } message:^(NSString *resultMsg) {
        [self postMessage:resultMsg];
    }];
}

-(void)refreshData
{
    [self prepareData];
    
    if (self.sessionTask.state == NSURLSessionTaskStateRunning) {
        [self.sessionTask cancel];
        self.sessionTask = nil;
    }
    
    self.sessionTask = [SCNetwork topicCommentListWithTopicId:_topicId page:_currentPageIndex success:^(SCTopicReplayListModel *model) {
        [self headerEndRefreshing];
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
    if (section == 0) {
        if (k == 0) {
            return 120;
        }else if ( k >0 && k < 7){
            return 167.0f;
        }else{
            return 214.0f;
        }
    }
    return 1.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
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
            _imageV.backgroundColor = [UIColor redColor];
            [view addSubview:_imageV];
        }
        if (k==0) {
            view.frame = CGRectMake(0, 0, _tableView.fWidth,120);

        }else if(k > 0 && k < 7){
            view.frame = CGRectMake(0, 0, _tableView.fWidth,167);

        }else{
            view.frame = CGRectMake(0, 0, _tableView.fWidth,214);

        }
        
        return view;
    }
//    }else {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.fWidth, 0)];
//        view.backgroundColor = [UIColor whiteColor];
//        UIView *line = [[UIView alloc] init];
//        line.backgroundColor = k_Border_Color;
//        [view addSubview:line];
//        
//        [line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(view).offset(10);
//            make.top.bottom.right.equalTo(view);
//        }];
//        
//        return view;
//    }
    return NULL;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if ([_inputView.inputTextView isFirstResponder]) {
            [self.view endEditing:YES];
        }
    }
    
    if (indexPath.section > 0) {
        if (indexPath.row ==0) {
            //弹出回复或举报
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
        }else {
            if ([_inputView.inputTextView isFirstResponder]) {
                [self.view endEditing:YES];
            }else {
                [_inputView.inputTextView becomeFirstResponder];
                _inputView.inputTextView.text = nil;
                _inputView.inputTextView.placeHolder = @"回复：哈哈哈";
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
    [SCNetwork topicLikeAddWithTopicId:_topicId success:^(SCResponseModel *model) {
        [self postMessage:@"点赞成功"];
        _model.isLike = @"1";
        _model.likeCount = [NSString stringWithFormat:@"%d", [SCGlobaUtil getInt:_model.likeCount] + 1];
        sender.enabled = NO;
    } message:^(NSString *resultMsg) {
        [self postMessage:resultMsg];
    }];
}

#pragma mark - LrdOutputViewDelegate
- (void)didSelectedAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"你选择了%ld行", indexPath.row);
    if (indexPath.row == 0) {
        //回复
        
    }else {
        //举报
        
    }
}

- (void)inputViewDidChangedFrame:(CGRect)frame {
    _inputView.frame = frame;
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
