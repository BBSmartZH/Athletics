//
//  SCPostsTopView.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/15.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCPostsTopViewDelegate <NSObject>

- (void)postsTopViewHeightChanged;
- (void)postsTopViewClickedWith:(id)model;

@end

@interface SCPostsTopView : UIView

@property (nonatomic, assign) id<SCPostsTopViewDelegate> delegate;

@property (nonatomic, strong, readonly) UIImageView *avatar;

@property (nonatomic, strong) id model;

- (instancetype)initWithFrame:(CGRect)frame;

- (CGFloat)topViewHeight;

@end
