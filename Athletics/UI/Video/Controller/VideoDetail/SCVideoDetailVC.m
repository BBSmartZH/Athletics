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

@interface SCVideoDetailVC ()<CDPVideoPlayerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,SCCommentInputViewDelegate>
{
    CDPVideoPlayer *_player;
    CGFloat   _playerHeight;
    UIButton  *_playButton;
    BOOL _statusBarHidden;
    UIView *_headerView;
    UILabel *_titleLabel;
    
    NSMutableArray *_coverArray;
    SCVideoDetailDataModel *_model;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,strong)  SCCommentInputView  *inputView;


@end

@implementation SCVideoDetailVC

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //http://v.theonion.com/onionstudios/video/3158/640.mp4
    //http://msgpush.dota2.com.cn/m3u8/1460455034449.m3u8
    
    self.m_navBar.bg_alpha = 0.0f;
    
    _playerHeight = self.view.bounds.size.width * (9 / 16.0f);
    
    _player = [[CDPVideoPlayer alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, _playerHeight) url:nil delegate:self haveOriginalUI:YES];
    [self.view addSubview:_player];
    [self.view bringSubviewToFront:self.m_navBar];
    
    self.title = _videoTitle;
    
    self.m_navBar.titleLabel.alpha = 0.0f;
    self.m_navBar.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_32px];
    
    [_tableView registerClass:[LWCommentListCell class] forCellReuseIdentifier:[LWCommentListCell cellidentifier]];
    _tableView.frame = CGRectMake(0, 0, self.view.fWidth, self.view.fHeight-_inputView.fHeight);
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
        [self.collectionView reloadData];
    } message:^(NSString *resultMsg) {
        [self postMessage:resultMsg];
    }];
}

- (void)refreshData {
    
    if (self.sessionTask.state == NSURLSessionTaskStateRunning) {
        [self.sessionTask cancel];
        self.sessionTask = nil;
    }
    
    self.sessionTask = [SCNetwork matchVideoCommentListWithVideoId:_videoId page:_currentPageIndex success:^(SCNewsCommentListModel *model) {
        [self headerEndRefreshing];
        
        [_datasource removeAllObjects];
        [_datasource addObjectsFromArray:model.data];
        [_tableView reloadData];
        
        if (_currentPageIndex < [SCGlobaUtil getInt:model.paging.total] / [SCGlobaUtil getInt:model.paging.size]) {
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
    
    if (self.sessionTask.state == NSURLSessionTaskStateRunning) {
        [self.sessionTask cancel];
        self.sessionTask = nil;
    }
    
    self.sessionTask = [SCNetwork matchVideoCommentListWithVideoId:_videoId page:_currentPageIndex success:^(SCNewsCommentListModel *model) {
        [self footerEndRefreshing];
        
        [_datasource addObjectsFromArray:model.data];
        [_tableView reloadData];
        
        if (_currentPageIndex < [SCGlobaUtil getInt:model.paging.total] / [SCGlobaUtil getInt:model.paging.size]) {
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
    
    [self headerBeginRefreshing];
    _titleLabel.text = _videoTitle;
    _player.title = _model.title;
    
    [_player playWithNewUrl:_model.url];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCNewsCommentListDataModel *model = [_datasource objectAtIndex:indexPath.row];
    LWCommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:[LWCommentListCell cellidentifier] forIndexPath:indexPath];
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
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
    
}

- (void)updatePlayerStatus:(CDPVideoPlayerStatus)status {
    if (status == CDPVideoPlayerPlay) {
        [UIView animateWithDuration:0.15 animations:^{
            _player.frame = CGRectMake(0, 0, _player.fWidth, _player.fHeight);
        }];
    }else if (status == CDPVideoPlayerEnd) {
        //播放下一个
        [_player playWithNewUrl:@"http://v.theonion.com/onionstudios/video/3158/640.mp4"];
    }
}



- (void)switchSizeClickToFullScreen:(BOOL)toFullScreen {
    if (toFullScreen) {
        if ([UIDevice currentDevice].systemVersion.floatValue < 9.0) {
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
        }
    }else {
        if ([UIDevice currentDevice].systemVersion.floatValue < 9.0) {
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
        }
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
