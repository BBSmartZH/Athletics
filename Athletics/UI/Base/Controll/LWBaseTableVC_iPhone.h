//
//  LWBaseTableVC_iPhone.h
//  Link
//
//  Created by 李宛 on 16/3/10.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWBaseVC_iPhone.h"

@interface LWBaseTableVC_iPhone : LWBaseVC_iPhone<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray   *_datasource;
    UITableView *_tableView;
}
- (instancetype)initWithStyle:(UITableViewStyle)style;

@end
