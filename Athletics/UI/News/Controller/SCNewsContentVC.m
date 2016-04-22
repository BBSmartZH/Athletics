//
//  SCNewsContentVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNewsContentVC.h"

#import "SCAdView.h"
#import "SCNewsCell.h"
#import "LWPhotosNormalCell.h"
#import "SCNewsPhotosPackVC.h"
#import "SCNewsArticlePackVC.h"

@interface SCNewsContentVC ()
{
    SCAdView *_adView;
    BOOL _needUpdate;
}

@end

@implementation SCNewsContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.m_navBar.hidden = YES;
    
    _needUpdate = YES;
    
    [_tableView registerClass:[SCNewsCell class] forCellReuseIdentifier:[SCNewsCell cellIdentifier]];
    [_tableView registerClass:[LWPhotosNormalCell class] forCellReuseIdentifier:[LWPhotosNormalCell cellIdentifier]];

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
    
    NSArray *imagesURL = @[
                           @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                           @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                           @"http://pic14.nipic.com/20110522/7411759_164157418126_2.jpg"
                           ];
    
    NSArray *titles = @[@"感谢您的支持，如果下载的",
                        @"代码在使用过程中出现问题",
                        @"您可以发邮件到qzycoder@163.com",
                        ];
    
    _adView.adTitleArray = titles;
    _adView.imageLinkURL = imagesURL;
    
    
}

- (BOOL)isUpdated {
    return !_needUpdate;
}

- (void)updateData {
    [self headerBeginRefreshing];
    
}

- (void)refreshData {
    _needUpdate = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self headerEndRefreshing];
        
        [_tableView reloadData];

        _needUpdate = YES;
    });
}

- (void)loadModeData {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row % 2 == 0) {
        SCNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[SCNewsCell cellIdentifier] forIndexPath:indexPath];
        [cell createLayoutWith:@1];
        return cell;
    }
    LWPhotosNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:[LWPhotosNormalCell cellIdentifier] forIndexPath:indexPath];
    [cell createLayoutWith:@1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return [tableView fd_heightForCellWithIdentifier:[SCNewsCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SCNewsCell *cell) {
            [cell createLayoutWith:@1];
        }];
    }
//    return [tableView fd_heightForCellWithIdentifier:[LWPhotosNormalCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(LWPhotosNormalCell *cell) {
//        [cell createLayoutWith:@1];
//    }];
    return [LWPhotosNormalCell heightForRowWithPhotosWithCounts:2];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row % 2 == 0) {
        SCNewsArticlePackVC *articleVC = [[SCNewsArticlePackVC alloc] init];
        articleVC.hidesBottomBarWhenPushed = YES;
        [self.parentVC.navigationController pushViewController:articleVC animated:YES];
    }else {
        SCNewsPhotosPackVC *photosVC = [[SCNewsPhotosPackVC alloc] init];
        photosVC.hidesBottomBarWhenPushed = YES;
        [self.parentVC.navigationController pushViewController:photosVC animated:YES];
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
