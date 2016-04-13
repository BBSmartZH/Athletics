//
//  LWPostsCell.h
//  Athletics
//
//  Created by 李宛 on 16/4/12.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWPostsCell : UITableViewCell
- (void)configLayoutWithModel:(id)model;
+(CGFloat)heightForRowWithImageCounts:(int)counts;
@end
