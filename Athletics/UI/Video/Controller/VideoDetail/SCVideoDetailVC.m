//
//  SCVideoDetailVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCVideoDetailVC.h"

#import "CDPVideoPlayer.h"
#import "LWCommentListCell.h"
#import "SCVideoCollectionViewCell.h"

@interface SCVideoDetailVC ()<CDPVideoPlayerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    CDPVideoPlayer *_player;
    CGFloat   _playerHeight;
    UIButton  *_playButton;
    BOOL _statusBarHidden;
    UICollectionView *_collectionView;
    UIView *_headerView;
    UILabel *_titleLabel;
}

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //http://v.theonion.com/onionstudios/video/3158/640.mp4
    //http://msgpush.dota2.com.cn/m3u8/1460455034449.m3u8
    
    self.m_navBar.bg_alpha = 0.0f;
    
    _playerHeight = self.view.bounds.size.width * (9 / 16.0f);
    
    _player = [[CDPVideoPlayer alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, _playerHeight) url:@"http://msgpush.dota2.com.cn/m3u8/1461687771473.m3u8" delegate:self haveOriginalUI:YES];
    [self.view addSubview:_player];
    [self.view bringSubviewToFront:self.m_navBar];

    _player.title = @"上海特级赛EHOME";
    
    self.title = @"上海特级赛EHOME";
    self.m_navBar.titleLabel.alpha = 0.0f;
    self.m_navBar.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_32px];
    
    [_tableView registerClass:[LWCommentListCell class] forCellReuseIdentifier:[LWCommentListCell cellidentifier]];
    _tableView.frame = CGRectMake(0, 0, self.view.fWidth, self.view.fHeight);
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
    
    _titleLabel.text = @"Dota2大神学院";
    
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

- (void)playButtonClicked:(UIButton *)sender {
    _playButton.hidden = YES;
    self.m_navBar.bg_alpha = 0.0f;
    [_player play];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LWCommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:[LWCommentListCell cellidentifier] forIndexPath:indexPath];
    
    [cell createLayoutWith:@1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:[LWCommentListCell cellidentifier] cacheByIndexPath:indexPath configuration:^(LWCommentListCell *cell) {
        [cell createLayoutWith:@1];
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
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SCVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SCVideoCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    
    
    [cell createLayoutWith:@1];
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
