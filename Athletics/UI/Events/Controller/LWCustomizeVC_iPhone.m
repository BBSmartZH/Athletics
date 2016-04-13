//
//  LWCustomizeVC_iPhone.m
//  Athletics
//
//  Created by 李宛 on 16/4/10.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWCustomizeVC_iPhone.h"
#import "XWDragCellCollectionView.h"

#import "SCDragCollectionView.h"

#import "SCDragCollectionViewCell.h"

//@interface LWCustomizeVC_iPhone ()<XWDragCellCollectionViewDataSource,XWDragCellCollectionViewDelegate>
@interface LWCustomizeVC_iPhone ()<SCDragCollectionViewDelegate,SCDragCollectionViewDatasource>

@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)NSArray *colorsArray ;
//@property(nonatomic,weak)XWDragCellCollectionView *mainView;
@property(nonatomic,weak)SCDragCollectionView *mainView;

@end

@implementation LWCustomizeVC_iPhone

static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"频道定制";
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake((self.view.bounds.size.width-50)/3.0,(self.view.bounds.size.width-50)/3 );
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
//    XWDragCellCollectionView *mainView = [[XWDragCellCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
//    _mainView = mainView;
//    mainView.delegate = self;
//    mainView.dataSource = self;
//    mainView.shakeLevel = 3.0f;
//    mainView.backgroundColor = [UIColor whiteColor];
//    [mainView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    调用方法
//    [_mainView xw_enterEditingModel];
    
    SCDragCollectionView *mainView = [[SCDragCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _mainView = mainView;
    mainView.delegate = self;
    mainView.dataSource = self;
    mainView.backgroundColor = [UIColor whiteColor];
//    [mainView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [mainView registerClass:[SCDragCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    self.colorsArray = @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor orangeColor], [UIColor greenColor]];
    [self.view addSubview:mainView];
    
    
    

}

- (NSArray *)data{
    if (!_data) {
        
        NSArray *titleDataArray = [[NSUserDefaults standardUserDefaults] objectForKey:kAllChannelArrayKey];
        _data = titleDataArray.mutableCopy;
    }
    return _data;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.data.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return ((NSArray *)[self.data objectAtIndex:section]).count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SCDragCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.title = [((NSArray *)[_data objectAtIndex:indexPath.section]) objectAtIndex:indexPath.item];
    
    cell.contentView.backgroundColor = self.colorsArray[indexPath.item%3];
    return cell;
}


- (NSArray *)dataSourceArrayOfCollectionView:(SCDragCollectionView *)collectionView{
    return _data;
}

- (void)dragCellCollectionView:(SCDragCollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray{
    _data = newDataArray.mutableCopy;
    
    [[NSUserDefaults standardUserDefaults] setObject:newDataArray forKey:kAllChannelArrayKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (_editBlock) {
        _editBlock(YES);
    }
}

- (void)dragCellCollectionView:(SCDragCollectionView *)collectionView cellWillBeginMoveAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)dragCellCollectionViewCellEndMoving:(SCDragCollectionView *)collectionView{
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSMutableArray *sectionArray0 = [[_data objectAtIndex:0] mutableCopy];
        if (sectionArray0.count <= 1) {
            NSLog(@"亲，留一个吧~~");
            return;
        }
        NSMutableArray *sectionArray1 = [[_data objectAtIndex:1] mutableCopy];
        [sectionArray1 addObject:[sectionArray0 objectAtIndex:indexPath.item]];
        
        [sectionArray0 removeObjectAtIndex:indexPath.item];
        
        _data = @[sectionArray0, sectionArray1].mutableCopy;
        
        [[NSUserDefaults standardUserDefaults] setObject:_data forKey:kAllChannelArrayKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (_editBlock) {
            _editBlock(YES);
        }
        
        [collectionView reloadData];
    }else if (indexPath.section == 1) {
        NSMutableArray *sectionArray1 = [[_data objectAtIndex:1] mutableCopy];

        NSMutableArray *sectionArray0 = [[_data objectAtIndex:0] mutableCopy];
        [sectionArray0 addObject:[sectionArray1 objectAtIndex:indexPath.item]];
        
        [sectionArray1 removeObjectAtIndex:indexPath.item];
        _data = @[sectionArray0, sectionArray1].mutableCopy;
        
        [[NSUserDefaults standardUserDefaults] setObject:_data forKey:kAllChannelArrayKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (_editBlock) {
            _editBlock(YES);
        }
        
        [collectionView reloadData];
    }
}

#pragma mark - <XWDragCellCollectionViewDelegate>

//- (NSArray *)dataSourceArrayOfCollectionView:(XWDragCellCollectionView *)collectionView{
//    return _data;
//}


//- (void)dragCellCollectionView:(XWDragCellCollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray{
//    _data = newDataArray;
//}
//
//- (void)dragCellCollectionView:(XWDragCellCollectionView *)collectionView cellWillBeginMoveAtIndexPath:(NSIndexPath *)indexPath{
//    
//}
//
//- (void)dragCellCollectionViewCellEndMoving:(XWDragCellCollectionView *)collectionView{
//    
//}


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
