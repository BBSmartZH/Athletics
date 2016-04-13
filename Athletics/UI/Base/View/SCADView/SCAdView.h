//
//  SCAdView.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SCPageControlShowStyle) {
    SCPageControlShowStyleNone, //default 不显示
    SCPageControlShowStyleLeft,
    SCPageControlShowStyleCenter,
    SCPageControlShowStyleRight,
};

typedef NS_ENUM(NSUInteger, SCAdTitleShowStyle) {
    SCAdTitleShowStyleNone, //default 不显示
    SCAdTitleShowStyleLeft,
    SCAdTitleShowStyleCenter,
    SCAdTitleShowStyleRight,
};


@interface SCAdView : UIView

/*
 可以在adScrollView上添加一些不随广告滚动的控件
 */
@property (retain,nonatomic,readonly) UIScrollView * adScrollView;
@property (retain,nonatomic,readonly) UIPageControl * pageControl;
@property (retain,nonatomic) NSArray * imageLinkURL;
@property (retain,nonatomic) NSArray * adTitleArray;

/**
 *  设置page显示位置
 */
@property (assign,nonatomic) SCPageControlShowStyle  pageControlShowStyle;
/**
 *  设置标题对应的位置
 */
@property (assign,nonatomic) SCAdTitleShowStyle  adTitleStyle;

/**
 *  设置占位图片
 */
@property (nonatomic,strong) UIImage * placeHoldImage;

/**
 *  是否需要定时循环滚动
 */
@property (nonatomic,assign) BOOL isNeedCycleRoll;

/**
 *  图片移动计时器
 */
@property (nonatomic,assign) CGFloat  adMoveTime;
/**
 *  在这里修改Label的一些属性
 */
@property (nonatomic,strong,readonly) UILabel * centerAdLabel;

/**
 *  给图片创建点击后的回调方法
 */
@property (nonatomic,strong) void (^tapAdCallBack)(NSInteger index);


/**
 *  初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame;




@end
