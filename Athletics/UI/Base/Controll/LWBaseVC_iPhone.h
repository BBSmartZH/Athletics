//
//  LWBaseVC_iPhone.h
//  Link
//
//  Created by 李宛 on 16/3/10.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWNavigationBar.h"
#import "SCProgressHUD.h"

@interface LWBaseVC_iPhone : UIViewController

@property (nonatomic, strong) LWNavigationBar *m_navBar;

@property (nonatomic, assign) BOOL            isPresented;

@property (nonatomic, strong) NSURLSessionDataTask *sessionTask;

@property (nonatomic, assign, readonly) CGFloat tabBarH;

- (UIView *)scroll2TopViewWithAction:(SEL)action;
/**
 *   ！！！！注意：如果是自动布局下加到tableView上得话必须将view设为tableView的backgroundView
 */
- (UIView *)emptyDatasourceDefaultViewWithText:(NSString *)text;
/**
 *  UIActivityIndicatorView animation
 */
- (void)startActivityAnimation;
- (void)stopActivityAnimation;

/**
 *  提示信息
 */
- (void)postMessage:(NSString *)message;
- (void)postSuccessMessage:(NSString *)message;
- (void)postErrorMessage:(NSString *)message;

- (void)fadeInWithView:(UIView *)fadeView duration:(NSTimeInterval)duration;


@end
