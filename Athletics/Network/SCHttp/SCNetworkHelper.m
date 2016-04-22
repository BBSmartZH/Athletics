//
//  SCNetworkHelper.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/21.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNetworkHelper.h"
#import "SCServerMacro.h"

@implementation SCNetworkHelper


+ (AFHTTPSessionManager *)sharedInstance {
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl]];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 25.0f;
        
        [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"encType"];
        [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"cmpType"];
        [manager.requestSerializer setValue:@"text/plain" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"zh-CN" forHTTPHeaderField:@"Accept-Language"];
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf8"
                               forHTTPHeaderField:@"Content-Type"];
        NSMutableSet *set = [manager.responseSerializer.acceptableContentTypes mutableCopy];
        [set addObject:@"text/plain"];
        manager.responseSerializer.acceptableContentTypes = set;
    });
    return manager;
}



+ (NSURLSessionDataTask *)getWithCmd:(NSString *)cmd
                              params:(NSDictionary *)params
                             success:(SCSuccessBlock)success
                             message:(SCMessageBlock)message {
    AFHTTPSessionManager *manager = [self sharedInstance];
    [manager.requestSerializer setValue:cmd forHTTPHeaderField:@"cmd"];
    
    return [self getWithUrl:@"" params:params success:success message:message];
}

+ (NSURLSessionDataTask *)postWithCmd:(NSString *)cmd
                               params:(NSDictionary *)params
                              success:(SCSuccessBlock)success
                              message:(SCMessageBlock)message {
    AFHTTPSessionManager *manager = [self sharedInstance];
    [manager.requestSerializer setValue:cmd forHTTPHeaderField:@"cmd"];
    
    return [self postWithUrl:@"" params:params success:success message:message];
}

+ (NSURLSessionDataTask *)getWithUrl:(NSString *)url
                              params:(NSDictionary *)params
                             success:(SCSuccessBlock)success
                             message:(SCMessageBlock)message {
    AFHTTPSessionManager *manager = [self sharedInstance];
    
    NSURLSessionDataTask *task = [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
#if DEBUG
        if (error.code == kCFURLErrorTimedOut) {
            message(@"请求超时");
        }else if (error.code != kCFURLErrorCancelled){
            message(error.localizedDescription);
        }
#else
        if (error.code == kCFURLErrorTimedOut) {
            message(@"请求超时");
        }else if (error.code != kCFURLErrorCancelled){
            message(@"请求失败");
        }
#endif
    }];
    return task;
}

+ (NSURLSessionDataTask *)postWithUrl:(NSString *)url
                               params:(NSDictionary *)params
                              success:(SCSuccessBlock)success
                              message:(SCMessageBlock)message {
    AFHTTPSessionManager *manager = [self sharedInstance];
    
    NSURLSessionDataTask *task = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
#if DEBUG
        if (error.code == kCFURLErrorTimedOut) {
            message(@"请求超时");
        }else if (error.code != kCFURLErrorCancelled){
            message(error.localizedDescription);
        }
#else
        if (error.code == kCFURLErrorTimedOut) {
            message(@"请求超时");
        }else if (error.code != kCFURLErrorCancelled){
            message(@"请求失败");
        }
#endif
    }];
    return task;
}

@end
