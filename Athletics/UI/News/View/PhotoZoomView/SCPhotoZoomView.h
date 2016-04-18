//
//  SCPhotoZoomView.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/18.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCPhotoZoomView : UIScrollView

@property (nonatomic, assign) UIEdgeInsets imageInset;

// 网络加载图
-(void)setNetWorkImageWithUrl:(NSString *)urlStr;

@end
