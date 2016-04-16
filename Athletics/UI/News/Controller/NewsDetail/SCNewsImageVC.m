//
//  SCNewsImageVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/16.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNewsImageVC.h"

#import "SCCommentListVC.h"

@interface SCNewsImageVC ()<UIScrollViewDelegate>
{
    UIView *_inputView;
    UIScrollView *_scrollView;
    
    CGRect imageFrameRect;
    NSInteger _number;
    CGFloat _offset;
    float _scale;
    BOOL   _isLarge;
    BOOL   _isHidden;
    UIView *_titleView;
    UILabel *_titleLabel;
    
    //Test
    NSArray *_imageArray;
    NSArray *_textArray;
    
    UIButton *_commentButton;
}

@end

@implementation SCNewsImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"资讯";
    
    
    _inputView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.fHeight - 44, self.view.fWidth, 44)];
    _inputView.backgroundColor = [UIColor cyanColor];
    _inputView.layer.borderWidth = .5f;
    _inputView.layer.borderColor = k_Border_Color.CGColor;
    [self.view addSubview:_inputView];
    
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentButton.backgroundColor = [UIColor redColor];
    [_commentButton setTitle:@"334评" forState:UIControlStateNormal];
    _commentButton.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_28px];
    _commentButton.frame = CGRectMake(_inputView.fWidth - 10 - 60, 7, 60, 30);
    [_commentButton addTarget:self action:@selector(commentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_inputView addSubview:_commentButton];
    
    _imageArray = @[@"http://pic14.nipic.com/20110522/7411759_164157418126_2.jpg", @"http://inews.gtimg.com/newsapp_match/0/253743855/0", @"http://inews.gtimg.com/newsapp_match/0/253743856/0", @"http://inews.gtimg.com/newsapp_match/0/253743857/0", @"http://inews.gtimg.com/newsapp_match/0/253743858/0", @"http://sports.gtimg.com/newsapp_bt/0/253843325/1000?tp=webp", @"http://sports.gtimg.com/newsapp_bt/0/253843326/1000?tp=webp"];
    _textArray = @[@"aksnsanda", @"腾讯体育4月16日讯 湖人在科比退役时赠送给科比和瓦妮莎两枚退役戒指，戒指上刻着科比的名字，两侧则是20年和黑曼巴的图样，简直太奢华。", @"两枚戒指闪闪发光，都刻着科比-布莱恩特的名字。", @"在总冠军奖杯的前面刻着湖人的字样。", @"戒指的侧面是黑曼巴的字样，刻着2006-2016，这是科比改穿24号的十年。", @"另一侧刻着1996-2005，这是科比穿8号的十年，很有纪念意义。", @"看上去甚至比总冠军戒指还要奢华。"];
    _number = _imageArray.count;
    
    
    _offset = 0.0;
    _scale = 1.0;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(-10, 0, self.view.fWidth + 20, self.view.fHeight)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.scrollEnabled = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(_scrollView.fWidth * _number, _scrollView.fHeight);
    [self.view addSubview:_scrollView];
    
    UITapGestureRecognizer *clickTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleClickTap:)];
    [clickTap setNumberOfTapsRequired:1];
    [_scrollView addGestureRecognizer:clickTap];

    [self.view bringSubviewToFront:self.m_navBar];
    [self.view bringSubviewToFront:_inputView];
    
    _titleView = [[UIView alloc] init];
    _titleView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    [self.view addSubview:_titleView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    [_titleView addSubview:_titleLabel];
    
    _titleLabel.text = [_textArray firstObject];
    
    _WEAKSELF(ws);
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.view);
        make.bottom.equalTo(_inputView.mas_top);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_titleView);
        make.left.top.equalTo(_titleView).offset(10);
        make.right.bottom.equalTo(_titleView).offset(-10);
    }];
    
    
    imageFrameRect = CGRectMake(10, self.m_navBar.fHeight, _scrollView.fWidth - 20, _scrollView.fHeight - self.m_navBar.fHeight - _inputView.fHeight);
    
    for (int i = 0; i < _number; i++) {
        UITapGestureRecognizer *doubleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        [doubleTap setNumberOfTapsRequired:2];
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(_scrollView.fWidth * i, 0, _scrollView.fWidth, _scrollView.fHeight)];
        scrollView.backgroundColor = [UIColor blackColor];
        scrollView.contentSize = CGSizeMake(scrollView.fWidth, scrollView.fHeight);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        scrollView.minimumZoomScale = 1.0;
        scrollView.maximumZoomScale = 2.0;
        [scrollView setZoomScale:1.0];
        
        UIImageView *imageview = [[UIImageView alloc] init];
        imageview.backgroundColor = [UIColor clearColor];
        imageview.frame = imageFrameRect;
        [imageview setContentMode:UIViewContentModeScaleAspectFit];
        imageview.userInteractionEnabled = YES;
        [imageview addGestureRecognizer:doubleTap];
        [scrollView addSubview:imageview];
        
        [imageview scImageWithURL:[NSURL URLWithString:[_imageArray objectAtIndex:i]]];

        [_scrollView addSubview:scrollView];
    }
    
    
}

