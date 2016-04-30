//
//  SCChannelManager.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/30.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SCGameListModel.h"

@interface SCChannelManager : NSObject

+ (void)updateChannelWith:(SCGameListModel *)model;

+ (NSArray *)newsChannel;
+ (void)setNewsChannelWith:(NSArray *)channelArray;

+ (NSArray *)topicChannel;
+ (void)setTopicChannelWith:(NSArray *)channelArray;

+ (NSArray *)matchChannel;
+ (void)setMatchChannelWith:(NSArray *)channelArray;

+ (NSArray *)videoChannel;
+ (void)setVideoChannelWith:(NSArray *)channelArray;


@end
