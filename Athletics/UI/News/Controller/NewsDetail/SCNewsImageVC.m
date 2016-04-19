//
//  SCNewsImageVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/16.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNewsImageVC.h"

#import "SCCommentListVC.h"
#import "SCPhotosScrollView.h"
#import "SCPhotoZoomView.h"

#import "SCPhotoCollectionViewCell.h"

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
    
    //Test
    NSArray *_imageArray;
    NSArray *_textArray;
}

@end

static CGFloat imageSpace = 10.0f;

@implementation SCNewsImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.m_navBar.hidden = YES;
    
    _imageArray = @[@"http://pic14.nipic.com/20110522/7411759_164157418126_2.jpg", @"http://inews.gtimg.com/newsapp_match/0/253743855/0", @"http://inews.gtimg.com/newsapp_match/0/253743856/0", @"http://inews.gtimg.com/newsapp_match/0/253743857/0", @"http://inews.gtimg.com/newsapp_match/0/253743858/0", @"http://inews.gtimg.com/newsapp_match/0/253743855/0", @"http://inews.gtimg.com/newsapp_match/0/253743856/0"];
    _textArray = @[@"aksnsanda", @"腾讯体育4月16日讯 湖人在科比退役时赠送给科比和瓦妮莎两枚退役戒指，戒指上刻着科比的名字，两侧则是20年和黑曼巴的图样，简直太奢华。", @"两枚戒指闪闪发光，都刻着科比-布莱恩特的名字。", @"在总冠军奖杯的前面刻着湖人的字样。", @"戒指的侧面是黑曼巴的字样，刻着2006-2016，这是科比改穿24号的十年。", @"另一侧刻着1996-2005，这是科比穿8号的十年，很有纪念意义。", @"看上去甚至比总冠军戒指还要奢华。"];
    _number = _imageArray.count;
    
    _offset = 0.0;
    _scale = 1.0;
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.fWidth + 10, self.view.fHeight) collectionViewLayout:layout];
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
        _titleLabel.text = [_textArray objectAtIndex:pag];
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
