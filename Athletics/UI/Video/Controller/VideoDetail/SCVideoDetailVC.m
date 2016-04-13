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
    _player = [[CDPVideoPlayer alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.width * (9/16.0f)) url:@"http://v.theonion.com/onionstudios/video/3158/640.mp4" delegate:self haveOriginalUI:YES];
    [self.view addSubview:_player];
    
    _player.title = @"上海特级赛EHOME";
    
}

- (void)switchSizeClickToFullScreen:(BOOL)toFullScreen {
    if (toFullScreen) {
        //        _statusBarHidden = YES;
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    }else {
        //        _statusBarHidden = NO;
        
    }
    [self setNeedsStatusBarAppearanceUpdate];
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
