//
//  SCNewsBannerListModel.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/30.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCNewsBannerListModel.h"

@implementation SCNewsBannerListDataModel

+(JSONKeyMapper*)keyMapper {
    
    return [[JSONKeyMapper alloc] initWithJSONToModelBlock:^NSString *(NSString *keyName) {
        
        if ([keyName isEqual:@"id"]) {
            return @"bannerId";
        }else {
            return keyName;
        }
    } modelToJSONBlock:^NSString *(NSString *keyName) {
        
        if ([keyName isEqual:@"bannerId"]) {
            return @"id";
        }else {
            return keyName;
        }
    }];
}

@end

@implementation SCNewsBannerListModel

@end
