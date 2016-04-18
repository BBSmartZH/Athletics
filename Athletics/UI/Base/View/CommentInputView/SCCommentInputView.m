//
//  SCCommentInputView.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/17.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCCommentInputView.h"

#import "NSString+Message.h"

@interface SCCommentInputView ()<UITextViewDelegate>

@property (nonatomic, strong, readwrite) UIButton *commentButton;
@property (nonatomic, strong, readwrite) SCMessageTextView *inputTextView;
@property (nonatomic) CGFloat previousTextViewContentHeight;//上一次inputTextView的contentSize.height

@end

@implementation SCCommentInputView

- (void)dealloc {
    [self.inputTextView removeObserver:self forKeyPath:@"contentSize"];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    // 当别的地方需要add的时候，就会调用这里
    if (newSuperview) {
        [self setupCommentInputView];
    }
}

- (void)setup {
    //配置自适应
    self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin);
    self.opaque = YES;
    self.userInteractionEnabled = YES;
}

#pragma mark - 添加控件
- (void)setupCommentInputView {
    if (_isComment) {
        UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [commentButton addTarget:self action:@selector(commentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        commentButton.titleLabel.font = [UIFont systemFontOfSize:kWord_Font_24px];
        commentButton.frame = CGRectMake(self.bounds.size.width - 50 - 10 , 10, 50.0, 24.0);
        commentButton.backgroundColor = [UIColor clearColor];
        commentButton.layer.borderColor = k_Border_Color.CGColor;
        commentButton.layer.borderWidth = .5f;
        [self addSubview:commentButton];
        self.commentButton = commentButton;
    }
    
    SCMessageTextView *textView = [[SCMessageTextView alloc] initWithFrame:CGRectZero];
    textView.backgroundColor = [UIColor whiteColor];
    textView.returnKeyType = UIReturnKeySend;
    textView.enablesReturnKeyAutomatically = YES;
    textView.placeHolderTextColor = kWord_Color_Low;
    textView.textColor = kWord_Color_High;
    textView.placeHolder = @"别憋着，说点什么吧~";
    textView.delegate = self;
    [self addSubview:textView];
    self.inputTextView = textView;
    
    CGFloat width = CGRectGetWidth(self.bounds) - (_isComment ? _commentButton.bounds.size.width + 10 : 0) - 20;
    
    _inputTextView.frame = CGRectMake(10, 7, width, 30);
    _inputTextView.backgroundColor = [UIColor clearColor];
    _inputTextView.layer.borderColor = k_Border_Color.CGColor;
    _inputTextView.layer.borderWidth = .5f;
    
    self.previousTextViewContentHeight = _inputTextView.bounds.size.height;
    [self.inputTextView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
};

#pragma mark - Button Action
- (void)commentButtonClicked:(UIButton *)sender {
    self.inputTextView.text = @"";
    [self.inputTextView resignFirstResponder];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(commentButtonClicked:)]) {
        [self.delegate commentButtonClicked:sender];
    }
}

#pragma mark - Message input view

- (void)adjustTextViewHeightBy:(CGFloat)changeInHeight {
    // 动态改变自身的高度和输入框的高度
    CGRect prevFrame = self.inputTextView.frame;
    NSUInteger numLines = MAX([self.inputTextView numberOfLinesOfText],
                              [self.inputTextView.text numberOfLines]);
    
    self.inputTextView.frame = CGRectMake(prevFrame.origin.x,
                                                 prevFrame.origin.y,
                                                 prevFrame.size.width,
                                                 prevFrame.size.height + changeInHeight);
    
    
    self.inputTextView.contentInset = UIEdgeInsetsMake((numLines >= [SCCommentInputView maxLines] ? 4.0f : 0.0f),
                                                              0.0f,
                                                              (numLines >= [SCCommentInputView maxLines] ? 4.0f : 0.0f),
                                                              0.0f);
    
    // from iOS 7, the content size will be accurate only if the scrolling is enabled.
    self.inputTextView.scrollEnabled = YES;
    
    if (numLines >= [SCCommentInputView maxLines]) {
        CGPoint bottomOffset = CGPointMake(0.0f, self.inputTextView.contentSize.height - self.inputTextView.bounds.size.height);
        [self.inputTextView setContentOffset:bottomOffset animated:YES];
        [self.inputTextView scrollRangeToVisible:NSMakeRange(self.inputTextView.text.length - 2, 1)];
    }
}

- (void)layoutAndAnimateMessageInputTextView:(UITextView *)textView {
    CGFloat maxHeight = [SCCommentInputView maxHeight];
    
    CGFloat contentH = [self getTextViewContentH:textView];
    
    BOOL isShrinking = contentH < self.previousTextViewContentHeight;
    CGFloat changeInHeight = contentH - _previousTextViewContentHeight;
    
    if (!isShrinking && (self.previousTextViewContentHeight == maxHeight || textView.text.length == 0)) {
        changeInHeight = 0;
    }else {
        changeInHeight = MIN(changeInHeight, maxHeight - self.previousTextViewContentHeight);
    }
    
    if (changeInHeight != 0) {
        [UIView animateWithDuration:0.25 animations:^{
            if (isShrinking) {
                self.previousTextViewContentHeight = MIN(contentH, maxHeight);

                // if shrinking the view, animate text view frame BEFORE input view frame
                [self adjustTextViewHeightBy:changeInHeight];
            }
            //delegate
            CGRect inputViewFrame = self.frame;
            inputViewFrame.origin.y -= changeInHeight;
            inputViewFrame.size.height += changeInHeight;
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(inputViewDidChangedFrame:)]) {
                [self.delegate inputViewDidChangedFrame:inputViewFrame];
            }
            
            if (!isShrinking) {
                self.previousTextViewContentHeight = MIN(contentH, maxHeight);

                // growing the view, animate the text view frame AFTER input view frame
                [self adjustTextViewHeightBy:changeInHeight];
            }
        }];
        self.previousTextViewContentHeight = MIN(contentH, maxHeight);
    }
    
    if (self.previousTextViewContentHeight == maxHeight) {
        double delayInSeconds = 0.01;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime,
                       dispatch_get_main_queue(),
                       ^(void) {
                           CGPoint bottomOffset = CGPointMake(0.0f, contentH - textView.bounds.size.height);
                           [textView setContentOffset:bottomOffset animated:YES];
                       });
    }
}

