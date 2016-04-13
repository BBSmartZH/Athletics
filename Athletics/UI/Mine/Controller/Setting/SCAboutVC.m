//
//  SCAboutVC.m
//  XiaoYaoUser
//
//  Created by Nick on 15/7/14.
//  Copyright (c) 2015年 xiaoyaor. All rights reserved.
//

#import "SCAboutVC.h"

@interface SCAboutVC ()

@end

@implementation SCAboutVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"关于我们";
    
    UIImageView *logoImageV = [[UIImageView alloc] initWithImage:kImageWithName(@"logo_about")];
    [self.view addSubview:logoImageV];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *companyLabel = [[UILabel alloc] init];
    companyLabel.textColor = kWord_Color_Event;
    companyLabel.numberOfLines = 0;
    companyLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    companyLabel.text = @"      北京宸宸科技有限公司成立于2014年，是一家专注美容行业服务的移动互联网公司。致力于依托移动互联网的方式，为传统美容行业开创新的模式和未来。";
    [self.view addSubview:companyLabel];
    
    UILabel *productLabel = [[UILabel alloc] init];
    productLabel.textColor = kWord_Color_Event;
    productLabel.numberOfLines = 0;
    productLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    productLabel.text = @"      “美容总监”是中国首家上门美容服务的O2O应用，为女性消费者提供顶级的上门美容服务。让消费者随时随地选择和预约自己中意的技师，足不出户就享受舒适、便捷、放心和良好效果的美容服务。";
    [self.view addSubview:productLabel];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];

    UILabel *copyrightLabel = [[UILabel alloc] init];
    copyrightLabel.textColor = kWord_Color_Event;
    copyrightLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    copyrightLabel.textAlignment = NSTextAlignmentCenter;
    copyrightLabel.numberOfLines = 0;
    copyrightLabel.text = [NSString stringWithFormat:@"版本v%@\nCopyright © 2014-2016 meirongzongjian.com\n北京宸宸科技有限公司", version];
    [self.view addSubview:copyrightLabel];
    
    _WEAKSELF(ws);
    [logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(192, 88));
        make.centerX.equalTo(ws.view);
        make.top.equalTo(ws.m_navBar.mas_bottom).offset(40);
    }];
    
    [companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageV.mas_bottom).offset(55);
        make.left.equalTo(ws.view).offset(30);
        make.right.equalTo(ws.view).offset(-30);
    }];
    
    [productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(companyLabel.mas_bottom).offset(15);
        make.left.right.equalTo(companyLabel);
    }];
    
    [copyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.view).offset(-25);
//        make.left.equalTo(ws.view).offset(30);
//        make.right.equalTo(ws.view).offset(-30);
        make.centerX.equalTo(ws.view);
    }];
    
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