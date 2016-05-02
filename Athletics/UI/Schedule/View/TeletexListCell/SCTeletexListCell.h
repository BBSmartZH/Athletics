//
//  SCTeletexListCell.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/19.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCTeletextListDataModel;
@interface SCTeletexListCell : UITableViewCell

-(void)creatLayoutWith:(SCTeletextListDataModel *)model;
+(NSString*)cellIdentifier;

@end
