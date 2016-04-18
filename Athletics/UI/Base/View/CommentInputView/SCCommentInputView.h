//
//  SCCommentInputView.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/17.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SCMessageTextView.h"


@protocol SCCommentInputViewDelegate <NSObject>

@required

- (void)inputViewDidChangedFrame:(CGRect)frame;

@optional
/**
 *  点击了评论按钮
 *
 *  @param sender 评论按钮
 */
- (void)commentButtonClicked:(UIButton *)sender;


/**
 *  输入框刚好开始编辑
 *
 *  @param messageInputTextView 输入框对象
 */
- (void)inputTextViewDidBeginEditing:(SCMessageTextView *)inputTextView;

/**
 *  输入框将要开始编辑
 *
 *  @param messageInputTextView 输入框对象
 */
- (void)inputTextViewWillBeginEditing:(SCMessageTextView *)inputTextView;

/**
 *  输入框发送输入框文字
 *
 *  @param messageInputTextView 输入框对象
 */
- (void)inputTextViewDidSendMessage:(SCMessageTextView *)inputTextView;

@end

@interface SCCommentInputView : UIImageView

@property (nonatomic, assign) id<SCCommentInputViewDelegate> delegate;

@property (nonatomic, strong, readonly) UIButton *commentButton;
@property (nonatomic, strong, readonly) SCMessageTextView *inputTextView;

@property (nonatomic, assign) BOOL isComment;

@end
