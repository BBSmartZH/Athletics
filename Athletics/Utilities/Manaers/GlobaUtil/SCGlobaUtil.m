//
//  SCGlobaUtil.m
//  SCFramework
//
//  Created by 申闯 on 15/4/10.
//  Copyright (c) 2015年 申闯. All rights reserved.
//

#import "SCGlobaUtil.h"
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>

@implementation SCGlobaUtil

/**
 *正则匹配手机号
 */
+ (BOOL)validateMobileNumber:(NSString *)string {
    static NSString *tempStr = @"^((\\+86)?|\\(\\+86\\))0?1\\d{10}$";
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]initWithPattern:tempStr options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
    if(numberofMatch > 0)
    {
        return YES;
    }else{
        return NO;
    }
}

/**
 *正则匹配纯数字
 */
+ (BOOL)validateNumber:(NSString *)string {
    static NSString *tempStr = @"^[0-9]+$";
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]initWithPattern:tempStr options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
    if(numberofMatch > 0)
    {
        return YES;
    }else{
        return NO;
    }
}

/**
 *判断字符串为空
 */
+ (BOOL)isEmpty:(NSString *)string {
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if (string == nil || [string length] == 0) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *正则匹配——禁止输入中文且是6-16位之间非空格的任意字符
 */
+ (BOOL)validatePassword:(NSString *)string {
    static NSString *tempStr = @"^[^\\s\u4e00-\u9fa5]{6,16}$";
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]initWithPattern:tempStr options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
    if(numberofMatch > 0)
    {
        return YES;
    }else{
        return NO;
    }
}

/**
 *拨打电话
 */
+ (void)callAndBack:(NSString *)phoneNum {
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",phoneNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
}

/**
 *  base64
 *
 *  @param string 将字符串转换成二进制数据后，再进行base64编码
 *
 *  @return 返回base64编码后的字符串
 */
+ (NSString *)base64:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *result = [data base64EncodedStringWithOptions:0];
    return result;
}

/**
 *  md5加密
 *
 *  @param string 将字符串本身进行md5加密，并将加密后的字符串返回 （大写）
 *
 *  @return 返回加密后的字符串
 */
+ (NSString *)md5:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

/**
 *  md5加密
 *
 *  @param string 将字符串本身进行md5加密，并将加密后的字符串返回 （小写）
 *
 *  @return 返回加密后的字符串
 */
+ (NSString *)md5_s:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

/**
 *  判断是否为字典
 *
 *  @return
 */
+ (BOOL)isInvalidDict:(id)dict {
    if (dict == nil || ![dict isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    return YES;
}

/**
 *获得int
 */
+ (int)getInt:(id)object {
    return [self getInt:object default:0];
}

/**
 *获得int
 */
+ (int)getInt:(id)object default:(int)defaultValue {
    if ([object isEqual:[NSNull null]]) {
        return defaultValue;
    }
    if ([object respondsToSelector:@selector(intValue)]) {
        return [object intValue];
    }
    return defaultValue;
}

/**
 *获得float
 */
+ (float)getFloat:(id)object {
    if ([object isEqual:[NSNull null]]) {
        return 0.0f;
    }
    if ([object respondsToSelector:@selector(floatValue)]) {
        return [object floatValue];
    }
    return 0.0f;
}

/**
 *获得字符串
 */
+ (NSString*)getString:(id)object {
    if ([object isEqual:[NSNull null]]) {
        return nil;
    }
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    } else if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber*)object stringValue];
    }
    return nil;
}

/**
 *获得字符串，默认字符串
 */
+ (NSString*)getString:(id)object defaultValue:(NSString*)defalutValue {
    if ([object isEqual:[NSNull null]]) {
        return defalutValue;
    }
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    } else if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber*)object stringValue];
    }
    return defalutValue;
}

/**
 *  从字符串中取得每一个字符
 */
+ (NSArray *)wordsFromeString:(NSString *)string {
    NSMutableArray *words = [[NSMutableArray alloc] init];
    const char *str = [string cStringUsingEncoding:NSUTF8StringEncoding];
    char *word;
    for (int i = 0; i < strlen(str);) {
        int len = 0;
        if (str[i] >= 0xFFFFFFFC) {
            len = 6;
        } else if (str[i] >= 0xFFFFFFF8) {
            len = 5;
        } else if (str[i] >= 0xFFFFFFF0) {
            len = 4;
        } else if (str[i] >= 0xFFFFFFE0) {
            len = 3;
        } else if (str[i] >= 0xFFFFFFC0) {
            len = 2;
        } else if (str[i] >= 0x00) {
            len = 1;
        }
        word = malloc(sizeof(char) * (len + 1));
        for (int j = 0; j < len; j++) {
            word[j] = str[j + i];
        }
        word[len] = '\0';
        i = i + len;
        NSString *oneWord = [NSString stringWithCString:word encoding:NSUTF8StringEncoding];
        free(word);
        [words addObject:oneWord];
    }
    return words;
}

/**
 *  获取当前的VC
 */
+ (UIViewController *)getCurrentViewController {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

#pragma mark - 获取JSON数据
/**
 *  获取JSON数据
 *
 *  @param object OC类型对象
 *
 *  @return 如果转换失败，返回nil，否则返回JSON格式数据
 */
+ (NSMutableData *)JSONDataWithObject:(id)object {
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    NSMutableData *postBodyData = nil;
    if ([NSJSONSerialization isValidJSONObject:object]) {
        NSError *error = nil;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:object
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        if (error) {
            NSLog(@"error: %@", error.description);
        } else {
            postBodyData = [[NSMutableData alloc] initWithData:postData];
        }
    }
    return postBodyData;
}

+ (NSString *)JSONStringWithObject:(id)object {
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    NSMutableData *data = [self JSONDataWithObject:object];
    if (data.length) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

#pragma mark - 获取MAC地址
+ (NSString *)getMacAddress {
    int                    mib[6];
    size_t                 len;
    char                   *buf;
    unsigned char          *ptr;
    struct if_msghdr       *ifm;
    struct sockaddr_dl     *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) > 0) {
        free(buf);
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return [outstring uppercaseString];
}

+ (CGFloat)heightOfLineWithFont:(CGFloat)font {
    NSString *str = @"测试CeShi9999！!@~——#";
    // 计算文本的大小  ios7.0
    CGSize size = [self sizeOfLabelWith:str font:font width:MAXFLOAT];
    return size.height;
}

+ (CGSize)sizeOfLabelWith:(NSString *)text font:(CGFloat)font width:(CGFloat)width {
    CGSize size = CGSizeZero;
    if (kIsIOS7OrLater) {
        // 计算文本的大小  ios7.0
        size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}        // 文字的属性
                                         context:nil].size;
    }
    
    return size;
    
}

@end
