//
//  UIImageView+SCImageCache.h
//  XiaoYaoUser
//
//  Created by Nick on 15/7/6.
//  Copyright (c) 2015年 xiaoyaor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"


static NSString *scDefaultProductImage = @"defaultProductImage";
static NSString *scDefaultAvatarImage = @"mine_default_avatar";

@interface UIImageView (SCImageCache)

- (void)scImageWithURL:(NSString *)url;

- (void)scImageWithURL:(NSString *)url placeholderImage:(UIImage *)placehoder;

- (void)scImageWithURL:(NSString *)url placeholderImage:(UIImage *)placehoder completed:(SDWebImageCompletionBlock)completedBlock;

- (void)scImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;

@end
