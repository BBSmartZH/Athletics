//
//  SCPostedChooseView.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCPostedChooseViewDelegate <NSObject>

- (void)deletePostedImageWith:(NSInteger)index;

@end

@interface SCPostedChooseView : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) NSInteger index;

@end
