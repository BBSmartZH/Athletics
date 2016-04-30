//
//  SCMatchListModel.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCMatchListModel.h"

@implementation SCMatchListDataModel

+(JSONKeyMapper*)keyMapper {
    
    return [[JSONKeyMapper alloc] initWithJSONToModelBlock:^NSString *(NSString *keyName) {
        
        if ([keyName isEqual:@"id"]) {
            return @"matchUnitId";
        }else {
            return keyName;
        }
    } modelToJSONBlock:^NSString *(NSString *keyName) {
        
        if ([keyName isEqual:@"matchUnitId"]) {
            return @"id";
        }else {
            return keyName;
        }
    }];
}

@end

@implementation SCMatchGroupListModel

@end

@implementation SCMatchListModel

@end