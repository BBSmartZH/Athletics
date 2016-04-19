//
//  LandlordCell.h
//  Athletics
//
//  Created by 李宛 on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LandlordCell : UITableViewCell
- (void)createLayoutWith:(id)model;

+ (NSString *)cellIdentifier;

//+ (CGFloat)cellHeightWith:(id)model;
@end