#pragma mark - UITextView Helper method

- (CGFloat)getTextViewContentH:(UITextView *)textView {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        return ceilf([textView sizeThatFits:textView.frame.size].height);
    } else {
        return textView.contentSize.height;
    }
}

+ (CGFloat)textViewLineHeight{
//    [SCGlobaUtil heightOfLineWithFont:16.0];
    return [SCGlobaUtil heightOfLineWithFont:16.0];// 字体大小为16
}

+ (CGFloat)maxHeight{
    return [SCCommentInputView maxLines] * [SCCommentInputView textViewLineHeight] + 8;
}

+ (CGFloat)maxLines{
    return 3.0;
}

#pragma mark - textViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(inputTextViewWillBeginEditing:)])
    {
        [self.delegate inputTextViewWillBeginEditing:self.inputTextView];
    }
    self.commentButton.enabled = NO;
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    [textView becomeFirstResponder];
    
    if ([self.delegate respondsToSelector:@selector(inputTextViewDidBeginEditing:)]) {
        [self.delegate inputTextViewDidBeginEditing:self.inputTextView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    self.commentButton.enabled = YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        if ([self.delegate respondsToSelector:@selector(inputTextViewDidSendMessage:)]) {
            [self.delegate inputTextViewDidSendMessage:self.inputTextView];
            //成功了清空输入框   失败不清除
        }
        return NO;
    }
    return YES;
}



#pragma mark - Key-value observing

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (object == self.inputTextView && [keyPath isEqualToString:@"contentSize"]) {
        [self layoutAndAnimateMessageInputTextView:object];
    }
}

@end
