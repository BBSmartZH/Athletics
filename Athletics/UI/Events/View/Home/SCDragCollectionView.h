//
//  SCDragCollectionView.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/11.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCDragCollectionView;
@protocol SCDragCollectionViewDelegate <UICollectionViewDelegate>

@required
/**
 *  当数据源更新的到时候调用，必须实现，需将新的数据源设置为当前tableView的数据源(例如 :_data = newDataArray)
 *  @param newDataArray   更新后的数据源
 */
- (void)dragCellCollectionView:(SCDragCollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray;

@optional

/**
 *  某个cell将要开始移动的时候调用
 *  @param indexPath      该cell当前的indexPath
 */
- (void)dragCellCollectionView:(SCDragCollectionView *)collectionView cellWillBeginMoveAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  某个cell正在移动的时候
 */
- (void)dragCellCollectionViewCellisMoving:(SCDragCollectionView *)collectionView;
/**
 *  cell移动完毕，并成功移动到新位置的时候调用
 */
- (void)dragCellCollectionViewCellEndMoving:(SCDragCollectionView *)collectionView;
/**
 *  成功交换了位置的时候调用
 *  @param fromIndexPath    交换cell的起始位置
 *  @param toIndexPath      交换cell的新位置
 */
- (void)dragCellCollectionView:(SCDragCollectionView *)collectionView moveCellFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;

@end

@protocol SCDragCollectionViewDatasource <UICollectionViewDataSource>

@required
/**
 *  返回整个CollectionView的数据，必须实现，需根据数据进行移动后的数据重排
 */
- (NSArray *)dataSourceArrayOfCollectionView:(SCDragCollectionView *)collectionView;

@end




@interface SCDragCollectionView : UICollectionView

@property (nonatomic, assign) id<SCDragCollectionViewDelegate> delegate;

@property (nonatomic, assign) id<SCDragCollectionViewDatasource> dataSource;

/**长按多少秒触发拖动手势，默认1秒，如果设置为0，表示手指按下去立刻就触发拖动*/
@property (nonatomic, assign) NSTimeInterval minimumPressDuration;

@end
