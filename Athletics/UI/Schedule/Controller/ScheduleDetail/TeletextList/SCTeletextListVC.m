//
//  SCTeletextListVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCTeletextListVC.h"
#import "SCTeletexListCell.h"
#import "SCMatchDetailModel.h"
#import "SCTeletextListModel.h"

@interface SCTeletextListVC ()
{
    NSString *_rondaId;
    NSMutableArray *_buttonArray;
    NSMutableArray *_validModelArray;
    NSInteger _isTeletexting;
    UIView *_selectedView;
    UIButton *_currentButton;
    UIView   *_slideLine;
    
}

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SCTeletextListVC

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:15.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [_timer invalidate];
    }
    return _timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.m_navBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor clearColor];
    
    _tableView.frame = CGRectMake(0, 44, self.view.fWidth, self.view.fHeight - _topHeight - 44);
    [_tableView registerClass:[SCTeletexListCell class] forCellReuseIdentifier:[SCTeletexListCell cellIdentifier]];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _buttonArray = [NSMutableArray array];
    _validModelArray = [NSMutableArray array];
    
    _selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.fWidth, 44)];
    _selectedView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_selectedView];
    
    int count = 0;
    for (int i = 0; i < _roundGames.count; i++) {
        SCRoundGameModel *model = [_roundGames objectAtIndex:i];
        if ([SCGlobaUtil getInt:model.status] < 3) {
            count++;
            [_validModelArray addObject:model];
            if ([SCGlobaUtil getInt:model.status] == 1) {
                _isTeletexting = i;
            }
        }
    }
    
    CGFloat buttonWidth = self.view.fWidth / count;
    
    for (int i = 0; i < _validModelArray.count; i++) {
        SCRoundGameModel *model = [_validModelArray objectAtIndex:i];
        
        UIButton *button = [self teletextButtonWithTitle:model.name];
        button.frame = CGRectMake(buttonWidth * i, 0, buttonWidth, _selectedView.fHeight);
        [_selectedView addSubview:button];
        [_buttonArray addObject:button];
    }
    
    
    UIView *selectedLine = [[UIView alloc] initWithFrame:CGRectMake(0, _selectedView.fHeight - 0.5, _selectedView.fWidth, 0.5)];
    selectedLine.backgroundColor = k_Border_Color;
    [_selectedView addSubview:selectedLine];
    
    _slideLine = [[UIView alloc] init];
    _slideLine.backgroundColor = k_Base_Color;
    [_selectedView addSubview:_slideLine];
    _slideLine.frame = CGRectMake(10,  _selectedView.fHeight - 2, buttonWidth - 20, 2);
    
    [self selectedButtonClicked:[_buttonArray objectAtIndex:_isTeletexting]];
    
}

- (void)timerAction:(NSTimer *)sender {
    [self headerBeginRefreshing];
}

- (UIButton *)teletextButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kWord_Color_Low forState:UIControlStateNormal];
    [button setTitleColor:k_Base_Color forState:UIControlStateSelected];
    [button addTarget:self action:@selector(selectedButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    
    return button;
}

- (void)selectedButtonClicked:(UIButton *)sender {
    if (sender.isSelected) {
        return;
    }
    _currentButton.selected = NO;
    _currentButton = sender;
    _currentButton.selected = YES;
    
    [UIView animateWithDuration:0.15 animations:^{
        _slideLine.frame = CGRectMake(sender.left + 10,  _selectedView.fHeight - 2, sender.fWidth - 20, 2);
    }];
    
    NSInteger index = [_buttonArray indexOfObject:sender];
    SCRoundGameModel *model = [_roundGames objectAtIndex:index];
    _rondaId = model.matchRoundGamesId;
    
    [self headerBeginRefreshing];
}

- (void)upDateData {
    [self headerBeginRefreshing];
}

- (void)refreshData {
    
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    
    [self footerHidden:YES];
    
    if (self.sessionTask.state == NSURLSessionTaskStateRunning) {
        [self.sessionTask cancel];
        self.sessionTask = nil;
    }
    
    self.sessionTask = [SCNetwork matchUnitliveListWithMatchRondaId:_rondaId page:_currentPageIndex success:^(SCTeletextListModel *model) {
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
    
    self.sessionTask = [SCNetwork matchUnitliveListWithMatchRondaId:_rondaId page:_currentPageIndex success:^(SCTeletextListModel *model) {
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datasource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCTeletexListCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCTeletexListCell cellIdentifier]forIndexPath:indexPath];
    
    SCTeletextListDataModel *model = [_datasource objectAtIndex:indexPath.row];
    
    [cell creatLayoutWith:model];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCTeletextListDataModel *model = [_datasource objectAtIndex:indexPath.row];

    return [tableView fd_heightForCellWithIdentifier:[SCTeletexListCell cellIdentifier] configuration:^(SCTeletexListCell *cell) {
        [cell creatLayoutWith:model];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
