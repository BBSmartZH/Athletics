//
//  LWNewsTabVC.m
//  Athletics
//
//  Created by 李宛 on 16/4/11.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWNewsTabVC.h"
#import "LWNewsTypeNormalCell.h"
#import "LWPhotosNormalCell.h"
#import "LWNBACell.h"
#import "LWPostsCell.h"
@interface LWNewsTabVC ()

@end
static NSString *newsTypeCell = @"newsTypeCell";
static NSString *photosCell = @"photosCell";
static NSString *NBACell = @"NBACell";
static NSString *postsCell = @"postsCell";
@implementation LWNewsTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.frame = CGRectMake(0, 49, self.view.bounds.size.width, self.view.bounds.size.height-49-64);
    _tableView.backgroundColor = [UIColor yellowColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_tableView registerClass:[LWNewsTypeNormalCell class] forCellReuseIdentifier:newsTypeCell];
    [_tableView registerClass:[LWPhotosNormalCell class] forCellReuseIdentifier:photosCell];
    [_tableView registerClass:[LWNBACell class] forCellReuseIdentifier:NBACell];
    [_tableView registerClass:[LWPostsCell class] forCellReuseIdentifier:postsCell];
    [_tableView reloadData];
    
}
-(instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        LWNBACell *cell = [tableView dequeueReusableCellWithIdentifier:NBACell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configLayoutWithModel:@1];
        return cell;
        
    }else if(indexPath.section ==1){
        LWNewsTypeNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:newsTypeCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configLayoutWithModel:@1];
        
        return cell;

    }else if(indexPath.section == 2){
        LWPhotosNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:photosCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configLayoutWithModel:@1];
        
        return cell;
    }else if (indexPath.section == 3){
        LWPostsCell *cell = [tableView dequeueReusableCellWithIdentifier:postsCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configLayoutWithModel:@1];
        return cell;
        
    }
        
    return NULL;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [LWNBACell heightForRow];
    }else if (indexPath.section == 1) {
        return [LWNewsTypeNormalCell heightForRow];
    }else if(indexPath.section == 2){
        return [LWPhotosNormalCell heightForRowWithPhotosWithCounts:3];
    }else if (indexPath.section == 3){
        return [LWPostsCell heightForRowWithImageCounts:0];
    }
    
    return 100;
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
