//
//  NSString+Message.m
//  EMDemo
//
//  Created by mrzj_sc on 16/3/11.
//  Copyright © 2016年 mrzj_sc. All rights reserved.
//

#import "NSString+Message.h"

@implementation NSString (Message)

- (NSString *)stringByTrimingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSUInteger)numberOfLines {
    return [[self componentsSeparatedByString:@"\n"] count] + 1;
}

@end
