//
//  SCPhotoManager.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/28.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SCPickerCompelitionBlock)(UIImage *image);
typedef void(^SCPickerCancelBlock)();

@interface SCPhotoManager : NSObject

+ (instancetype)shared;
- (instancetype)shared;

- (void)showActionSheetInView:(UIView *)inView
               fromController:(UIViewController *)fromController
                   completion:(SCPickerCompelitionBlock)completion
                       cancel:(SCPickerCancelBlock)cancel;

@end
