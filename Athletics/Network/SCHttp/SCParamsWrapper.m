//
//  SCParamsWrapper.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/21.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCParamsWrapper.h"

@implementation SCParamsWrapper

#pragma mark -  *******************    登录找回密码    *********************************








#pragma mark -  *******************    Private    *********************************

#pragma mark - Private

+ (NSDictionary *)p_salt:(NSDictionary *)params isDynamic:(BOOL)isDynamic {
    if (![SCGlobaUtil isInvalidDict:params]) {
        return nil;
    }
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[params count]];
    for (NSString *key in params) {
        NSString *str = [NSString stringWithFormat:@"%@=%@", key, params[key]];
        [array addObject:str];
    }
    // 排序，按自然排序
    NSArray *sortedArray = [array sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    // 用&连接
    NSString *sortedString = [sortedArray componentsJoinedByString:@"&"];
    
//    if (isDynamic) {
//        NSString *dynamicSalt = [SCUserInfoManager userToken];
//        if ([SCGlobaUtil isEmpty:dynamicSalt]) {
//            NSLog(@"动态加密字符串为空，请注意！！！！");
//        } else {
//            sortedString = [NSString stringWithFormat:@"%@&%@", sortedString, dynamicSalt];
//        }
//    } else {
//        sortedString = [NSString stringWithFormat:@"%@&%@", sortedString, kFixedSalt];
//    }
    // md5加密
    sortedString = [SCGlobaUtil md5:sortedString];
    NSMutableDictionary *result = [params mutableCopy];
    [result setObject:sortedString forKey:@"salt"];
    
    return result;
}

@end
