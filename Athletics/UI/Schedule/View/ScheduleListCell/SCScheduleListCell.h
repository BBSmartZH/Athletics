//
//  SCScheduleListCell.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCScheduleListCell : UITableViewCell

+ (NSString *)cellIdentifier;

- (void)createLayoutWith:(id)model;

@end
