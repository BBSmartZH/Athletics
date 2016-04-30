//
//  SCQiNiuUploadManager.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/29.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCQiNiuUploadManager.h"

@interface SCQiNiuUploadManager ()

@property (nonatomic, strong) QNUploadManager *uploadManager;

@end

@implementation SCQiNiuUploadManager

+ (instancetype)shared {
    static SCQiNiuUploadManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        manager.uploadManager = [[QNUploadManager alloc] init];
    });
    return manager;
}
- (instancetype)shared {
    return [[self class] shared];
}

- (void)uploadWithData:(NSData *)data fileName:(NSString *)flieName token:(NSString *)token complete:(QNUpCompletionHandler)complete option:(QNUploadOption *)option {
    [[self shared].uploadManager putData:data key:flieName token:token complete:complete option:option];
}


@end
