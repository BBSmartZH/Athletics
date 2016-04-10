//
//  LWEventsVC_iPhone.m
//  Athletics
//
//  Created by 李宛 on 16/4/9.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWEventsVC_iPhone.h"
#import "LWCustomizeVC_iPhone.h"
@interface LWEventsVC_iPhone ()

@end

@implementation LWEventsVC_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *editingButton = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(xwp_edting:)];
    self.navigationItem.rightBarButtonItem = editingButton;

   
}

-(void)xwp_edting:(UIBarButtonItem*)sender
{
    LWCustomizeVC_iPhone *customizeVC = [[LWCustomizeVC_iPhone alloc]init];
    [self.navigationController pushViewController:customizeVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
