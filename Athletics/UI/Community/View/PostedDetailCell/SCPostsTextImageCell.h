//
//  SCPostsTextImageCell.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/15.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCImageModel;
@interface SCPostsTextImageCell : UITableViewCell

- (void)createLayoutWith:(SCImageModel *)model;

+ (NSString *)cellIdentifier;

+ (CGFloat)cellHeightWith:(SCImageModel *)model;

@end
