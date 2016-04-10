//
//  LWCustomizeVC_iPhone.m
//  Athletics
//
//  Created by 李宛 on 16/4/10.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWCustomizeVC_iPhone.h"
#import "XWDragCellCollectionView.h"
@interface LWCustomizeVC_iPhone ()<XWDragCellCollectionViewDataSource,XWDragCellCollectionViewDelegate>

@property(nonatomic,strong)NSArray *data;
@property(nonatomic,strong)NSArray *colorsArray ;
@property(nonatomic,weak)XWDragCellCollectionView *mainView;
@end

@implementation LWCustomizeVC_iPhone

static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"频道定制";
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake((self.view.bounds.size.width-50)/3.0,(self.view.bounds.size.width-50)/3 );
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    XWDragCellCollectionView *mainView = [[XWDragCellCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _mainView = mainView;
    mainView.delegate = self;
    mainView.dataSource = self;
    mainView.shakeLevel = 3.0f;
    mainView.backgroundColor = [UIColor whiteColor];
    [mainView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    调用方法
    [_mainView xw_enterEditingModel];

    self.colorsArray = @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor orangeColor], [UIColor greenColor]];
    [self.view addSubview:mainView];


}

- (NSArray *)data{
    if (!_data) {
        NSMutableArray *temp = [NSMutableArray array];
        for (int i = 0; i < 10; i ++) {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            [temp addObject:str];
        }
        _data = [NSArray arrayWithArray:temp];
    }
    return _data;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = self.colorsArray[indexPath.item%3];
    return cell;
}

- (NSArray *)dataSourceArrayOfCollectionView:(XWDragCellCollectionView *)collectionView{
    return _data;
}
#pragma mark - <XWDragCellCollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    XWCellModel *model = _data[indexPath.section][indexPath.item];
//    NSLog(@"点击了%@",model.title);
}

- (void)dragCellCollectionView:(XWDragCellCollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray{
    _data = newDataArray;
}

- (void)dragCellCollectionView:(XWDragCellCollectionView *)collectionView cellWillBeginMoveAtIndexPath:(NSIndexPath *)indexPath{
    //拖动时候最后禁用掉编辑按钮的点击
//    _editButton.enabled = NO;
}

- (void)dragCellCollectionViewCellEndMoving:(XWDragCellCollectionView *)collectionView{
//    _editButton.enabled = YES;
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
