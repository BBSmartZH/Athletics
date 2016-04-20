//
//  SCScheduleVideoListVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCScheduleVideoListVC.h"

#import "SCVideoListCell.h"
#import "CDPVideoPlayer.h"

@interface SCScheduleVideoListVC ()<SCVideoListCellDelegate, CDPVideoPlayerDelegate>
{
    CDPVideoPlayer *_player;
}

@end

@implementation SCScheduleVideoListVC

- (void)dealloc {
    [_player close];
    _player = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.m_navBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor yellowColor];

    _tableView.frame = CGRectMake(0, 0, self.view.fWidth, self.view.fHeight - _topHeight);
    
    [_tableView registerClass:[SCVideoListCell class] forCellReuseIdentifier:[SCVideoListCell cellIdentifier]];
    
    _player = [[CDPVideoPlayer alloc] initWithFrame:CGRectMake(0, 0, self.view.fWidth - 20, (self.view.fWidth - 20) * (9 / 16.0)) url:nil delegate:self haveOriginalUI:YES];
    [self.view bringSubviewToFront:self.m_navBar];
    
}

- (void)videoButtonClicked:(UIButton *)sender inCell:(SCVideoListCell *)inCell {
    [_player pause];
    [_player removeFromSuperview];
    
    _player.title = @"上海特级赛EHOME";
    _player.frame = inCell.videoFrame;
    [inCell addSubview:_player];
    [_player playWithNewUrl:@"http://v.theonion.com/onionstudios/video/3158/640.mp4"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCVideoListCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCVideoListCell cellIdentifier] forIndexPath:indexPath];
    cell.delegate = self;
    [cell createLayoutWith:@1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10.0f;
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SCVideoListCell heightForCellWith:@1];
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
