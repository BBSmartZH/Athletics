//
//  LWScheduleVC_iPhone.m
//  Athletics
//
//  Created by 李宛 on 16/4/9.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWScheduleVC_iPhone.h"

#import "SCLargeCollectionViewCell.h"

#import "SCScheduleContentVC.h"
#import "SCTopScrollView.h"

#import "LWCustomizeVC_iPhone.h"

@interface LWScheduleVC_iPhone ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SCTopScrollViewDelegate>
{
    UICollectionView *_collectionView;
    NSMutableArray *_vcArray;
    NSMutableArray *_vcViewArray;
    
    SCTopScrollView *_topScrollView;
    BOOL _isDragging;
}

@end

@implementation LWScheduleVC_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.m_navBar.frame), self.view.fWidth, self.view.fHeight - self.m_navBar.fHeight - 49) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[SCLargeCollectionViewCell class] forCellWithReuseIdentifier:[SCLargeCollectionViewCell cellIdentifier]];
    
    
    _vcArray = [NSMutableArray array];
    _vcViewArray = [NSMutableArray array];
    
    
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarButton.frame = CGRectMake(self.navigationController.navigationBar.bounds.size.width - 30, 27, 30, 30);
    [rightBarButton addTarget:self action:@selector(rightBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [rightBarButton setTitle:@"+" forState:UIControlStateNormal];
    [rightBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBarButton.titleLabel.font = [UIFont systemFontOfSize:30.0f];
    [self.m_navBar addSubview:rightBarButton];
    
    _topScrollView = [[SCTopScrollView alloc] initWithFrame:CGRectMake(15, 27, self.view.frame.size.width - 45, 30)];
    _topScrollView.delegate = self;
    [self.m_navBar addSubview:_topScrollView];
    
    
    [self handleTitleArray];
    
}

- (void)handleTitleArray{
    [_vcViewArray removeAllObjects];
    [_vcArray removeAllObjects];
    NSMutableArray *titleArray = @[@"视频", @"关注"].mutableCopy;
    
    NSArray *followArray = ((NSArray *)[[NSUserDefaults standardUserDefaults] objectForKey:kAllChannelArrayKey]).firstObject;
    [titleArray addObjectsFromArray:followArray];
    
    
    for (int i = 0; i < titleArray.count; i++) {
        SCScheduleContentVC *contentVC = [[SCScheduleContentVC alloc] init];
        contentVC.parentVC = self;
        [_vcViewArray addObject:contentVC.view];
        [_vcArray addObject:contentVC];
    }
    
    [_topScrollView updateWithTitleArray:titleArray selectedIndex:0];
    [_collectionView reloadData];
}

-(void)rightBarButtonClicked:(UIButton *)sender {
    LWCustomizeVC_iPhone *customizeVC = [[LWCustomizeVC_iPhone alloc]init];
    _WEAKSELF(ws);
    customizeVC.editBlock = ^(BOOL result) {
        if (result) {
            [ws handleTitleArray];
        }
    };
    customizeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:customizeVC animated:YES];
    
}

- (void)topScrollButtonClicked:(SCTopButton *)sender {
    
    [_collectionView setContentOffset:CGPointMake(_collectionView.bounds.size.width * sender.index, 0) animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _vcViewArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SCLargeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SCLargeCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    
    cell.showView = [_vcViewArray objectAtIndex:indexPath.item];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.bounds.size.width, collectionView.bounds.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger pag = scrollView.contentOffset.x / scrollView.bounds.size.width;
    [_topScrollView scrollToPage:pag];
    _isDragging = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isDragging = YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_isDragging) {
        NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
        if (scrollView == _collectionView) {
            if (scrollView.contentOffset.x > 0 && scrollView.contentSize.width - scrollView.contentOffset.x - scrollView.bounds.size.width > 0) {
                float part = scrollView.contentOffset.x / scrollView.contentSize.width;
                [_topScrollView topScrollViewScrollPart:part page:page];
            }
        }
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
