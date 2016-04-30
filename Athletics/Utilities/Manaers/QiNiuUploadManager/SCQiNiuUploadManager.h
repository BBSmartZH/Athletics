//
//  SCQiNiuUploadManager.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/29.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QiniuSDK.h"

@interface SCQiNiuUploadManager : NSObject

+ (instancetype)shared;
- (instancetype)shared;

- (void)uploadWithData:(NSData *)data fileName:(NSString *)flieName token:(NSString *)token complete:(QNUpCompletionHandler)complete option:(QNUploadOption *)option;

@end
