//
//  SCAdView.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCAdView.h"

@interface SCAdView ()<UIScrollViewDelegate>
{
    //循环滚动的三个视图
    UIImageView * _leftImageView;
    UIImageView * _centerImageView;
    UIImageView * _rightImageView;
    
    UIView *_centerAdView;
    
    //用于确定滚动式由人导致的还是计时器到了,系统帮我们滚动的,YES,则为系统滚动,NO则为客户滚动(ps.在客户端中客户滚动一个广告后,这个广告的计时器要归0并重新计时)
    BOOL _isTimeUp;
}

@property (nonatomic,assign) NSUInteger centerImageIndex;
@property (nonatomic,assign) NSUInteger leftImageIndex;
@property (nonatomic,assign) NSUInteger rightImageIndex;
@property (assign,nonatomic,readonly) NSTimer *moveTimer;
@property (retain,nonatomic,readonly) UIImageView * leftImageView;
@property (retain,nonatomic,readonly) UIImageView * centerImageView;
@property (retain,nonatomic,readonly) UIImageView * rightImageView;

@end

@implementation SCAdView

@synthesize centerImageIndex;
@synthesize rightImageIndex;
@synthesize leftImageIndex;
@synthesize moveTimer;

#pragma mark - 自由指定广告所占的frame
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //默认滚动式3.0s
        _adMoveTime = 3.0;
        _adScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _adScrollView.bounces = NO;
        _adScrollView.delegate = self;
        _adScrollView.pagingEnabled = YES;
        _adScrollView.showsVerticalScrollIndicator = NO;
        _adScrollView.showsHorizontalScrollIndicator = NO;
        _adScrollView.backgroundColor = [UIColor whiteColor];
        _adScrollView.contentOffset = CGPointMake(_adScrollView.bounds.size.width, 0);
        _adScrollView.contentSize = CGSizeMake(_adScrollView.bounds.size.width * 3, _adScrollView.bounds.size.height);
        //该句是否执行会影响pageControl的位置,如果该应用上面有导航栏,就是用该句,否则注释掉即可
        _adScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _adScrollView.bounds.size.width, _adScrollView.bounds.size.height)];
        [_adScrollView addSubview:_leftImageView];
        
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_adScrollView.bounds.size.width, 0, _adScrollView.bounds.size.width, _adScrollView.bounds.size.height)];
        _centerImageView.userInteractionEnabled = YES;
        [_centerImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
        [_adScrollView addSubview:_centerImageView];
        
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_adScrollView.bounds.size.width*2, 0, _adScrollView.bounds.size.width, _adScrollView.bounds.size.height)];
        [_adScrollView addSubview:_rightImageView];
        
        _isNeedCycleRoll = YES;
        [self addSubview:_adScrollView];
        
        [self configPageControl];
        [self configTitleView];
        
    }
    return self;
}

- (void)configTitleView {
    //上面的灰色遮罩
    _centerAdView = [[UIView alloc] initWithFrame:CGRectMake(0, _adScrollView.bounds.size.height - 24, _adScrollView.bounds.size.width, 24)];
    _centerAdView.backgroundColor = [UIColor blackColor];
    _centerAdView.alpha = 0.6;
    [self addSubview:_centerAdView];
    [self bringSubviewToFront:_pageControl];
    
    //上面的标题
    _centerAdLabel = [[UILabel alloc]init];
    _centerAdLabel.backgroundColor = [UIColor clearColor];
    _centerAdLabel.frame = CGRectMake(10, _adScrollView.bounds.size.height - 24, _adScrollView.bounds.size.width - 20, 24);
    _centerAdLabel.textColor = [UIColor whiteColor];
    _centerAdLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:_centerAdLabel];
}

- (void)configPageControl {
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.currentPage = 0;
    _pageControl.enabled = NO;
    _pageControl.hidden = YES;
    _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:1.0 alpha:0.6];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:_pageControl];
}

//这个方法会在子视图添加到父视图或者离开父视图时调用
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    //解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
    if (!newSuperview)
    {
        [self.moveTimer invalidate];
        moveTimer = nil;
    }
    else
    {
        [self setUpTime];
    }
}

