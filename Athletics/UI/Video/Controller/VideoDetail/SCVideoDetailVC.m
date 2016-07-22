//
//  SCVideoDetailVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCVideoDetailVC.h"
#import "SCCommentInputView.h"
#import "CDPVideoPlayer.h"
#import "LWCommentListCell.h"
#import "SCVideoCollectionViewCell.h"
#import "SCVideoDetailModel.h"
#import "SCVideoCoverModel.h"
#import "SCNewsCommentListModel.h"
#import "SCLoginVC.h"
#import "LrdOutputView.h"


@interface SCVideoDetailVC ()<CDPVideoPlayerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SCCommentInputViewDelegate, LWCommentListCellDelegate, LrdOutputViewDelegate>
{
    CGFloat   _playerHeight;
    UIButton  *_playButton;
    BOOL _statusBarHidden;
    UIView *_headerView;
    UILabel *_titleLabel;
    
    NSMutableArray *_coverArray;
    SCVideoDetailDataModel *_model;
    NSIndexPath *_playingIndexPath;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,strong)  SCCommentInputView  *inputView;
@property (nonatomic,strong)  CDPVideoPlayer  *player;
@property (nonatomic, strong) LrdOutputView *outPutView;


@end

@implementation SCVideoDetailVC

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

- (void)dealloc {
    [_player close];
    _player = nil;
}

-(BOOL)shouldAutorotate{
    return !_player.isSwitch;
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

- (CDPVideoPlayer *)player {
    if (!_player) {
        _player = [[CDPVideoPlayer alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, _playerHeight) url:nil delegate:self haveOriginalUI:YES];
    }
    return _player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[[IQKeyboardManager sharedManager] disabledDistanceHandlingClasses] addObject:[self class]];
    [[[IQKeyboardManager sharedManager] disabledToolbarClasses] addObject:[self class]];
    
    self.m_navBar.bg_alpha = 0.0f;
    _playerHeight = self.view.bounds.size.width * (9 / 16.0f);

    self.title = _videoTitle;
    
    
    self.m_navBar.titleLabel.alpha = 0.0f;
    self.m_navBar.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_32px];
    
    [_tableView registerClass:[LWCommentListCell class] forCellReuseIdentifier:[LWCommentListCell cellidentifier]];
    _tableView.frame = CGRectMake(0, 0, self.view.fWidth, self.view.fHeight - 44);
    _tableView.separatorColor = k_Border_Color;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.contentInset = UIEdgeInsetsMake(_playerHeight, 0, 0, 0);
    
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _playButton.frame = CGRectMake((self.m_navBar.fWidth - 100) / 2.0, 24, 100, 30);
    [_playButton setTitle:@"立即播放" forState:UIControlStateNormal];
    [_playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_playButton addTarget:self action:@selector(playButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_playButton setImage:[UIImage imageNamed:@"live_player_icon_backtolive"] forState:UIControlStateNormal];
    [_playButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    _playButton.hidden = YES;
    _playButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    
    [self.m_navBar addSubview:_playButton];
    
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.fWidth, 44)];
    _headerView.backgroundColor = [UIColor whiteColor];
    _headerView.hidden = YES;
    _tableView.tableHeaderView = _headerView;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, _headerView.fWidth - 20, 20)];
    _titleLabel.textColor = kWord_Color_High;
    _titleLabel.font = [UIFont systemFontOfSize:kWord_Font_30px];
    [_headerView addSubview:_titleLabel];

    _coverArray = [NSMutableArray array];
    [self prepareData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _titleLabel.bottom + 12, _headerView.fWidth, SCVideoCollectionViewCellHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_headerView addSubview:_collectionView];
        [_collectionView setContentSize:CGSizeMake(_collectionView.fWidth + 1, _collectionView.fHeight)];
        [_collectionView registerClass:[SCVideoCollectionViewCell class] forCellWithReuseIdentifier:[SCVideoCollectionViewCell cellIdentifier]];
        _headerView.hidden = NO;
        _headerView.frame = CGRectMake(0, 0, _headerView.fWidth, _collectionView.bottom + 15);
        _tableView.tableHeaderView = _headerView;
    }
    
    return _collectionView;
}

