//
//  SCPhotoZoomView.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/18.
//  Copyright © 2016年 李宛. All rights reserved.
//



#import "SCPhotoZoomView.h"
#import "MBProgressHUD.h"

@interface SCPhotoZoomView ()<UIScrollViewDelegate>
{
    BOOL _isLarge;
    MBProgressHUD *_HUD;
}

@property (nonatomic, strong) UIImageView *mainImageView;

@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;


@end



@implementation SCPhotoZoomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        
        self.mainImageView = [[UIImageView alloc] init];
        _mainImageView.userInteractionEnabled = YES;
        _mainImageView.contentMode = UIViewContentModeScaleAspectFit;
        _mainImageView.clipsToBounds = YES;
        _mainImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_mainImageView];
        
        self.doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        [_doubleTap setNumberOfTapsRequired:2];
        
    }
    return self;
}


- (void)doubleTap:(UITapGestureRecognizer *)doubleTap {
    
    CGPoint touchPoint = [doubleTap locationInView:self.mainImageView];
    if (self.zoomScale == self.maximumZoomScale) {//缩小
        [self setZoomScale:1.0 animated:YES];
    } else {//放大
        CGRect zoomRect;
        zoomRect.origin.x = touchPoint.x;
        zoomRect.origin.y = touchPoint.y;
        [self zoomToRect:zoomRect animated:YES];
        
    }
}

// 网络加载图
-(void)setNetWorkImageWithUrl:(NSString *)urlStr {
    
    //初始化一个默认图
    [self setFrameAndZoom];
    self.maximumZoomScale =1;
    self.minimumZoomScale =1;
    
    //TODO 动画
    self.userInteractionEnabled = YES;
    
    typeof(self) __weak weakSelf = self;
    
    [self.mainImageView scImageWithURL:urlStr placeholderImage:self.mainImageView.image progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //加载进度条
        if (expectedSize > 0) {
            
            CGFloat progress = (float)receivedSize / expectedSize;
            
            [weakSelf performSelectorOnMainThread:@selector(changeProgressWith:) withObject:[NSNumber numberWithFloat:progress] waitUntilDone:NO];
        }
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error == nil) { //下载成功
            
            [weakSelf addGestureRecognizer:self.doubleTap];
            weakSelf.mainImageView.image = image;
            [weakSelf setFrameAndZoom];//设置最新的网络下载后的图的frame大小
            
        }else{ //下载失败
            
        }
    }];
    
}

#pragma mark - 改变进度条
- (void)changeProgressWith:(NSNumber*)progress{
    if (!_HUD) {
        _HUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
        _HUD.userInteractionEnabled = NO;
        _HUD.margin = 10.0f;
        _HUD.mode = MBProgressHUDModeDeterminate;
        _HUD.label.text = @"loading...";
    }
    if ([progress floatValue] < 1.0) {
        _HUD.progress = [progress floatValue];
    }else {
        [_HUD hideAnimated:YES];
    }
}

- (void)setImageInset:(UIEdgeInsets)imageInset {
    if (_imageInset.bottom != imageInset.bottom || _imageInset.top != imageInset.top || _imageInset.left != imageInset.left || _imageInset.right != imageInset.right) {
        _imageInset = imageInset;
        
        [self setFrameAndZoom];
    }
}

#pragma mark - 计算Frame
- (void)setFrameAndZoom {
    
    CGFloat imageH;
    CGFloat imageW;
    
    if (self.mainImageView.image == nil || self.mainImageView.image.size.width == 0 || self.mainImageView.image.size.height == 0) {
        imageH = self.bounds.size.height;
        imageW = self.bounds.size.width;
        self.mainImageView.image = [UIImage imageNamed:@"none"];
    }else {
        imageW = self.mainImageView.image.size.width;
        imageH = self.mainImageView.image.size.height;
    }
    
    //设置主图片Frame 与缩小比例
    
    CGSize baseSize = CGSizeMake((self.bounds.size.width - (_imageInset.left + _imageInset.right)), self.bounds.size.height - (_imageInset.top + _imageInset.bottom));
    
    if (imageW >= (imageH * (baseSize.width / baseSize.height))) {
        //横着
        //设置居中frame
        CGFloat  myX_ =  _imageInset.left;
        CGFloat  myW_ = baseSize.width;
        CGFloat  myH_  = myW_ *(imageH / imageW);;
        CGFloat  myY_ = (baseSize.height - myH_) / 2.0 + _imageInset.top;
        
        self.mainImageView.frame = CGRectMake(myX_, myY_, myW_, myH_);
        
        self.maximumZoomScale = 2;

//        if (imageW >  myW_) {
//            self.maximumZoomScale = 2 * (imageW / imageH);
//        }else {
//            self.maximumZoomScale = (imageW / imageH);
//        }
    }else {
        //竖着
        
        CGFloat  myH_ = baseSize.height;
        CGFloat  myW_ = myH_ *(imageW/imageH);
        CGFloat  myX_ = (baseSize.width - myW_) / 2.0 + +_imageInset.left;
        CGFloat  myY_ = _imageInset.top;
        
        //变换设置frame
        self.mainImageView.frame = CGRectMake(myX_, myY_, myW_, myH_);
        
        self.maximumZoomScale = 2;

//        if (imageH >  myH_) {
//            self.maximumZoomScale = 2 * (imageH / imageW);
//        }else {
//            self.minimumZoomScale = (imageH / imageW);
//        }
    }
}

#pragma mark - 缩放代理方法
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.mainImageView;
}

//缩放时调用  确定中心点
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGSize scrollSize = scrollView.bounds.size;
    CGRect imageViewRect = self.mainImageView.frame;
    CGSize contentSize = scrollView.contentSize;
    CGPoint centerPoint = CGPointMake(contentSize.width / 2.0, contentSize.height / 2.0f);
    
    // 竖着长的 就是垂直居中
    if (imageViewRect.size.width <= scrollSize.width)
    {
        centerPoint.x = scrollSize.width/2;
    }
    
    // 横着长的  就是水平居中
    if (imageViewRect.size.height <= scrollSize.height)
    {
        centerPoint.y = scrollSize.height/2;
    }
    
    self.mainImageView.center = centerPoint;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
