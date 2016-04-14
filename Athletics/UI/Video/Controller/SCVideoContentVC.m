//
//  SCVideoContentVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCVideoContentVC.h"

#import "SCVideoCell.h"

@interface SCVideoContentVC ()
{
    UIView *_selectedView;
}

@end

@implementation SCVideoContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.m_navBar.hidden = YES;
    
    _selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.fWidth, 44)];
    _selectedView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_selectedView];
    
    [_tableView registerClass:[SCVideoCell class] forCellReuseIdentifier:[SCVideoCell cellIdentifier]];
    
    _tableView.frame = CGRectMake(0, _selectedView.bottom, self.view.fWidth, self.view.fHeight - self.m_navBar.fHeight - _selectedView.fHeight - 49);
    _tableView.separatorColor = k_Border_Color;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    
    [_tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCVideoCell cellIdentifier] forIndexPath:indexPath];
    [cell createLayoutWith:@1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView fd_heightForCellWithIdentifier:[SCVideoCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SCVideoCell *cell) {
        [cell createLayoutWith:@1];
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
