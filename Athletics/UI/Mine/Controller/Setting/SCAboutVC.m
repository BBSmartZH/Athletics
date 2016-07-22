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
    companyLabel.text = @"      Google（中文名：谷歌），是一家美国的跨国科技企业，致力于互联网搜索、云计算、广告技术等领域，开发并提供大量基于互联网的产品与服务，其主要利润来自于AdWords等广告服务。";
    [self.view addSubview:companyLabel];
    
    UILabel *productLabel = [[UILabel alloc] init];
    productLabel.textColor = kWord_Color_Event;
    productLabel.numberOfLines = 0;
    productLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
    productLabel.text = @"      1998年9月4日，Google以私营公司的形式创立，设计并管理一个互联网搜索引擎“Google搜索”。Google网站则于1999年下半年启用。Google的使命是整合全球信息，使人人皆可访问并从中受益。";
    [self.view addSubview:productLabel];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];

    UILabel *copyrightLabel = [[UILabel alloc] init];
    copyrightLabel.textColor = kWord_Color_Event;
    copyrightLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    copyrightLabel.textAlignment = NSTextAlignmentCenter;
    copyrightLabel.numberOfLines = 0;
    copyrightLabel.text = [NSString stringWithFormat:@"版本v%@\nCopyright © 1990-2016 google.com\n*********科技有限公司", version];
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
