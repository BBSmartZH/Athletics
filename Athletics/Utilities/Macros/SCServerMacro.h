//
//  SCServerMacro.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/21.
//  Copyright © 2016年 李宛. All rights reserved.
//

#ifndef SCServerMacro_h
#define SCServerMacro_h


#if DEBUG // 开发环境  1 正式  0 测试

#if 0

//正式环境

#define kBaseUrl @"http://venus.meirongzongjian.com"

#else

//测试环境

//#define kBaseUrl @"http://192.168.31.196:8080"
//#define kBaseUrl @"http://127.0.0.1:8080"
#define kBaseUrl @"http://192.168.1.106:8080"


#endif




#else // 发布环境  1 正式  0 测试


#if 1

//正式环境

#define kBaseUrl @"http://venus.meirongzongjian.com"

#else

//测试环境

#define kBaseUrl @"http://training.venus.meirongzongjian.com"

#endif




#endif


#endif /* SCServerMacro_h */
