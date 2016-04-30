//
//  SCPostsTopView.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/15.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCCommunityDetailDataModel;
@protocol SCPostsTopViewDelegate <NSObject>

- (void)postsTopViewHeightChanged;
- (void)postsTopViewClickedWith:(SCCommunityDetailDataModel*)model;

@end

@interface SCPostsTopView : UIView

@property (nonatomic, assign) id<SCPostsTopViewDelegate> delegate;

@property (nonatomic, strong, readonly) UIImageView *avatar;

@property (nonatomic, strong) SCCommunityDetailDataModel *model;

- (instancetype)initWithFrame:(CGRect)frame;

- (CGFloat)topViewHeight;

@end
