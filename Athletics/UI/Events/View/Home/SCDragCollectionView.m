//
//  SCDragCollectionView.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/11.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCDragCollectionView.h"

typedef NS_ENUM(NSUInteger, SCDragCollectionViewScrollDirection) {
    SCDragectionViewScrollDirectionNone = 0,
    SCDragCollectionViewScrollDirectionLeft,
    DragCollectionViewScrollDirectionRight,
    SCDragCollectionViewScrollDirectionUp,
    SCDragCollectionViewScrollDirectionDown
};

@interface SCDragCollectionView ()

@property (nonatomic, strong) NSIndexPath *originalIndexPath;
@property (nonatomic, strong) NSIndexPath *moveIndexPath;
@property (nonatomic, weak) UIView *tempMoveCell;
@property (nonatomic, weak) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, strong) CADisplayLink *edgeTimer;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, assign) SCDragCollectionViewScrollDirection scrollDirection;

@end

@implementation SCDragCollectionView

@dynamic delegate;
@dynamic dataSource;

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self initializeProperty];
        [self addGesture];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initializeProperty];
        [self addGesture];
    }
    return self;
}

- (void)initializeProperty {
    _minimumPressDuration = 0.75;
}


#pragma mark - longPressGesture methods

/**
 *  添加一个自定义的长按手势
 */
- (void)addGesture {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    _longPressGesture = longPress;
    longPress.minimumPressDuration = _minimumPressDuration;
    [self addGestureRecognizer:longPress];
}

/**
 *  监听手势的改变
 */
- (void)longPressed:(UILongPressGestureRecognizer *)longPressGesture{
    if (longPressGesture.state == UIGestureRecognizerStateBegan) {
        [self gestureBegan:longPressGesture];
    }
    if (longPressGesture.state == UIGestureRecognizerStateChanged) {
        [self gestureChange:longPressGesture];
    }
    if (longPressGesture.state == UIGestureRecognizerStateCancelled ||
        longPressGesture.state == UIGestureRecognizerStateEnded){
        [self gestureEndOrCancle:longPressGesture];
    }
}

/**
 *  手势开始
 */
- (void)gestureBegan:(UILongPressGestureRecognizer *)longPressGesture{
    //获取手指所在的cell
    _originalIndexPath = [self indexPathForItemAtPoint:[longPressGesture locationOfTouch:0 inView:longPressGesture.view]];
    if (_originalIndexPath.section != 0) {
        return;
    }
    UICollectionViewCell *cell = [self cellForItemAtIndexPath:_originalIndexPath];
    UIView *tempMoveCell = [cell snapshotViewAfterScreenUpdates:NO];
    cell.hidden = YES;
    _tempMoveCell = tempMoveCell;
    _tempMoveCell.frame = cell.frame;
    [self addSubview:_tempMoveCell];
    [UIView animateWithDuration:0.25 animations:^{
        _tempMoveCell.transform = CGAffineTransformMakeScale(1.18, 1.18);
    }];
    
    //开启边缘滚动定时器
    [self setEdgeTimer];
    
    _lastPoint = [longPressGesture locationOfTouch:0 inView:longPressGesture.view];
    //通知代理
    if ([self.delegate respondsToSelector:@selector(dragCellCollectionView:cellWillBeginMoveAtIndexPath:)]) {
        [self.delegate dragCellCollectionView:self cellWillBeginMoveAtIndexPath:_originalIndexPath];
    }
}
/**
 *  手势拖动
 */
- (void)gestureChange:(UILongPressGestureRecognizer *)longPressGesture{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(dragCellCollectionViewCellisMoving:)]) {
        [self.delegate dragCellCollectionViewCellisMoving:self];
    }
    CGFloat tranX = [longPressGesture locationOfTouch:0 inView:longPressGesture.view].x - _lastPoint.x;
    CGFloat tranY = [longPressGesture locationOfTouch:0 inView:longPressGesture.view].y - _lastPoint.y;
    _tempMoveCell.center = CGPointApplyAffineTransform(_tempMoveCell.center, CGAffineTransformMakeTranslation(tranX, tranY));
    _lastPoint = [longPressGesture locationOfTouch:0 inView:longPressGesture.view];
    [self moveCell];
}

/**
 *  手势取消或者结束
 */
- (void)gestureEndOrCancle:(UILongPressGestureRecognizer *)longPressGesture{
    UICollectionViewCell *cell = [self cellForItemAtIndexPath:_originalIndexPath];
    self.userInteractionEnabled = NO;
    [self stopEdgeTimer];
    //通知代理
    if ([self.delegate respondsToSelector:@selector(dragCellCollectionViewCellEndMoving:)]) {
        [self.delegate dragCellCollectionViewCellEndMoving:self];
    }
    [UIView animateWithDuration:0.25 animations:^{
        _tempMoveCell.center = cell.center;
        _tempMoveCell.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [_tempMoveCell removeFromSuperview];
        cell.hidden = NO;
        self.userInteractionEnabled = YES;
    }];
}

#pragma mark - timer methods