- (void)playButtonClicked:(UIButton *)sender {
    _playButton.hidden = YES;
    self.m_navBar.bg_alpha = 0.0f;
    [_player play];
}

- (void)prepareData {
    
    //视频详情
    [self startActivityAnimation];
    [SCNetwork matchVideoDetailWithVideoId:_videoId success:^(SCVideoDetailModel *model) {
        [self stopActivityAnimation];
        _model = model.data;
        [self updateData];
    } message:^(NSString *resultMsg) {
        [self stopActivityAnimation];
        [self postMessage:resultMsg];
    }];
    
    //视频相关
    [SCNetwork matchVideoRelatedListWithVideoId:_videoId success:^(SCVideoCoverModel *model) {
        [_coverArray removeAllObjects];
        [_coverArray addObjectsFromArray:model.data];
        if (_coverArray.count) {
            _titleLabel.text = @"相关视频";
            [self.collectionView reloadData];
        }
    } message:^(NSString *resultMsg) {
        [self postMessage:resultMsg];
    }];
}

- (void)refreshData {
    [super refreshData];
    
    if (self.sessionTask.state == NSURLSessionTaskStateRunning) {
        [self.sessionTask cancel];
        self.sessionTask = nil;
    }
    
    self.sessionTask = [SCNetwork matchVideoCommentListWithVideoId:_videoId page:_currentPageIndex success:^(SCNewsCommentListModel *model) {
        [self headerEndRefreshing];
        
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
    
    self.sessionTask = [SCNetwork matchVideoCommentListWithVideoId:_videoId page:_currentPageIndex success:^(SCNewsCommentListModel *model) {
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

- (void)updateData {
    [self.view addSubview:self.player];
    _player.title = _model.title;
    [_player playWithNewUrl:_model.url];
    [self.view bringSubviewToFront:self.m_navBar];

    [self.view addSubview:self.inputView];
    _titleLabel.text = [SCGlobaUtil isEmpty:_model.title] ? @"视频" : _model.title;
    _headerView.hidden = NO;
    self.title = _model.title;

    [self headerBeginRefreshing];
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
    if (section == 0) {
        return 10.0f;
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //弹出回复或举报
    [self.view endEditing:YES];
    
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
        [loginVC loginWithPresentController:self successCompletion:^(BOOL result) {
            if (result) {
                [self headerBeginRefreshing];
            }
        }];
    }else {
        if (![SCUserInfoManager isMyWith:model.userId]) {
            sender.userInteractionEnabled = NO;
            [SCNetwork matchVideoCommentLikeWithVideoCommentId:model.videoCommentId success:^(SCResponseModel * aModel) {
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
    //举报
    SCNewsCommentListDataModel *model = [_datasource objectAtIndex:indexPath.row];
    
    if (![SCUserInfoManager isLogin]) {
        SCLoginVC *loginVC = [[SCLoginVC alloc] init];
        [loginVC loginWithPresentController:self successCompletion:^(BOOL result) {
            if (result) {
                MBProgressHUD *HUD = [SCProgressHUD MBHudWithText:@"举报中" showAddTo:self.view delay:NO];
                [SCNetwork userReportWithCommentId:model.videoCommentId type:4 success:^(SCResponseModel *model) {
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
        [SCNetwork userReportWithCommentId:model.videoCommentId type:4 success:^(SCResponseModel *model) {
            [HUD hideAnimated:YES];
            [self postMessage:@"举报成功"];
        } message:^(NSString *resultMsg) {
            [HUD hideAnimated:YES];
            [self postMessage:resultMsg];
        }];
    }
}

#pragma mark - CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _coverArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SCVideoCoverDataModel *model = [_coverArray objectAtIndex:indexPath.item];
    
    SCVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SCVideoCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    
    [cell createLayoutWith:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCVideoCollectionViewCellWidth, SCVideoCollectionViewCellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0f;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item < _coverArray.count) {
        if (_playingIndexPath) {
            SCVideoCoverDataModel *preModel = [_coverArray objectAtIndex:_playingIndexPath.item];
            preModel.isPlaying = @"0";
        }
        if (!_playingIndexPath) {
            SCVideoCoverDataModel *model = [_coverArray objectAtIndex:indexPath.item];
            [_player playWithNewUrl:model.url];
            model.isPlaying = @"1";
            _playingIndexPath = indexPath;
            [_collectionView reloadData];
        }else {
            if (_playingIndexPath.item != indexPath.item) {
                SCVideoCoverDataModel *model = [_coverArray objectAtIndex:indexPath.item];
                [_player playWithNewUrl:model.url];
                model.isPlaying = @"1";
                _playingIndexPath = indexPath;
                [_collectionView reloadData];
            }
        }
    }
}

- (void)updatePlayerStatus:(CDPVideoPlayerStatus)status {
    if (status == CDPVideoPlayerEnd) {
        if (!_playingIndexPath) {
            if (_coverArray.count) {
                SCVideoCoverDataModel *model = [_coverArray objectAtIndex:0];
                [_player playWithNewUrl:model.url];
                model.isPlaying = @"1";
                _playingIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
                [_collectionView reloadData];
            }
        }else if (_playingIndexPath.item + 1 < _coverArray.count) {
            SCVideoCoverDataModel *preModel = [_coverArray objectAtIndex:_playingIndexPath.item];
            preModel.isPlaying = @"0";
            SCVideoCoverDataModel *model = [_coverArray objectAtIndex:_playingIndexPath.item + 1];
            [_player playWithNewUrl:model.url];
            model.isPlaying = @"1";
            _playingIndexPath = [NSIndexPath indexPathForItem:_playingIndexPath.item + 1 inSection:0];
            [_collectionView reloadData];
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
    
    MBProgressHUD *HUD = [SCProgressHUD MBHudWithText:@"评价中" showAddTo:self.view delay:NO];
    
    [SCNetwork matchVideoCommentAddWithVideoId:_videoId comment:inputTextView.text success:^(SCResponseModel *model) {
        [HUD hideAnimated:YES];
        _inputView.inputTextView.text = nil;
        [self postMessage:@"发表成功"];
        [self refreshData];
    } message:^(NSString *resultMsg) {
        [HUD hideAnimated:YES];
        [self postMessage:resultMsg];
    }];
}

- (void)transformFinishedToFullScreen:(BOOL)toFullScreen {
    if (!toFullScreen) {
        [self.view bringSubviewToFront:self.m_navBar];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == _tableView) {
        if (scrollView.contentOffset.y == 0) {
            
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _tableView) {
        if (![_player isPlaying]) {
            CGFloat playerTop = -_playerHeight - scrollView.contentOffset.y;
            if (playerTop < -(_playerHeight - self.m_navBar.fHeight)) {
                playerTop = -(_playerHeight - self.m_navBar.fHeight);
            }
            if (playerTop > 0) {
                playerTop = 0;
            }
            _player.frame = CGRectMake(0, playerTop, _player.fWidth, _player.fHeight);
            float alpha = (_playerHeight + scrollView.contentOffset.y) / (_playerHeight - self.m_navBar.fHeight);
            if (alpha > 1.0) {
                alpha = 1.0;
            }
            if (alpha < 0.0) {
                alpha = 0.0;
            }
            self.m_navBar.titleLabel.alpha = alpha;
            self.m_navBar.bg_alpha = alpha;
            
            if (scrollView.contentOffset.y > -(self.m_navBar.fHeight)) {
                self.m_navBar.titleLabel.alpha = 0.0;
                _playButton.hidden = NO;
            }else {
                _playButton.hidden = YES;
            }
        }
    }
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
