//
//  SCMessageTextView.m
//  EMDemo
//
//  Created by mrzj_sc on 16/3/11.
//  Copyright © 2016年 mrzj_sc. All rights reserved.
//

#import "SCMessageTextView.h"

@implementation SCMessageTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_setUp];
    }
    return self;
}

- (void)dealloc{
    _placeHolder = nil;
    _placeHolderTextColor = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UITextViewTextDidChangeNotification
                                                 object:self];
}

- (void)p_didReceiveTextDidChangeNotification:(NSNotification *)notification{
    [self setNeedsDisplay];
}

- (void)p_setUp {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_didReceiveTextDidChangeNotification:) name:UITextViewTextDidChangeNotification object:self];
    _placeHolderTextColor = [UIColor lightGrayColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.scrollIndicatorInsets = UIEdgeInsetsMake(5.0f, 0.0f, 5.0f, 0.0f);
    self.contentInset = UIEdgeInsetsZero;
    self.scrollEnabled = YES;
    self.scrollsToTop = YES;
    self.userInteractionEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    self.font = [UIFont systemFontOfSize:15.0f];
    self.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor whiteColor];
    self.keyboardAppearance = UIKeyboardAppearanceDefault;
    self.keyboardType = UIKeyboardTypeDefault;
    self.returnKeyType = UIReturnKeyDefault;
    self.textAlignment = NSTextAlignmentLeft;
    
}

#pragma mark - MessageTextView Set
- (void)setPlaceHolder:(NSString *)placeHolder {
    if ([placeHolder isEqualToString:_placeHolder]) {
        return;
    }
    
    NSInteger maxChars = [SCMessageTextView maxCharactersPerLine];
    if ([placeHolder length] > maxChars) {
        placeHolder = [placeHolder substringToIndex:maxChars - 8];
        placeHolder = [[placeHolder stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] stringByAppendingFormat:@"..."];
    }
    
    _placeHolder = placeHolder;
    [self setNeedsDisplay];
}

- (void)setPlaceHolderTextColor:(UIColor *)placeHolderTextColor {
    if ([placeHolderTextColor isEqual:placeHolderTextColor]) {
        return;
    }
    
    _placeHolderTextColor = placeHolderTextColor;
    [self setNeedsDisplay];
}

#pragma mark - MessageTextView methods
- (NSUInteger)numberOfLinesOfText {
    return [SCMessageTextView numberOfLinesForMessage:self.text];
}

+ (NSUInteger)maxCharactersPerLine {
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? 33 : 109;
}

+ (NSUInteger)numberOfLinesForMessage:(NSString *)text {
    return (text.length / [SCMessageTextView maxCharactersPerLine]) + 1;
}

#pragma mark - 重写UITextView父类方法
- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)insertText:(NSString *)text {
    [super insertText:text];
    [self setNeedsDisplay];
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    [super setContentInset:contentInset];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

#pragma mark - DrawRext
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.text.length == 0 && self.placeHolder) {
        CGRect placeHolderRect = CGRectMake(10.0f, 7.0f, rect.size.width, rect.size.height);
        
        if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
            NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
            paragrapStyle.lineBreakMode = NSLineBreakByTruncatingTail;
            paragrapStyle.alignment = self.textAlignment;
            
            [self.placeHolder drawInRect:placeHolderRect withAttributes:@{NSFontAttributeName : self.font, NSForegroundColorAttributeName : self.placeHolderTextColor, NSParagraphStyleAttributeName : paragrapStyle}];
        }
    }
}
















@end
