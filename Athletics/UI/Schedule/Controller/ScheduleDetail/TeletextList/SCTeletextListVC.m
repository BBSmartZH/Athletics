//
//  SCTeletextListVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCTeletextListVC.h"
#import "SCTeletexListCell.h"
@interface SCTeletextListVC ()

@end

@implementation SCTeletextListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.m_navBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor clearColor];
    
    _tableView.frame = CGRectMake(0, 0, self.view.fWidth, self.view.fHeight - _topHeight);
    [_tableView registerClass:[SCTeletexListCell class] forCellReuseIdentifier:[SCTeletexListCell cellIdentifier]];
}

- (void)upDateData {
    [self refreshData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCTeletexListCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCTeletexListCell cellIdentifier]forIndexPath:indexPath];
    if (!cell) {
        cell = [[SCTeletexListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[SCTeletexListCell cellIdentifier]];
    }
    
    [cell creatLayoutWith:@1];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:[SCTeletexListCell cellIdentifier] configuration:^(id cell) {
        [cell creatLayoutWith:@1];
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
