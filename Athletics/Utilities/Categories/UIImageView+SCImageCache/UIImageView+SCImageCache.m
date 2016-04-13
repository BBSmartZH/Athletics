//
//  UIImageView+SCImageCache.m
//  XiaoYaoUser
//
//  Created by Nick on 15/7/6.
//  Copyright (c) 2015年 xiaoyaor. All rights reserved.
//

#import "UIImageView+SCImageCache.h"


@implementation UIImageView (SCImageCache)

- (void)scImageWithURL:(NSURL *)url {
    [self scImageWithURL:url placeholderImage:nil];
}

- (void)scImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placehoder {
    [self sd_setImageWithURL:url placeholderImage:placehoder];
}

- (void)scImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placehoder completed:(SDWebImageCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placehoder completed:completedBlock];
}


@end
