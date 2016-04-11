//
//  LWNBACell.h
//  Athletics
//
//  Created by 李宛 on 16/4/11.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWNBACell : UITableViewCell
- (void)configLayoutWithModel:(id)model;
+(CGFloat)heightForRow;
@end
