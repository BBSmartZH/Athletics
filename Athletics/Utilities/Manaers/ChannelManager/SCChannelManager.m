//
//  SCChannelManager.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/30.
//  Copyright © 2016年 李宛. All rights reserved.
//


static NSString *kNews_channel_key = @"news_channel_key";
static NSString *kTopic_channel_key = @"topic_channel_key";
static NSString *kMatch_channel_key = @"match_channel_key";
static NSString *kVideo_channel_key = @"video_channel_key";

#import "SCChannelManager.h"

@implementation SCChannelManager

+ (void)updateChannelWith:(SCGameListModel *)model {
    
    /*NewsChannel*/
    NSMutableArray *newsChannnel = [self newsChannel].mutableCopy;
    if (!newsChannnel) {
        //首次
        newsChannnel = [NSMutableArray arrayWithArray:model.data];
        NSArray *fir = [NSArray arrayWithObject:newsChannnel.firstObject];
        [newsChannnel removeObject:newsChannnel.firstObject];
        NSArray *sec = [NSArray arrayWithArray:newsChannnel];

        [self setNewsChannelWith:@[fir, sec]];
    }else {
        NSMutableArray *updateChannel = model.data.mutableCopy;
        
        NSArray *fir = newsChannnel.firstObject;
        
        NSMutableArray *newFir = [NSMutableArray array];
        NSMutableArray *newSec = [NSMutableArray array];
        
        for (SCGameModel *agModel in updateChannel) {
            BOOL isFir = NO;
            for (SCGameModel *gModel in fir) {
                if ([gModel.channelId isEqualToString:agModel.channelId]) {
                    [newFir addObject:agModel];
                    isFir = YES;
                    break;
                }
            }
            if (!isFir) {
                [newSec addObject:agModel];
            }
        }
        
        if (!newFir.count) {
            [newFir addObject:newSec.firstObject];
            [newSec removeObject:newSec.firstObject];
        }
        NSLog(@"fir = %ld ------- sec = %ld", newFir.count, newSec.count);
        [self setNewsChannelWith:@[newFir, newSec]];
    }
    
    /*TopicChannel*/
    NSMutableArray *topicChannnel = [self topicChannel].mutableCopy;
    if (!topicChannnel) {
        //首次
        topicChannnel = [NSMutableArray arrayWithArray:model.data];
        NSArray *fir = [NSArray arrayWithObject:topicChannnel.firstObject];
        [topicChannnel removeObject:topicChannnel.firstObject];
        NSArray *sec = [NSArray arrayWithArray:topicChannnel];
        
        [self setTopicChannelWith:@[fir, sec]];
    }else {
        NSMutableArray *updateChannel = model.data.mutableCopy;
        
        NSArray *fir = topicChannnel.firstObject;
        
        NSMutableArray *newFir = [NSMutableArray array];
        NSMutableArray *newSec = [NSMutableArray array];
        
        for (SCGameModel *agModel in updateChannel) {
            BOOL isFir = NO;
            for (SCGameModel *gModel in fir) {
                if ([gModel.channelId isEqualToString:agModel.channelId]) {
                    [newFir addObject:agModel];
                    isFir = YES;
                    break;
                }
            }
            if (!isFir) {
                [newSec addObject:agModel];
            }
        }
        
        if (!newFir.count) {
            [newFir addObject:newSec.firstObject];
            [newSec removeObject:newSec.firstObject];
        }
        [self setTopicChannelWith:@[newFir, newSec]];
    }
    
    /*MatchChannel*/
    NSMutableArray *matchChannnel = [self matchChannel].mutableCopy;
    if (!matchChannnel) {
        //首次
        matchChannnel = [NSMutableArray arrayWithArray:model.data];
        NSArray *fir = [NSArray arrayWithObject:matchChannnel.firstObject];
        [matchChannnel removeObject:matchChannnel.firstObject];
        NSArray *sec = [NSArray arrayWithArray:matchChannnel];
        
        [self setMatchChannelWith:@[fir, sec]];
    }else {
        NSMutableArray *updateChannel = model.data.mutableCopy;
        
        NSArray *fir = matchChannnel.firstObject;
        
        NSMutableArray *newFir = [NSMutableArray array];
        NSMutableArray *newSec = [NSMutableArray array];
        
        for (SCGameModel *agModel in updateChannel) {
            BOOL isFir = NO;
            for (SCGameModel *gModel in fir) {
                if ([gModel.channelId isEqualToString:agModel.channelId]) {
                    [newFir addObject:agModel];
                    isFir = YES;
                    break;
                }
            }
            if (!isFir) {
                [newSec addObject:agModel];
            }
        }
        
        if (!newFir.count) {
            [newFir addObject:newSec.firstObject];
            [newSec removeObject:newSec.firstObject];
        }
        [self setMatchChannelWith:@[newFir, newSec]];
    }
    
    /*VideoChannel*/
    NSMutableArray *videoChannnel = [self videoChannel].mutableCopy;
    if (!videoChannnel) {
        //首次
        videoChannnel = [NSMutableArray arrayWithArray:model.data];
        NSArray *fir = [NSArray arrayWithObject:videoChannnel.firstObject];
        [videoChannnel removeObject:videoChannnel.firstObject];
        NSArray *sec = [NSArray arrayWithArray:videoChannnel];
        
        [self setVideoChannelWith:@[fir, sec]];
    }else {
        NSMutableArray *updateChannel = model.data.mutableCopy;
        
        NSArray *fir = videoChannnel.firstObject;
        
        NSMutableArray *newFir = [NSMutableArray array];
        NSMutableArray *newSec = [NSMutableArray array];
        
        for (SCGameModel *agModel in updateChannel) {
            BOOL isFir = NO;
            for (SCGameModel *gModel in fir) {
                if ([gModel.channelId isEqualToString:agModel.channelId]) {
                    [newFir addObject:agModel];
                    isFir = YES;
                    break;
                }
            }
            if (!isFir) {
                [newSec addObject:agModel];
            }
        }
        
        if (!newFir.count) {
            [newFir addObject:newSec.firstObject];
            [newSec removeObject:newSec.firstObject];
        }
        
        [self setVideoChannelWith:@[newFir, newSec]];
    }
}

