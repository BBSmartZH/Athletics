//
//  SCResponseModel.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/25.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCBaseModel.h"

@protocol
SCPageModel
@end

@interface SCPageModel : SCBaseModel

@property (nonatomic, strong) NSString<Optional>  *total; // 总页数int
@property (nonatomic, strong) NSString<Optional>  *size;  // 一页多少条int
@property (nonatomic, strong) NSString<Optional>  *page; // 当前第几页int

@end

@interface SCResponseModel : SCBaseModel

/**
 *  错误码
 */
@property (nonatomic, copy) NSString<Optional> *code;
/**
 *  提示信息
 */
@property (nonatomic, copy) NSString<Optional> *message;
/**
 *  调用成功或失败
 */
@property (nonatomic, copy) NSString<Optional> *success;
/**
 *  当前页
 */
@property (nonatomic, strong) SCPageModel<Optional> *paging;


@end
