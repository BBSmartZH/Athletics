//
//  SCGuessListVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCGuessListVC.h"

#import "SCGuessListCell.h"

@interface SCGuessListVC ()<SCGuessListCellDelegate>

@end

@implementation SCGuessListVC

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.m_navBar.hidden = YES;
    
    _tableView.frame = CGRectMake(0, 0, self.view.fWidth, self.view.fHeight - _topHeight);
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [_tableView registerClass:[SCGuessListCell class] forCellReuseIdentifier:[SCGuessListCell cellIdentifier]];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCGuessListCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCGuessListCell cellIdentifier] forIndexPath:indexPath];
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
    return [SCGuessListCell heightForCellWith:@1];
}

- (void)guessButtonClickedWith:(id)model isLeft:(BOOL)isLeft {
    
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
