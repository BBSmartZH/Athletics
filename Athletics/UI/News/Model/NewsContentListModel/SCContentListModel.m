//
//  SCContentListModel.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCContentListModel.h"

@implementation SCContentVideoModel

+(JSONKeyMapper*)keyMapper {
    
    return [[JSONKeyMapper alloc] initWithJSONToModelBlock:^NSString *(NSString *keyName) {
        
        if ([keyName isEqual:@"id"]) {
            return @"vId";
        }else {
            return keyName;
        }
    } modelToJSONBlock:^NSString *(NSString *keyName) {
        
        if ([keyName isEqual:@"vId"]) {
            return @"id";
        }else {
            return keyName;
        }
    }];
}

@end

@implementation SCContentListModel

@end
