//
//  SCPostsDetailVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/15.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCPostsDetailVC.h"


#import "SCPostsTextImageCell.h"
#import "SCPostsTopView.h"
#import "SCPostsAdCell.h"
#import "LandlordCell.h"
#import "LWCommentsCell.h"
#import "LWLineCell.h"
@interface SCPostsDetailVC ()<SCPostsTopViewDelegate>
{
    UILabel *_testLabel;
    SCPostsTopView *_headerView;
    
    UIButton *_supportButton;
    UILabel  *_supportLabel;
}

@end

@implementation SCPostsDetailVC

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"帖子详情";
    
    [_tableView registerClass:[SCPostsTextImageCell class] forCellReuseIdentifier:[SCPostsTextImageCell cellIdentifier]];
    [_tableView registerClass:[SCPostsAdCell class] forCellReuseIdentifier:[SCPostsAdCell cellIdentifier]];
    [_tableView registerClass:[LandlordCell class] forCellReuseIdentifier:[LandlordCell cellIdentifier]];
    [_tableView registerClass:[LWCommentsCell class] forCellReuseIdentifier:[LWCommentsCell cellIdentifier]];
    [_tableView registerClass:[LWLineCell class] forCellReuseIdentifier:[LWLineCell cellIdentifier]];
    
    _tableView.frame = CGRectMake(0, self.m_navBar.bottom, self.view.fWidth, self.view.fHeight - self.m_navBar.fHeight);
    _headerView = [[SCPostsTopView alloc] initWithFrame:CGRectMake(0, 0, _tableView.fWidth, 0)];
    _headerView.delegate = self;
    [_headerView setModel:@1];
    _headerView.frame = CGRectMake(0, 0, _headerView.fWidth, [_headerView topViewHeight]);
    _tableView.tableHeaderView = _headerView;
    
    
    
    
}

- (void)postsTopViewHeightChanged {
    
    [UIView animateWithDuration:0.25 animations:^{
        _headerView.frame = CGRectMake(_headerView.left, _headerView.top, _headerView.fWidth, [_headerView topViewHeight]);
    }];

    [_tableView beginUpdates];
    [_tableView setTableHeaderView:_headerView];
    [_tableView endUpdates];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 20;
    }
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row < 10) {
            SCPostsTextImageCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCPostsTextImageCell cellIdentifier] forIndexPath:indexPath];
            if (indexPath.row % 2 == 0) {
                [cell createLayoutWith:@1];
                
            }else {
                [cell createLayoutWith:@2];
                
            }
            return cell;
        }else{
            SCPostsAdCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCPostsAdCell cellIdentifier] forIndexPath:indexPath];
            if (indexPath.row % 2 == 0) {
                [cell createLayoutWith:@1];
                
            }else {
                [cell createLayoutWith:@2];
                
            }
            return cell;


        }

    }else if(indexPath.section >=1){
        if (indexPath.row == 0) {
            LandlordCell *cell = [tableView dequeueReusableCellWithIdentifier:[LandlordCell cellIdentifier]forIndexPath:indexPath];
            [cell createLayoutWith:@1];
            return cell;
        }else if (indexPath.row > 0 && indexPath.row < 4){
           LWCommentsCell  *cell = [tableView dequeueReusableCellWithIdentifier:[LWCommentsCell cellIdentifier]forIndexPath:indexPath];
            [cell createLayoutWith:@1];
            return cell;
        }else{
            LWLineCell *cell = [tableView dequeueReusableCellWithIdentifier:[LWLineCell cellIdentifier]forIndexPath:indexPath];
            return cell;
        }
        
    }
    return NULL;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row < 10) {
            NSNumber *model;
            if (indexPath.row % 2 == 0) {
                model = @1;
            }else {
                model = @2;
            }
            return [SCPostsTextImageCell cellHeightWith:model];
        }
        
        NSNumber *model;
        if (indexPath.row % 2 == 0) {
            model = @1;
        }else {
            model = @2;
        }
        return [SCPostsAdCell cellHeightWith:model];

    }else if (indexPath.section >=1){
        if (indexPath.row == 0) {
            return [tableView fd_heightForCellWithIdentifier:[LandlordCell cellIdentifier] configuration:^(id cell) {
                [cell createLayoutWith:@1];
            }];
        }else if (indexPath.row >0 && indexPath.row < 4){
            return [_tableView fd_heightForCellWithIdentifier:[LWCommentsCell cellIdentifier] configuration:^(id cell) {
                [cell createLayoutWith:@1];
            }];
        }else if(indexPath.row == 4){
            return 1;
        }
    }
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 110.0f;
    }
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.fWidth, 0)];
        view.backgroundColor = [UIColor whiteColor];
        _supportLabel = [[UILabel alloc] init];
        _supportLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
        _supportLabel.textAlignment = NSTextAlignmentCenter;
        _supportLabel.textColor = kWord_Color_Low;
        _supportLabel.text = @"20000";
        [view addSubview:_supportLabel];
        
        _supportButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_supportButton setImage:[UIImage imageNamed:@"news_suppourt_nor"] forState:UIControlStateNormal];
        [_supportButton setImage:[UIImage imageNamed:@"news_suppourt_press"] forState:UIControlStateSelected];
        [_supportButton addTarget:self action:@selector(supportButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _supportButton.layer.cornerRadius = 25;
        _supportButton.layer.borderColor = k_Border_Color.CGColor;
        _supportButton.layer.borderWidth = .5f;
        [view addSubview:_supportButton];
        
        [_supportLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
        [_supportLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(20);
            make.centerX.equalTo(view);
        }];
        [_supportButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(view).offset(-20);
            make.centerX.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        return view;
    }
    return NULL;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)postsTopCellClickedShowModeWith:(NSIndexPath *)indexPath {
    if (indexPath) {
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)supportButtonClicked:(UIButton *)sender {
    if (!sender.isSelected) {
        sender.selected = YES;
        sender.layer.borderColor = [UIColor yellowColor].CGColor;
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
