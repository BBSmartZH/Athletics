//
//  SCBaseWebVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/27.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCBaseWebVC.h"

@interface SCBaseWebVC ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    BOOL     _hasFinished;
}

@end

@implementation SCBaseWebVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        _needsAppend = YES;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

//- preferredStatusBarStyle

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //隐藏导航条
    self.m_navBar.hidden = YES;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 49 - 20)];
    _webView.scalesPageToFit = YES;
    _webView.userInteractionEnabled = YES;
    _webView.delegate = self;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_webView];
    SCWebToolBar *toolBar = [[SCWebToolBar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 49, self.view.bounds.size.width, 49)];
    toolBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:toolBar];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, toolBar.bounds.size.width, 0.5f)];
    line.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.6];
    [toolBar addSubview:line];
    
    __weak typeof(self) weakSelf = self;
    
    toolBar.clickedBlock = ^(NSInteger index) {
        switch (index) {
            case 0:
                [weakSelf p_back];
                break;
            case 1:
                [weakSelf p_close];
                break;
            case 2:
                [weakSelf p_refresh];
                break;
            case 3:
                [weakSelf p_share];
                break;
                
            default:
                break;
        }
    };
    
    [self loadWebUrl];
    
}

- (void)p_back {
    if (_webView.canGoBack) {
        [_webView goBack];
    }else {
        [self p_close];
    }
}

- (void)p_close {
    if (self.isPresented) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)p_refresh {
    if (_hasFinished) {
        [_webView reload];
    }
}

- (void)p_share {
    [self share];
}

- (void)share {
    [self postMessage:@"没有可分享内容"];
}

- (void)loadWebUrl {
    [self loadWebViewWith:_webUrl];
}

- (void)loadWebViewWith:(NSString *)url {
    if (_webView) {
        NSURL *requestUrl = [NSURL URLWithString:url];
        NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
        [_webView loadRequest:request];
    }
}

- (NSString *)webTitle {
    return [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self startActivityAnimation];
    _hasFinished = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self stopActivityAnimation];
    _hasFinished = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self stopActivityAnimation];
    _hasFinished = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
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



#pragma mark - SCWebToolBar

@interface SCWebToolBar ()
{
    UIButton *_backButton;
    UIButton *_closeButton;
    UIButton *_refreshButton;
    UIButton *_shareButton;
}

@end

@implementation SCWebToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_uiConfig];
    }
    return self;
}

- (void)p_uiConfig {
    CGFloat left = 0;
    CGFloat width = self.bounds.size.width / 4.0;
    NSArray *imageArray = @[@"banner_back", @"banner_close", @"banner_refresh", @"banner_share"];
    for (int i = 0; i < imageArray.count; i++) {
        UIImage *image = [UIImage imageNamed:imageArray[i]];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateSelected];
        [button addTarget:self action:@selector(p_buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(left, 0, width, self.bounds.size.height);
        [self addSubview:button];
        
        left = CGRectGetMaxX(button.frame);
        if (i == 0) {
            _backButton = button;
        }else if (i == 1) {
            _closeButton = button;
        }else if (i == 2) {
            _refreshButton = button;
        }else if (i == 3) {
            _shareButton = button;
        }
    }
}

- (void)p_buttonClicked:(UIButton *)sender {
    if (_clickedBlock) {
        if (sender == _backButton) {
            _clickedBlock(0);
        }else if (sender == _closeButton) {
            _clickedBlock(1);
        }else if (sender == _refreshButton) {
            _clickedBlock(2);
        }else if (sender == _shareButton) {
            _clickedBlock(3);
        }
    }
}

@end
