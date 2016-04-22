//
//  LWBaseVC_iPhone.m
//  Link
//
//  Created by 李宛 on 16/3/10.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWBaseVC_iPhone.h"
#import "AFHTTPSessionManager.h"

@interface LWBaseVC_iPhone ()
{
    UIActivityIndicatorView *m_activityView;
    UIImageView             *_up2TopImageView;
    MBProgressHUD           *_messageHUD;
}
@end

@implementation LWBaseVC_iPhone

-(instancetype)init{
    if (self = [super init]) {
        //TOOD
        /*自定义*/
        
        self.m_navBar = [[LWNavigationBar alloc]initWithFrame:CGRectMake(0, 0, [LWNavigationBar barSize].width, [LWNavigationBar barSize].height)];
        
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.sessionTask.state == NSURLSessionTaskStateRunning) {
        [self.sessionTask cancel];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = k_Bg_Color;
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
    [self.view addSubview:tempView];
    
    /*自定义NAV*/
    self.m_navBar.m_vc = self;
    [self.view addSubview:_m_navBar];
    if (self.navigationController && self.navigationController.viewControllers.count == 1 && !_isPresented) {
        [self.m_navBar setLeftBarButton:nil];
    }else if (self.navigationController && self.navigationController.viewControllers.count == 1 &&  _isPresented) {
        [self.m_navBar setLeftButtonImage:[UIImage imageNamed:@"icon_close"]];
    }

    
}

- (void)setTitle:(NSString *)title {
    [_m_navBar setNavTitle:title];
}

- (CGFloat)tabBarH {
    CGFloat tabBarH = 0.0f;
    if (kIsIOS7OrLater) {
        tabBarH = 49.0f;
    }
    return tabBarH;
}

- (void)startActivityAnimation {
    if (!m_activityView) {
        m_activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        m_activityView.color = k_Base_Color;
        m_activityView.center = self.view.center;
        [self.view addSubview:m_activityView];
    }
    if (!m_activityView.isAnimating) {
        [m_activityView startAnimating];
    }
}

- (void)stopActivityAnimation {
    [m_activityView stopAnimating];
    [m_activityView removeFromSuperview];
    m_activityView = nil;
}


- (UIView *)scroll2TopViewWithAction:(SEL)action {
    if (!_up2TopImageView) {
        UIImage *upImage = [UIImage imageNamed:@"icon_list_up"];
        CGFloat upWidth = upImage.size.width;
        CGFloat upHeight = upImage.size.height;
        _up2TopImageView = [[UIImageView alloc] init];
        _up2TopImageView.userInteractionEnabled = YES;
        _up2TopImageView.image = upImage;
        [self.view addSubview:_up2TopImageView];
        _up2TopImageView.alpha = 0.0f;
        UITapGestureRecognizer *upTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
        [_up2TopImageView addGestureRecognizer:upTap];
        _WEAKSELF(ws);
        [_up2TopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(ws.view).offset(-15);
            make.size.mas_equalTo(CGSizeMake(upWidth, upHeight));
        }];
    }
    return _up2TopImageView;
}

- (UIView *)emptyDatasourceDefaultViewWithText:(NSString *)text {
    UIView *backView = [[UIView alloc] init];
    
    UIView *view = [[UIView alloc] init];
    [backView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(backView);
        make.size.mas_equalTo(CGSizeMake(120, 130));
    }];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_empty"]];
    [view addSubview:imageView];
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = kWord_Color_Low;
    label.font = [UIFont systemFontOfSize:kWord_Font_20px];
    label.numberOfLines = 2;
    label.backgroundColor = [UIColor clearColor];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top);
        make.size.mas_equalTo(CGSizeMake(87, 94));
        make.centerX.equalTo(view);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(5);
        make.left.right.equalTo(view);
        make.bottom.lessThanOrEqualTo(view);
    }];
    
    return backView;
}

- (void)postMessage:(NSString *)message {
    if (_messageHUD) {
        [_messageHUD hideAnimated:YES];
    }
    _messageHUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    _messageHUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    _messageHUD.bezelView.layer.opacity = 0.7;
    _messageHUD.contentColor = [UIColor whiteColor];
    _messageHUD.bezelView.color = [UIColor blackColor];
    _messageHUD.margin = 10.0f;
    _messageHUD.userInteractionEnabled = NO;
    _messageHUD.mode = MBProgressHUDModeText;
    _messageHUD.label.text = message;
    
    [_messageHUD hideAnimated:YES afterDelay:1.5f];
}
- (void)postSuccessMessage:(NSString *)message {
    [self postMessage:message];
}

- (void)postErrorMessage:(NSString *)message {
    [self postMessage:message];
}

//- (void)setHttpOperation:(AFHTTPRequestOperation *)httpOperation {
//    if (_httpOperation != httpOperation) {
//        // 注意先取消连接
//        _cancelledOperation = nil;
//        _cancelledOperation = _httpOperation;
//        
//        [_httpOperation pause];
//        [_httpOperation cancel];
//        _httpOperation = nil;
//        _httpOperation = httpOperation;
//    }
//}
//
//- (AFHTTPRequestOperation *)foreCancelHttpOperation {
//    return _cancelledOperation;
//}

- (void)fadeInWithView:(UIView *)fadeView duration:(NSTimeInterval)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setType:kCATransitionFade];
    animation.removedOnCompletion = YES;
    [fadeView.layer addAnimation:animation forKey:@"transition"];
}



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
