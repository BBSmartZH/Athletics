//
//  SCCommunityDetailModel.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCCommunityDetailModel.h"

@implementation SCTopicLikeModel

@end

@implementation SCCommunityDetailDataModel

+(JSONKeyMapper*)keyMapper {
    
    return [[JSONKeyMapper alloc] initWithJSONToModelBlock:^NSString *(NSString *keyName) {
        
        if ([keyName isEqual:@"id"]) {
            return @"tid";
        }else {
            return keyName;
        }
    } modelToJSONBlock:^NSString *(NSString *keyName) {
        
        if ([keyName isEqual:@"tid"]) {
            return @"id";
        }else {
            return keyName;
        }
    }];
}

@end

@implementation SCCommunityDetailModel

@end
