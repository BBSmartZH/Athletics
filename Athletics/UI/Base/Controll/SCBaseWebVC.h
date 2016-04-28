//
//  SCBaseWebVC.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/27.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWBaseVC_iPhone.h"

@interface SCBaseWebVC : LWBaseVC_iPhone

@property (nonatomic, assign) BOOL needsAppend;//defaule is YES
@property (nonatomic, copy) NSString *webUrl;

- (void)loadWebUrl;

- (NSString *)webTitle;

- (void)share;

@end


#pragma mark - SCWebToolBar

typedef void (^WebToolBarBlock)(NSInteger index);

@interface SCWebToolBar : UIView

@property (nonatomic, copy) WebToolBarBlock clickedBlock;

@end


