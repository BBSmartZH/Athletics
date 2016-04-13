//
//  SCShareManager.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCShareManager : NSObject

+ (instancetype)shared;
- (instancetype)shared;

+ (void)startSocialShare;

+ (BOOL)handleOpenURL:(NSURL *)openUrl;

- (void)qqLoginAuth;

@end
