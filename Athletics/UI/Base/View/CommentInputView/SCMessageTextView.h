//
//  SCMessageTextView.h
//  EMDemo
//
//  Created by mrzj_sc on 16/3/11.
//  Copyright © 2016年 mrzj_sc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SCTextViewInputType) {
    SCTextViewInputTypeNormal = 0,//普通
    SCTextViewInputTypeText,//文本
    SCTextViewInputTypeFace,//表情
    SCTextViewInputTypeMenu,//菜单
};



@interface SCMessageTextView : UITextView

/**
 *  提示用户输入的标语
 **/
@property (nonatomic,copy) NSString *placeHolder;

/**
 *  标语文本的颜色
 **/
@property (nonatomic,strong) UIColor *placeHolderTextColor;

/**
 *  获取自身文本占据有多少行
 *
 *  @return 返回行数
 */
- (NSUInteger)numberOfLinesOfText;

/**
 *  获取每行的高度
 *
 *  @return 根据iPhone或者iPad来获取每行字体的高度
 */
+ (NSUInteger)maxCharactersPerLine;

/**
 *  获取某个文本占据自身适应宽带的行数
 *
 *  @param text 目标文本
 *
 *  @return 返回占据行数
 */
+ (NSUInteger)numberOfLinesForMessage:(NSString *)text;

@end