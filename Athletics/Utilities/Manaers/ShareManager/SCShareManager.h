//
//  SCShareManager.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/13.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SCShareResultCancel = 1,
    SCShareResultSuccess = 2,
    SCShareResultFail = 3,
}SCShareResult;

typedef void(^SCShareComplation)(SCShareResult result);

@interface SCShareManager : NSObject

+ (instancetype)shared;
- (instancetype)shared;

+ (void)startSocialShare;

+(void)applicationDidBecomeActive;
+ (BOOL)handleOpenURL:(NSURL *)openUrl;

- (void)shareIn:(UIViewController *)controller
          title:(NSString *)title
       imageUrl:(NSString *)imageUrl
           desc:(NSString *)desc
       shareUrl:(NSString *)shareUrl;

- (void)shareIn:(UIViewController *)controller
          title:(NSString *)title
       imageUrl:(NSString *)imageUrl
           desc:(NSString *)desc
       shareUrl:(NSString *)shareUrl
     complation:(SCShareComplation)complation;

@end