- (void)setUpTime
{
    if (_isNeedCycleRoll&&_imageLinkURL.count>=2)
    {
        moveTimer = [NSTimer scheduledTimerWithTimeInterval:_adMoveTime target:self selector:@selector(animalMoveImage:) userInfo:nil repeats:YES];
        _isTimeUp = NO;
    }
}

- (void)setIsNeedCycleRoll:(BOOL)isNeedCycleRoll
{
    _isNeedCycleRoll = isNeedCycleRoll;
    if (!_isNeedCycleRoll)
    {
        [moveTimer invalidate];
        moveTimer = nil;
    }
}

+ (instancetype)adScrollViewWithFrame:(CGRect)frame imageLinkURL:(NSArray *)imageLinkURL pageControlShowStyle:(SCPageControlShowStyle)pageControlShowStyle
{
    SCAdView * adView = [[SCAdView alloc]initWithFrame:frame];
    if (imageLinkURL.count) {
        [adView setImageLinkURL:imageLinkURL];
    }
    adView.pageControlShowStyle = pageControlShowStyle;
    return adView;
}


+ (id)adScrollViewWithFrame:(CGRect)frame imageLinkURL:(NSArray *)imageLinkURL placeHoderImage:(UIImage *)placeImage pageControlShowStyle:(SCPageControlShowStyle)pageControlShowStyle {
    
    SCAdView * adView = [[SCAdView alloc]initWithFrame:frame];
    adView.placeHoldImage = placeImage;
    if (imageLinkURL.count) {
        [adView setImageLinkURL:imageLinkURL];
    }
    adView.pageControlShowStyle = pageControlShowStyle;
    return adView;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    if (!color) {
        color = [UIColor clearColor];
    }
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 设置广告所使用的图片(名字)
- (void)setImageLinkURL:(NSArray *)imageLinkURL
{
    if (!imageLinkURL.count) {
        return;
    }
    
    _imageLinkURL = imageLinkURL;
    leftImageIndex = imageLinkURL.count-1;
    centerImageIndex = 0;
    rightImageIndex = 1;
    
    if (imageLinkURL.count==1)
    {
        _adScrollView.scrollEnabled = NO;
        rightImageIndex = 0;
    }
    _pageControl.numberOfPages = _imageLinkURL.count;
    _pageControl.currentPage = 0;
    
    UIImage *placeImage = self.placeHoldImage;
    if (!placeImage) {
        placeImage = [self imageWithColor:[UIColor colorWithWhite:0.0 alpha:0.4]];
    }
    
    [_leftImageView sd_setImageWithURL:imageLinkURL[leftImageIndex] placeholderImage:self.placeHoldImage];
    [_centerImageView sd_setImageWithURL:imageLinkURL[centerImageIndex] placeholderImage:self.placeHoldImage];
    [_rightImageView sd_setImageWithURL:imageLinkURL[rightImageIndex] placeholderImage:self.placeHoldImage];
    [self setPageControlShowStyle:self.pageControlShowStyle];
    
    if (!moveTimer) {
        [self setUpTime];
    }
}

- (void)setAdTitleStyle:(SCAdTitleShowStyle)adTitleStyle {
    if (_adTitleStyle != adTitleStyle) {
        _adTitleStyle = adTitleStyle;
        
        if(adTitleStyle == SCAdTitleShowStyleNone) {
            _centerAdLabel.hidden = YES;
            _centerAdView.hidden = YES;
        }else {
            _centerAdLabel.hidden = NO;
            _centerAdView.hidden = NO;
        }
        if (adTitleStyle == SCAdTitleShowStyleLeft) {
            _centerAdLabel.textAlignment = NSTextAlignmentLeft;
        } else if (adTitleStyle == SCAdTitleShowStyleCenter) {
            _centerAdLabel.textAlignment = NSTextAlignmentCenter;
        } else {
            _centerAdLabel.textAlignment = NSTextAlignmentRight;
        }
        
        if (centerImageIndex < _adTitleArray.count) {
            _centerAdLabel.text = _adTitleArray[centerImageIndex];
        }
    }
}

- (void)setAdTitleArray:(NSArray *)adTitleArray {
    _adTitleArray = adTitleArray;
    if (centerImageIndex < _adTitleArray.count) {
        _centerAdLabel.text = _adTitleArray[centerImageIndex];
    }
}

- (void)setPageControlShowStyle:(SCPageControlShowStyle)pageControlShowStyle {
    _pageControlShowStyle = pageControlShowStyle;
    if (pageControlShowStyle == SCPageControlShowStyleNone) {
        _pageControl.hidden = YES;
        return;
    }
    _pageControl.hidden = NO;
    
    if (_pageControlShowStyle == SCPageControlShowStyleLeft) {
        _pageControl.frame = CGRectMake(0, _adScrollView.bounds.size.height - 20, 20*_pageControl.numberOfPages, 20);
        
    } else if (_pageControlShowStyle == SCPageControlShowStyleCenter){
        _pageControl.frame = CGRectMake(0, _adScrollView.bounds.size.height - 20, 20*_pageControl.numberOfPages, 20);
        _pageControl.center = CGPointMake(_adScrollView.bounds.size.width / 2.0, _adScrollView.bounds.size.height - 30);
    } else {
        _pageControl.frame = CGRectMake( _adScrollView.bounds.size.width - 20 * _pageControl.numberOfPages, _adScrollView.bounds.size.height - 20, 20*_pageControl.numberOfPages, 20);
    }
}


#pragma mark - 计时器到时,系统滚动图片
- (void)animalMoveImage:(NSTimer *)time {
    [_adScrollView setContentOffset:CGPointMake(_adScrollView.bounds.size.width * 2, 0) animated:YES];
    _isTimeUp = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

#pragma mark - 图片停止时,调用该函数使得滚动视图复用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_adScrollView.contentOffset.x == 0) {
        centerImageIndex = centerImageIndex - 1;
        leftImageIndex = leftImageIndex - 1;
        rightImageIndex = rightImageIndex - 1;
        
        if (leftImageIndex == -1) {
            leftImageIndex = _imageLinkURL.count-1;
        }
        if (centerImageIndex == -1) {
            centerImageIndex = _imageLinkURL.count-1;
        }
        if (rightImageIndex == -1) {
            rightImageIndex = _imageLinkURL.count-1;
        }
    }else if (_adScrollView.contentOffset.x == _adScrollView.bounds.size.width * 2) {
        centerImageIndex = centerImageIndex + 1;
        leftImageIndex = leftImageIndex + 1;
        rightImageIndex = rightImageIndex + 1;
        
        if (leftImageIndex == _imageLinkURL.count) {
            leftImageIndex = 0;
        }
        if (centerImageIndex == _imageLinkURL.count) {
            centerImageIndex = 0;
        }
        if (rightImageIndex == _imageLinkURL.count) {
            rightImageIndex = 0;
        }
    }else {
        return;
    }
    
    [_leftImageView sd_setImageWithURL:_imageLinkURL[leftImageIndex] placeholderImage:self.placeHoldImage];
    [_centerImageView sd_setImageWithURL:_imageLinkURL[centerImageIndex] placeholderImage:self.placeHoldImage];
    [_rightImageView sd_setImageWithURL:_imageLinkURL[rightImageIndex] placeholderImage:self.placeHoldImage];
    _pageControl.currentPage = centerImageIndex;
    
    //有时候只有在右广告标签的时候才需要加载
    if (_adTitleArray) {
        if (centerImageIndex<=_adTitleArray.count-1) {
            _centerAdLabel.text = _adTitleArray[centerImageIndex];
        }
    }
    _adScrollView.contentOffset = CGPointMake(_adScrollView.bounds.size.width, 0);
    
    //手动控制图片滚动应该取消那个三秒的计时器
    if (!_isTimeUp) {
        [moveTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_adMoveTime]];
    }
    _isTimeUp = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [moveTimer invalidate];
    moveTimer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setUpTime];
}

/**
 *  当前显示的图片被点击
 */
-(void)tap {
    if (_tapAdCallBack) {
        _tapAdCallBack(centerImageIndex);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
