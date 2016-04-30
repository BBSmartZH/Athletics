//
//  SCGlobaUtil.h
//  SCFramework
//
//  Created by 申闯 on 15/4/10.
//  Copyright (c) 2015年 申闯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

typedef void (^SCBoolResultBlock)(BOOL result);
typedef void (^SCStringResultBlock)(NSString *result);

@interface SCGlobaUtil : NSObject

/**
 *正则匹配手机号
 */
+ (BOOL)validateMobileNumber:(NSString *)string;

/**
 *正则匹配纯数字
 */
+ (BOOL)validateNumber:(NSString *)string;

/**
 *判断字符串为空
 */
+ (BOOL)isEmpty:(NSString *)string;

/**
 *正则匹配——禁止输入中文且是6-16位之间非空格的任意字符
 */
+ (BOOL)validatePassword:(NSString *)string;

/**
 *拨打电话
 */
+ (void)callAndBack:(NSString *)phoneNum;

/**
 *  base64
 *
 *  @param string 将字符串转换成二进制数据后，再进行base64编码
 *
 *  @return 返回base64编码后的字符串
 */
+ (NSString *)base64:(NSString *)string;

/**
 *  md5加密
 *
 *  @param string 将字符串本身进行md5加密，并将加密后的字符串返回 （大写）
 *
 *  @return 返回加密后的字符串
 */
+ (NSString *)md5:(NSString *)string;

/**
 *  md5加密
 *
 *  @param string 将字符串本身进行md5加密，并将加密后的字符串返回 （小写）
 *
 *  @return 返回加密后的字符串
 */
+ (NSString *)md5_s:(NSString *)string;

/**
 *  判断是否为字典
 *
 *  @return
 */
+ (BOOL)isInvalidDict:(id)dict;

/**
 *获得int
 */
+ (int)getInt:(id)object;

/**
 *获得int
 */
+ (int)getInt:(id)object default:(int)defaultValue;

/**
 *获得float
 */
+ (float)getFloat:(id)object;

/**
 *获得字符串
 */
+ (NSString*)getString:(id)object;

/**
 *获得字符串，默认字符串
 */
+ (NSString*)getString:(id)object defaultValue:(NSString*)defalutValue;

/**
 *  从字符串中取得每一个字符
 */
+ (NSArray *)wordsFromeString:(NSString *)string;

/**
 *  获取当前的VC
 */
+ (UIViewController *)getCurrentViewController;

#pragma mark - 获取JSON数据
/**
 *  获取JSON数据
 *
 *  @param object OC类型对象
 *
 *  @return 如果转换失败，返回nil，否则返回JSON格式数据
 */
+ (NSMutableData *)JSONDataWithObject:(id)object;

+ (NSString *)JSONStringWithObject:(id)object;
/**
 *  获取网卡的MAC地址
 *
 */
+ (NSString *)getMacAddress;

+ (NSString *)getIDFA;

+ (NSString *)getUUID;

/**
 *  取得高度
 */
+ (CGSize)sizeWithText:(NSString *)text width:(CGFloat)width attributes:(NSDictionary *)attributes;
+ (CGFloat)heightOfLineWithFont:(CGFloat)font;
+ (CGSize)sizeOfLabelWith:(NSString *)text font:(CGFloat)font width:(CGFloat)width;

@end
