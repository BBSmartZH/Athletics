//
//  SCScheduleContentVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCScheduleContentVC.h"

#import "SCAdView.h"
#import "SCNewsCell.h"

@interface SCScheduleContentVC ()
{
    SCAdView *_adView;
}

@end

@implementation SCScheduleContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.m_navBar.hidden = YES;
    
    
    [_tableView registerClass:[SCNewsCell class] forCellReuseIdentifier:[SCNewsCell cellIdentifier]];
    
    _tableView.frame = CGRectMake(0, 0, self.view.fWidth, self.view.fHeight - self.m_navBar.fHeight - 49);
    _tableView.separatorColor = k_Border_Color;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    _adView = [[SCAdView alloc] initWithFrame:CGRectMake(0, 0, _tableView.fWidth, _tableView.fWidth * 0.4)];
    _adView.placeHoldImage = [UIImage imageNamed:@"place"];
    _adView.pageControlShowStyle = SCPageControlShowStyleRight;
    _adView.adTitleStyle = SCAdTitleShowStyleLeft;
    _adView.tapAdCallBack = ^(NSInteger index) {
        NSLog(@"%ld", (long)index);
    };
    _tableView.tableHeaderView = _adView;
    
    
    [_tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCNewsCell cellIdentifier] forIndexPath:indexPath];
    [cell createLayoutWith:@1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:[SCNewsCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SCNewsCell *cell) {
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
