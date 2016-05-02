//
//  SCNewsImageVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/16.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNewsImageVC.h"

#import "SCPhotosScrollView.h"
#import "SCPhotoZoomView.h"
#import "SCNewsDetailModel.h"

#import "SCPhotoCollectionViewCell.h"
#import "SCNewsPhotosPackVC.h"

@interface SCNewsImageVC ()<UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    SCPhotosScrollView *_scrollView;
    
    UICollectionView *_collectionView;
    
    CGRect imageFrameRect;
    NSInteger _number;
    CGFloat _offset;
    float _scale;
    BOOL   _isLarge;
    BOOL   _isHidden;
    UIView *_titleView;
    UILabel *_titleLabel;
    
    NSMutableArray *_imageArray;
    NSMutableArray *_textArray;
    SCNewsDetailDataModel *_model;

}

@end

static CGFloat imageSpace = 10.0f;

@implementation SCNewsImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.m_navBar.hidden = YES;
    
//    _imageArray = @[@"http://img.dota2.com.cn/dota2/1d/a3/1da37587e354ec6e9b6d4f9722ae6be61461641722.jpg", @"http://img.dota2.com.cn/dota2/e1/1f/e11f335e2689860cbd14ae0ef0ece64b1461641722.jpg"];
//    _textArray = @[@"6.87更新日志中有诸多内容亟待您的探索。", @"随着更新的发布，本周还将见证马尼拉特级锦标赛预选赛的开锣，中国区预选赛比赛报名时间为2016年4月26日 至 2016年4月30日，比赛时间为4月29日-5月2日。"];
//    _number = _imageArray.count;
    
    _imageArray = [NSMutableArray array];
    _textArray = [NSMutableArray array];
    
    _offset = 0.0;
    _scale = 1.0;
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.fWidth + imageSpace, self.view.fHeight) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    self.view.clipsToBounds = YES;
    
    [_collectionView registerClass:[SCPhotoCollectionViewCell class] forCellWithReuseIdentifier:[SCPhotoCollectionViewCell cellIdentifier]];
    
    UITapGestureRecognizer *clickTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleClickTap:)];
    [clickTap setNumberOfTapsRequired:1];
    [_collectionView addGestureRecognizer:clickTap];
    
    _titleView = [[UIView alloc] init];
    _titleView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    _titleView.hidden = YES;
    [self.view addSubview:_titleView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [_titleView addSubview:_titleLabel];
    
    _titleLabel.text = [_textArray firstObject];
    
    _WEAKSELF(ws);
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.view);
        make.bottom.equalTo(_collectionView.mas_bottom).offset(-44);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_titleView);
        make.left.top.equalTo(_titleView).offset(10);
        make.right.bottom.equalTo(_titleView).offset(-10);
    }];
    
    [self prepareData];
    
}

- (void)prepareData {
    
    [self startActivityAnimation];
    self.sessionTask = [SCNetwork newsInfoWithNewsId:_newsId success:^(SCNewsDetailModel *model) {
        [self stopActivityAnimation];
        _model = model.data;
        [self.parentVC setCommentNum:[SCGlobaUtil isEmpty:_model.commentNum] ? @"0" : _model.commentNum];
        for (int i = 0; i < _model.contents.count; i++) {
            SCContentListModel *content = [_model.contents objectAtIndex:i];
            if ([SCGlobaUtil getInt:content.type] == 3) {
                [_imageArray addObject:content.image.url];
            }
            if ([SCGlobaUtil getInt:content.type] == 1) {
                [_textArray addObject:content.content];
            }
            if (_textArray.count > 0) {
                _titleView.hidden = NO;
            }
        }
        [_collectionView reloadData];
    } message:^(NSString *resultMsg) {
        [self postMessage:resultMsg];
        [self stopActivityAnimation];
    }];
    
}

- (void)handleClickTap:(UIGestureRecognizer *)gesture {
    if (!_isHidden) {
        _isHidden = YES;
        [UIView animateWithDuration:0.25 animations:^{
            _titleView.alpha = 0.0f;
        }];
    }else {
        _isHidden = NO;
        [UIView animateWithDuration:0.25 animations:^{
            _titleView.alpha = 1.0f;
        }];
    }
    if (_tapBlock) {
        _tapBlock(_isHidden);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SCPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SCPhotoCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    [cell revertZoom];
    [cell setZoomInset:UIEdgeInsetsMake(0, 0, 0, imageSpace)];
    cell.photoUrl = [_imageArray objectAtIndex:indexPath.item];
    
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
    if (scrollView == _collectionView) {
        NSInteger pag = scrollView.contentOffset.x / scrollView.bounds.size.width;
        if (pag < _textArray.count) {
            _titleView.hidden = NO;
            _titleLabel.text = [_textArray objectAtIndex:pag];
        }else {
            _titleView.hidden = YES;
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
