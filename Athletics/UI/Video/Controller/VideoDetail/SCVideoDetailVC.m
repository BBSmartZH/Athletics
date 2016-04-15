//
//  SCVideoDetailVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCVideoDetailVC.h"

#import "CDPVideoPlayer.h"


@interface SCVideoDetailVC ()<CDPVideoPlayerDelegate>
{
    CDPVideoPlayer *_player;
    CGFloat   _playerHeight;
    UIButton  *_playButton;
    BOOL _statusBarHidden;
}

@end

@implementation SCVideoDetailVC

- (void)dealloc {
    [_player close];
    _player = nil;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return _statusBarHidden;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //http://v.theonion.com/onionstudios/video/3158/640.mp4
    //http://msgpush.dota2.com.cn/m3u8/1460455034449.m3u8
    
    self.m_navBar.bg_alpha = 0.0f;
    
    _playerHeight = self.view.bounds.size.width * (9 / 16.0f);
    
    _player = [[CDPVideoPlayer alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, _playerHeight) url:@"http://v.theonion.com/onionstudios/video/3158/640.mp4" delegate:self haveOriginalUI:YES];
    [self.view addSubview:_player];
    _player.title = @"上海特级赛EHOME";
    
    self.title = @"上海特级赛EHOME";
    self.m_navBar.titleLabel.alpha = 0.0f;
    self.m_navBar.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_32px];
    [self.view bringSubviewToFront:self.m_navBar];
    
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
    
    static NSString *cellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (void)updatePlayerStatus:(CDPVideoPlayerStatus)status {
    if (status == CDPVideoPlayerPlay) {
        [UIView animateWithDuration:0.15 animations:^{
            _player.frame = CGRectMake(0, 0, _player.fWidth, _player.fHeight);
        }];
    }
}

- (void)switchSizeClickToFullScreen:(BOOL)toFullScreen {
    if (toFullScreen) {
        _statusBarHidden = YES;
    }else {
        _statusBarHidden = NO;
    }
    [self setNeedsStatusBarAppearanceUpdate];
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
