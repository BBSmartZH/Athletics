//
//  SCPhotosScrollView.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCPhotosScrollView.h"
#import "SCPhotoZoomView.h"

@interface SCPhotosScrollView ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    CGFloat _currentOffSet;
    BOOL _isLeftScroll;
}
@property (nonatomic,assign) NSUInteger centerZoomIndex;
@property (nonatomic,assign) NSUInteger leftZoomIndex;
@property (nonatomic,assign) NSUInteger rightZoomIndex;
@property (retain,nonatomic,readonly) SCPhotoZoomView * leftZoomView;
@property (retain,nonatomic,readonly) SCPhotoZoomView * centerZoomView;
@property (retain,nonatomic,readonly) SCPhotoZoomView * rightZoomView;

@end

@implementation SCPhotosScrollView

@synthesize centerZoomIndex;
@synthesize leftZoomIndex;
@synthesize rightZoomIndex;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
        _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width * 3, _scrollView.bounds.size.height);
        //该句是否执行会影响pageControl的位置,如果该应用上面有导航栏,就是用该句,否则注释掉即可
        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _leftZoomView = [[SCPhotoZoomView alloc]initWithFrame:CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
        _leftZoomView.backgroundColor = [UIColor blackColor];
        [_scrollView addSubview:_leftZoomView];
        
        _centerZoomView = [[SCPhotoZoomView alloc]initWithFrame:CGRectMake(_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
        _centerZoomView.backgroundColor = [UIColor blackColor];
        [_scrollView addSubview:_centerZoomView];
        
        _rightZoomView = [[SCPhotoZoomView alloc]initWithFrame:CGRectMake(_scrollView.bounds.size.width*2, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
        _rightZoomView.backgroundColor = [UIColor blackColor];
        [_scrollView addSubview:_rightZoomView];
        
        [self addSubview:_scrollView];
        
    }
    return self;
}

- (void)setPicUrls:(NSArray<NSString *> *)picUrls {
    if (_picUrls != picUrls) {
        _picUrls = picUrls;
        
        if (!_picUrls.count) {
            return;
        }
        
        leftZoomIndex = _picUrls.count-1;
        centerZoomIndex = 0;
        rightZoomIndex = 1;
        
        if (_picUrls.count == 1) {
            [_leftZoomView setNetWorkImageWithUrl:_picUrls[centerZoomIndex]];
            [_scrollView setContentSize:CGSizeMake(_scrollView.bounds.size.width, _scrollView.bounds.size.height)];
        }else if (_picUrls.count == 2) {
            [_leftZoomView setNetWorkImageWithUrl:_picUrls[centerZoomIndex]];
            [_centerZoomView setNetWorkImageWithUrl:_picUrls[rightZoomIndex]];
            [_scrollView setContentSize:CGSizeMake(_scrollView.bounds.size.width * 2, _scrollView.bounds.size.height)];
            _scrollView.contentOffset = CGPointMake(0, 0);
        }else {
            [_leftZoomView setNetWorkImageWithUrl:_picUrls[centerZoomIndex]];
            [_centerZoomView setNetWorkImageWithUrl:_picUrls[rightZoomIndex]];
            [_scrollView setContentSize:CGSizeMake(_scrollView.bounds.size.width * 3, _scrollView.bounds.size.height)];
            _scrollView.contentOffset = CGPointMake(0, 0);
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > _currentOffSet) {
        _isLeftScroll = YES;
        _currentOffSet = scrollView.contentOffset.x;
    }else {
        _isLeftScroll = NO;
        _currentOffSet = scrollView.contentOffset.x;
    }
}

#pragma mark - 图片停止时,调用该函数使得滚动视图复用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (_isLeftScroll) {
        centerZoomIndex = centerZoomIndex + 1;
        leftZoomIndex = leftZoomIndex + 1;
        rightZoomIndex = rightZoomIndex + 1;
        
        if (centerZoomIndex == _picUrls.count - 1) {
            [_leftZoomView setNetWorkImageWithUrl:_picUrls[leftZoomIndex]];
            [_centerZoomView setNetWorkImageWithUrl:_picUrls[centerZoomIndex]];
            [scrollView setContentSize:CGSizeMake(scrollView.bounds.size.width * 2, scrollView.bounds.size.height)];
            _scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        }else {
            if (leftZoomIndex == _picUrls.count) {
                leftZoomIndex = 0;
            }
            if (centerZoomIndex == _picUrls.count) {
                centerZoomIndex = 0;
            }
            if (rightZoomIndex == _picUrls.count) {
                rightZoomIndex = 0;
            }
            [_leftZoomView setNetWorkImageWithUrl:_picUrls[leftZoomIndex]];
            [_centerZoomView setNetWorkImageWithUrl:_picUrls[centerZoomIndex]];
            [_rightZoomView setNetWorkImageWithUrl:_picUrls[rightZoomIndex]];
            [scrollView setContentSize:CGSizeMake(scrollView.bounds.size.width * 3, scrollView.bounds.size.height)];
            _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
        }
    }else {
        centerZoomIndex = centerZoomIndex - 1;
        leftZoomIndex = leftZoomIndex - 1;
        rightZoomIndex = rightZoomIndex - 1;
        
        if (leftZoomIndex == -1) {
            leftZoomIndex = _picUrls.count-1;
        }
        if (centerZoomIndex == -1) {
            centerZoomIndex = _picUrls.count-1;
        }
        if (rightZoomIndex == -1) {
            rightZoomIndex = _picUrls.count-1;
        }
        if (centerZoomIndex == 0) {
            [_leftZoomView setNetWorkImageWithUrl:_picUrls[centerZoomIndex]];
            [_centerZoomView setNetWorkImageWithUrl:_picUrls[rightZoomIndex]];
            [scrollView setContentSize:CGSizeMake(scrollView.bounds.size.width * 2, scrollView.bounds.size.height)];
            _scrollView.contentOffset = CGPointMake(0, 0);
        }else {
            [_leftZoomView setNetWorkImageWithUrl:_picUrls[leftZoomIndex]];
            [_centerZoomView setNetWorkImageWithUrl:_picUrls[centerZoomIndex]];
            [_rightZoomView setNetWorkImageWithUrl:_picUrls[rightZoomIndex]];
            [scrollView setContentSize:CGSizeMake(scrollView.bounds.size.width * 3, scrollView.bounds.size.height)];
            _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
        }
        
    }
    
    
//    if (_scrollView.contentOffset.x == 0) {
//        centerZoomIndex = centerZoomIndex - 1;
//        leftZoomIndex = leftZoomIndex - 1;
//        rightZoomIndex = rightZoomIndex - 1;
//        
//        if (leftZoomIndex == -1) {
//            leftZoomIndex = _picUrls.count-1;
//        }
//        if (centerZoomIndex == -1) {
//            centerZoomIndex = _picUrls.count-1;
//        }
//        if (rightZoomIndex == -1) {
//            rightZoomIndex = _picUrls.count-1;
//        }
//    }else if (_scrollView.contentOffset.x == _scrollView.bounds.size.width * 2) {
//        centerZoomIndex = centerZoomIndex + 1;
//        leftZoomIndex = leftZoomIndex + 1;
//        rightZoomIndex = rightZoomIndex + 1;
//        
//        if (leftZoomIndex == _picUrls.count) {
//            leftZoomIndex = 0;
//        }
//        if (centerZoomIndex == _picUrls.count) {
//            centerZoomIndex = 0;
//        }
//        if (rightZoomIndex == _picUrls.count) {
//            rightZoomIndex = 0;
//        }
//    }else {
//        return;
//    }
//    
//    if (_isLeftScroll && centerZoomIndex == _picUrls.count - 1) {
//        [_leftZoomView setNetWorkImageWithUrl:_picUrls[leftZoomIndex]];
//        [_centerZoomView setNetWorkImageWithUrl:_picUrls[centerZoomIndex]];
//        [scrollView setContentSize:CGSizeMake(scrollView.bounds.size.width * 2, scrollView.bounds.size.height)];
//        _scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
//    }else if (!_isLeftScroll && centerZoomIndex == 0) {
//        [_leftZoomView setNetWorkImageWithUrl:_picUrls[centerZoomIndex]];
//        [_centerZoomView setNetWorkImageWithUrl:_picUrls[rightZoomIndex]];
//        [scrollView setContentSize:CGSizeMake(scrollView.bounds.size.width * 2, scrollView.bounds.size.height)];
//        _scrollView.contentOffset = CGPointMake(0, 0);
//    }else {
//        
//        
//        
//        [_leftZoomView setNetWorkImageWithUrl:_picUrls[leftZoomIndex]];
//        [_centerZoomView setNetWorkImageWithUrl:_picUrls[centerZoomIndex]];
//        [_rightZoomView setNetWorkImageWithUrl:_picUrls[rightZoomIndex]];
//        [scrollView setContentSize:CGSizeMake(scrollView.bounds.size.width * 3, scrollView.bounds.size.height)];
//        _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
//    }
    
    
    [_leftZoomView setZoomScale:1.0];
    [_centerZoomView setZoomScale:1.0];
    [_rightZoomView setZoomScale:1.0];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
