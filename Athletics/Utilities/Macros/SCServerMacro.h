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

#define kBaseUrl @"http://218.244.131.231:8080"
//   /esports
#else

//测试环境

#define kBaseUrl @"http://218.244.131.231:8080"
//#define kBaseUrl @"http://127.0.0.1:8080"
//#define kBaseUrl @"http://192.168.1.103:8080"
//#define kBaseUrl @"http://192.168.1.30:8081"


#endif




#else // 发布环境  1 正式  0 测试


#if 1

//正式环境

#define kBaseUrl @"http://218.244.131.231:8080"

#else

//测试环境

#define kBaseUrl @"http://192.168.1.103:8080"

#endif




#endif


#endif /* SCServerMacro_h */
