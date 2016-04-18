//
//  UIImageView+SCImageCache.m
//  XiaoYaoUser
//
//  Created by Nick on 15/7/6.
//  Copyright (c) 2015年 xiaoyaor. All rights reserved.
//

#import "UIImageView+SCImageCache.h"


@implementation UIImageView (SCImageCache)

- (void)scImageWithURL:(NSString *)url {
    [self scImageWithURL:url placeholderImage:nil];
}

- (void)scImageWithURL:(NSString *)url placeholderImage:(UIImage *)placehoder {
    [self scImageWithURL:url placeholderImage:placehoder completed:nil];
}

- (void)scImageWithURL:(NSString *)url placeholderImage:(UIImage *)placehoder completed:(SDWebImageCompletionBlock)completedBlock {
    [self scImageWithURL:url placeholderImage:placehoder progress:nil completed:completedBlock];
}

- (void)scImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock {
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder options:0 progress:progressBlock completed:completedBlock];
}


@end
