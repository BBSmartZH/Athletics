//
//  SCTopicReplayListModel.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/29.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCTopicReplayListModel.h"

@implementation SCTopicReplayListDataModel

+(JSONKeyMapper*)keyMapper {
    
    return [[JSONKeyMapper alloc] initWithJSONToModelBlock:^NSString *(NSString *keyName) {
        
        if ([keyName isEqual:@"id"]) {
            return @"commentId";
        }else {
            return keyName;
        }
    } modelToJSONBlock:^NSString *(NSString *keyName) {
        
        if ([keyName isEqual:@"tid"]) {
            return @"commentId";
        }else {
            return keyName;
        }
    }];
}

@end

@implementation SCTopicReplayListModel

@end