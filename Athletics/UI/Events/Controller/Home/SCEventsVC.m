//
//  SCEventsVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/11.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCEventsVC.h"

#import "SCLargeCollectionViewCell.h"

#import "SCSmallEventVC.h"

@interface SCEventsVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSMutableArray *_vcArray;
    NSMutableArray *_vcViewArray;
}

@end

static NSString *collectionCellId = @"SCLargeCollectionViewCell";

@implementation SCEventsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.m_navBar.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetHeight(self.m_navBar.frame)) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[SCLargeCollectionViewCell class] forCellWithReuseIdentifier:collectionCellId];
    
    _vcArray = [NSMutableArray array];
    _vcViewArray = [NSMutableArray array];
    
    SCSmallEventVC *smallVC1 = [[SCSmallEventVC alloc] init];
//    smallVC1.view.backgroundColor = [UIColor redColor];
    [_vcViewArray addObject:smallVC1.view];
    [_vcArray addObject:smallVC1];
    
    SCSmallEventVC *smallVC2 = [[SCSmallEventVC alloc] init];
//    smallVC2.view.backgroundColor = [UIColor greenColor];
    [_vcViewArray addObject:smallVC2.view];
    [_vcArray addObject:smallVC2];

    SCSmallEventVC *smallVC3 = [[SCSmallEventVC alloc] init];
//    smallVC3.view.backgroundColor = [UIColor blueColor];
    [_vcViewArray addObject:smallVC3.view];
    [_vcArray addObject:smallVC3];

    SCSmallEventVC *smallVC4 = [[SCSmallEventVC alloc] init];
//    smallVC4.view.backgroundColor = [UIColor cyanColor];
    [_vcViewArray addObject:smallVC4.view];
    [_vcArray addObject:smallVC4];

    _collectionView.contentSize = CGSizeMake(2000, _collectionView.bounds.size.height);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _vcViewArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SCLargeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellId forIndexPath:indexPath];
    
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
