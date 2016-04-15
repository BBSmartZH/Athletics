//
//  SCPostsTextImageCell.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/15.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCPostsTextImageCell : UITableViewCell

- (void)createLayoutWith:(id)model;

+ (NSString *)cellIdentifier;

+ (CGFloat)cellHeightWith:(id)model;

@end