- (void)setEdgeTimer{
    if (!_edgeTimer) {
        _edgeTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(edgeScroll)];
        [_edgeTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)stopEdgeTimer{
    if (_edgeTimer) {
        [_edgeTimer invalidate];
        _edgeTimer = nil;
    }
}


#pragma mark - private methods

- (void)moveCell{
    for (UICollectionViewCell *cell in [self visibleCells]) {
        if ([self indexPathForCell:cell] == _originalIndexPath) {
            continue;
        }
        //计算中心距
        CGFloat spacingX = fabs(_tempMoveCell.center.x - cell.center.x);
        CGFloat spacingY = fabs(_tempMoveCell.center.y - cell.center.y);
        if (spacingX <= _tempMoveCell.bounds.size.width / 2.0f && spacingY <= _tempMoveCell.bounds.size.height / 2.0f) {
            _moveIndexPath = [self indexPathForCell:cell];
            //更新数据源
            [self updateDataSource];
            //移动
            [self moveItemAtIndexPath:_originalIndexPath toIndexPath:_moveIndexPath];
            //通知代理
            if ([self.delegate respondsToSelector:@selector(dragCellCollectionView:moveCellFromIndexPath:toIndexPath:)]) {
                [self.delegate dragCellCollectionView:self moveCellFromIndexPath:_originalIndexPath toIndexPath:_moveIndexPath];
            }
            //设置移动后的起始indexPath
            _originalIndexPath = _moveIndexPath;
            break;
        }
    }
}

/**
 *  更新数据源
 */
- (void)updateDataSource{
    NSMutableArray *temp = @[].mutableCopy;
    //获取数据源
    if ([self.dataSource respondsToSelector:@selector(dataSourceArrayOfCollectionView:)]) {
        [temp addObjectsFromArray:[self.dataSource dataSourceArrayOfCollectionView:self]];
    }
    //判断数据源是单个数组还是数组套数组的多section形式，YES表示数组套数组
    BOOL dataTypeCheck = ([self numberOfSections] != 1 || ([self numberOfSections] == 1 && [temp[0] isKindOfClass:[NSArray class]]));
    if (dataTypeCheck) {
        for (int i = 0; i < temp.count; i ++) {
            [temp replaceObjectAtIndex:i withObject:[temp[i] mutableCopy]];
        }
    }
    if (_moveIndexPath.section == _originalIndexPath.section) {
        NSMutableArray *orignalSection = dataTypeCheck ? temp[_originalIndexPath.section] : temp;
        if (_moveIndexPath.item > _originalIndexPath.item) {
            for (NSUInteger i = _originalIndexPath.item; i < _moveIndexPath.item ; i ++) {
                [orignalSection exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
            }
        }else{
            for (NSUInteger i = _originalIndexPath.item; i > _moveIndexPath.item ; i --) {
                [orignalSection exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
            }
        }
    }else{
        NSMutableArray *orignalSection = temp[_originalIndexPath.section];
        NSMutableArray *currentSection = temp[_moveIndexPath.section];
        [currentSection insertObject:orignalSection[_originalIndexPath.item] atIndex:_moveIndexPath.item];
        [orignalSection removeObject:orignalSection[_originalIndexPath.item]];
    }
    //将重排好的数据传递给外部
    if ([self.delegate respondsToSelector:@selector(dragCellCollectionView:newDataArrayAfterMove:)]) {
        [self.delegate dragCellCollectionView:self newDataArrayAfterMove:temp.copy];
    }
}

- (void)edgeScroll{
    [self setScrollDirection];
    switch (_scrollDirection) {
        case SCDragCollectionViewScrollDirectionLeft:{
            //这里的动画必须设为NO
            [self setContentOffset:CGPointMake(self.contentOffset.x - 4, self.contentOffset.y) animated:NO];
            _tempMoveCell.center = CGPointMake(_tempMoveCell.center.x - 4, _tempMoveCell.center.y);
            _lastPoint.x -= 4;
            
        }
            break;
        case DragCollectionViewScrollDirectionRight:{
            [self setContentOffset:CGPointMake(self.contentOffset.x + 4, self.contentOffset.y) animated:NO];
            _tempMoveCell.center = CGPointMake(_tempMoveCell.center.x + 4, _tempMoveCell.center.y);
            _lastPoint.x += 4;
            
        }
            break;
        case SCDragCollectionViewScrollDirectionUp:{
            [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y - 4) animated:NO];
            _tempMoveCell.center = CGPointMake(_tempMoveCell.center.x, _tempMoveCell.center.y - 4);
            _lastPoint.y -= 4;
        }
            break;
        case SCDragCollectionViewScrollDirectionDown:{
            [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y + 4) animated:NO];
            _tempMoveCell.center = CGPointMake(_tempMoveCell.center.x, _tempMoveCell.center.y + 4);
            _lastPoint.y += 4;
        }
            break;
        default:
            break;
    }
    
}

- (void)setScrollDirection {
    _scrollDirection = SCDragectionViewScrollDirectionNone;
    if (self.bounds.size.height + self.contentOffset.y - _tempMoveCell.center.y < _tempMoveCell.bounds.size.height / 2 && self.bounds.size.height + self.contentOffset.y < self.contentSize.height) {
        _scrollDirection = SCDragCollectionViewScrollDirectionDown;
    }
    if (_tempMoveCell.center.y - self.contentOffset.y < _tempMoveCell.bounds.size.height / 2 && self.contentOffset.y > 0) {
        _scrollDirection = SCDragCollectionViewScrollDirectionUp;
    }
    if (self.bounds.size.width + self.contentOffset.x - _tempMoveCell.center.x < _tempMoveCell.bounds.size.width / 2 && self.bounds.size.width + self.contentOffset.x < self.contentSize.width) {
        _scrollDirection = DragCollectionViewScrollDirectionRight;
    }
    
    if (_tempMoveCell.center.x - self.contentOffset.x < _tempMoveCell.bounds.size.width / 2 && self.contentOffset.x > 0) {
        _scrollDirection = SCDragCollectionViewScrollDirectionLeft;
    }
}


@end
