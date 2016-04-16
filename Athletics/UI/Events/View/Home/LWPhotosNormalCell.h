//
//  LWPhotosNormalCell.h
//  Athletics
//
//  Created by 李宛 on 16/4/11.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWPhotosNormalCell : UITableViewCell
- (void)createLayoutWith:(id)model;
+(CGFloat)heightForRowWithPhotosWithCounts:(int)counts;


+ (NSString *)cellIdentifier;
@end
