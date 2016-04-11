//
//  SCTopScrollView.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/10.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCTopButton;
@protocol SCTopScrollViewDelegate <NSObject>

@optional
- (void)topScrollButtonClicked:(SCTopButton *)sender;

@end

@interface SCTopScrollView : UIView

@property (nonatomic, assign) id<SCTopScrollViewDelegate> delegate;

@property (nonatomic, assign) CGFloat space;//Default 5.0

//@property (nonatomic, strong) UIColor *itemTextNorColor;
//
//@property (nonatomic, strong) UIColor *itemTextHighColor;


- (instancetype)initWithFrame:(CGRect)frame;

- (void)updateWithTitleArray:(NSArray *)titleArray selectedIndex:(NSInteger)selectedIndex;

- (void)topScrollViewScrollPart:(float)part page:(NSInteger)page;

- (void)scrollToPage:(NSInteger)page;

@end



@interface SCTopButton : UIButton

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGFloat buttonWidth;
@property (nonatomic, copy) NSString *subTitle;

@end
