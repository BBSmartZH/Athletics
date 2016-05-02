//
//  SCFullVideoPlayingVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/5/2.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCFullVideoPlayingVC.h"

#import "CDPVideoPlayer.h"

@interface SCFullVideoPlayingVC ()<CDPVideoPlayerDelegate>
{
    CDPVideoPlayer *_player;
    CGFloat   _playerHeight;
}

@end

@implementation SCFullVideoPlayingVC

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
    
    self.m_navBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _playerHeight = self.view.bounds.size.width * (9 / 16.0f);
    
    _player = [[CDPVideoPlayer alloc] initWithFrame:CGRectMake(0, (self.view.fHeight - _playerHeight) / 2.0, self.view.bounds.size.width, _playerHeight) url:nil delegate:self haveOriginalUI:YES];
    [self.view addSubview:_player];
    
    _player.title = _videoTitle;
    
    [_player playFullWithNewUrl:_playUrl];
}

- (void)initFullBack {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController dismissViewControllerAnimated:NO completion:^{
            
        }];
    });
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
