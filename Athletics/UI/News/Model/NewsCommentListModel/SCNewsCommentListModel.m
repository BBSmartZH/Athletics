//
//  SCNewsCommentListModel.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/28.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNewsCommentListModel.h"

@implementation SCNewsCommentListDataModel

+(JSONKeyMapper*)keyMapper {
    
    return [[JSONKeyMapper alloc] initWithJSONToModelBlock:^NSString *(NSString *keyName) {
        
        if ([keyName isEqual:@"id"]) {
            return @"commentId";
        }else {
            return keyName;
        }
    } modelToJSONBlock:^NSString *(NSString *keyName) {
        
        if ([keyName isEqual:@"commentId"]) {
            return @"id";
        }else {
            return keyName;
        }
    }];
}

@end

@implementation SCNewsCommentListModel

@end