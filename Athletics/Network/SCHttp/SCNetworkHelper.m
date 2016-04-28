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
        
        [manager.requestSerializer setValue:@"text/plain" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"zh-CN" forHTTPHeaderField:@"Accept-Language"];
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf8"
                               forHTTPHeaderField:@"Content-Type"];
        NSMutableSet *set = [manager.responseSerializer.acceptableContentTypes mutableCopy];
        [set addObject:@"text/plain"];
        [set addObject:@"text/html"];
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
    
    return [self getWithUrl:@"/e/esports" params:params success:success message:message];
}

+ (NSURLSessionDataTask *)postWithCmd:(NSString *)cmd
                               params:(NSDictionary *)params
                              success:(SCSuccessBlock)success
                              message:(SCMessageBlock)message {
    AFHTTPSessionManager *manager = [self sharedInstance];
    [manager.requestSerializer setValue:cmd forHTTPHeaderField:@"cmd"];
    
    return [self postWithUrl:@"/e/esports" params:params success:success message:message];
}

+ (NSURLSessionDataTask *)getWithUrl:(NSString *)url
                              params:(NSDictionary *)params
                             success:(SCSuccessBlock)success
                             message:(SCMessageBlock)message {
    AFHTTPSessionManager *manager = [self sharedInstance];
    
    NSURLSessionDataTask *task = [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@" url = %@\n params = %@\n response = %@", url, params, responseObject);
        if (![SCGlobaUtil isInvalidDict:responseObject]) {
            message(@"返回数据出错");
            return;
        }
        NSError *error;
        SCResponseModel *response = [[SCResponseModel alloc] initWithDictionary:responseObject error:&error];
        if (!error) {
            if (response.success.boolValue) {
                success(responseObject);
            }else {
                message(response.message);
                if ([response.code isEqualToString:@"8001"]) {
                    //退出登录
                    [SCUserInfoManager setIsLogin:NO];
                }
            }
        }else {
            message(@"解析数据出错");
        }    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
        NSLog(@" url = %@\n params = %@\n response = %@", url, params, responseObject);
        if (![SCGlobaUtil isInvalidDict:responseObject]) {
            message(@"返回数据出错");
            return;
        }
        NSError *error;
        SCResponseModel *response = [[SCResponseModel alloc] initWithDictionary:responseObject error:&error];
        if (!error) {
            if (response.success.boolValue) {
                success(responseObject);
            }else {
                message(response.message);
                if ([response.code isEqualToString:@"8001"]) {
                    //退出登录
                    [SCUserInfoManager setIsLogin:NO];
                }
            }
        }else {
            message(@"解析数据出错");
        }
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


+ (NSURLSessionDataTask *)uploadImageWithUrl:(NSString *)url
                                       image:(UIImage *)image
                                   imageType:(NSString *)type                                     success:(SCSuccessBlock)success
                                     message:(SCMessageBlock)message {
    AFHTTPSessionManager *manager = [self sharedInstance];
    [manager.requestSerializer setValue:url forHTTPHeaderField:@"cmd"];

    NSURLSessionDataTask *task = [manager POST:@"" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        [formData appendPartWithFileData:imageData name:type fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
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
