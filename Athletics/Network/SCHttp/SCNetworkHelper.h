//
//  SCNetworkHelper.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/21.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^SCSuccessBlock)(NSDictionary *result);
typedef void (^SCMessageBlock)(NSString *message);


@interface SCNetworkHelper : NSObject

+ (NSURLSessionDataTask *)getWithCmd:(NSString *)cmd
                              params:(NSDictionary *)params
                             success:(SCSuccessBlock)success
                             message:(SCMessageBlock)message;

+ (NSURLSessionDataTask *)postWithCmd:(NSString *)cmd
                               params:(NSDictionary *)params
                              success:(SCSuccessBlock)success
                              message:(SCMessageBlock)message;

//+ (NSURLSessionDataTask *)getWithUrl:(NSString *)url
//                              params:(NSDictionary *)params
//                             success:(SCSuccessBlock)success
//                             message:(SCMessageBlock)message;

//+ (NSURLSessionDataTask *)postWithUrl:(NSString *)url
//                               params:(NSDictionary *)params
//                              success:(SCSuccessBlock)success
//                              message:(SCMessageBlock)message;

@end