+ (NSArray *)newsChannel {
    NSArray *newsChannel = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:kNews_channel_key]];
    
    return newsChannel;
}

+ (void)setNewsChannelWith:(NSArray *)channelArray {
    NSData *newsChannelData = [NSKeyedArchiver archivedDataWithRootObject:channelArray];
    [kUserDefaults setObject:newsChannelData forKey:kNews_channel_key];
    [kUserDefaults synchronize];
}

+ (NSArray *)topicChannel {
    NSArray *topicChannel = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:kTopic_channel_key]];
    return topicChannel;
}

+ (void)setTopicChannelWith:(NSArray *)channelArray {
    NSData *topicChannelData = [NSKeyedArchiver archivedDataWithRootObject:channelArray];
    [kUserDefaults setObject:topicChannelData forKey:kTopic_channel_key];
    [kUserDefaults synchronize];
}

+ (NSArray *)matchChannel {
    NSArray *matchChannel = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:kMatch_channel_key]];
    return matchChannel;
}

+ (void)setMatchChannelWith:(NSArray *)channelArray {
    NSData *matchChannelData = [NSKeyedArchiver archivedDataWithRootObject:channelArray];
    [kUserDefaults setObject:matchChannelData forKey:kMatch_channel_key];
    [kUserDefaults synchronize];
}

+ (NSArray *)videoChannel {
    NSArray *videoChannel = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:kVideo_channel_key]];
    return videoChannel;
}

+ (void)setVideoChannelWith:(NSArray *)channelArray {
    NSData *videoChannelData = [NSKeyedArchiver archivedDataWithRootObject:channelArray];
    [kUserDefaults setObject:videoChannelData forKey:kVideo_channel_key];
    [kUserDefaults synchronize];
}

@end