- (void)commentButtonClicked:(UIButton *)sender {
    SCCommentListVC *commentVC = [[SCCommentListVC alloc] init];
    [self.navigationController pushViewController:commentVC animated:YES];
}

-(void)changeCenter:(id)sender{
    
}

#pragma mark - ScrollView delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    for (UIView *view in scrollView.subviews){
        return view;
    }
    return nil;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == _scrollView){
        CGFloat x = scrollView.contentOffset.x;
        if (x == _offset){
            
        } else {
            _offset = x;
            for (UIScrollView *scro in scrollView.subviews){
                if ([scro isKindOfClass:[UIScrollView class]]){
                    [scro setZoomScale:1.0];
                    UIImageView *image = [[scro subviews] objectAtIndex:0];
                    image.frame = imageFrameRect;
                }
            }
        }
    }
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    NSLog(@"Did zoom!");
    UIView *v = [scrollView.subviews objectAtIndex:0];
    if ([v isKindOfClass:[UIImageView class]]){
        if (scrollView.zoomScale <= 1.0){
            _isLarge = NO;
        }else {
            _isLarge = YES;
        }
    }
}

#pragma mark -

- (void)handleClickTap:(UIGestureRecognizer *)gesture {
    if (!_isHidden) {
        _isHidden = YES;
        [UIView animateWithDuration:0.15 animations:^{
            self.m_navBar.alpha = 0.0f;
            _inputView.alpha = 0.0f;
            _titleView.alpha = 0.0f;
        }];
    }else {
        _isHidden = NO;
        [UIView animateWithDuration:0.15 animations:^{
            self.m_navBar.alpha = 1.0f;
            _inputView.alpha = 1.0f;
            _titleView.alpha = 1.0f;
        }];
    }
}

-(void)handleDoubleTap:(UIGestureRecognizer *)gesture{
    float newScale;
    if (!_isLarge) {
        newScale = [(UIScrollView*)gesture.view.superview zoomScale] * 2.0;
        _isLarge = YES;
    }else {
        newScale = [(UIScrollView*)gesture.view.superview zoomScale] * 0.5;
        _isLarge = NO;
    }
    CGRect zoomRect = [self zoomRectForScale:newScale  inView:(UIScrollView*)gesture.view.superview withCenter:[gesture locationInView:gesture.view]];
    UIView *view = gesture.view.superview;
    if ([view isKindOfClass:[UIScrollView class]]){
        UIScrollView *s = (UIScrollView *)view;
        [s zoomToRect:zoomRect animated:YES];
    }
}

#pragma mark - Utility methods

-(CGRect)zoomRectForScale:(float)scale inView:(UIScrollView*)scrollView withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    zoomRect.size.height = [scrollView frame].size.height / scale;
    zoomRect.size.width  = [scrollView frame].size.width  / scale;
    
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
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
