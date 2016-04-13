//
//  SCTopScrollView.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/10.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCTopScrollView.h"

@interface SCTopScrollView ()
{
    UIScrollView *_scrollView;
    UIView *_bgView;
    NSMutableArray *_titleArray;
    NSMutableArray *_buttonArray;
    SCTopButton *_currentButton;
    NSInteger _selectedIndex;
    CGFloat _totalWidth;
    float _part;
}

@end

static CGFloat textFont = 17.0f;
static CGFloat bgInset = 2.0f;

@implementation SCTopScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _space = 5.0f;
        [self uiConfig];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setSpace:(CGFloat)space {
    if (_space != space) {
        _space = space;
        
        [self setNeedsDisplay];
    }
}

- (void)uiConfig {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:_scrollView];
    
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:_bgView];
    
    _titleArray = [NSMutableArray array];
    _buttonArray = [NSMutableArray array];
}

- (void)updateWithTitleArray:(NSArray *)titleArray selectedIndex:(NSInteger)selectedIndex {
    [_titleArray removeAllObjects];
    _titleArray = titleArray.mutableCopy;
    _selectedIndex = selectedIndex;
    
    [self setNeedsDisplay];
}

- (void)topButtonClicked:(SCTopButton *)sender {
    if (sender.isSelected) {
        return;
    }
    
    _currentButton.selected = NO;
    _currentButton.titleLabel.alpha = 0.6f;
    _currentButton = sender;
    _currentButton.selected = YES;
    _currentButton.titleLabel.alpha = 1.0f;
    
    _bgView.layer.cornerRadius = sender.bounds.size.height / 2.0f;
    [UIView animateWithDuration:0.2 animations:^{
        _bgView.frame = CGRectMake(sender.frame.origin.x - bgInset, sender.frame.origin.y, sender.frame.size.width + bgInset * 2, sender.bounds.size.height);
    }];
    

    
    if (_scrollView.contentSize.width > self.bounds.size.width) {
        CGFloat offsetX = 0.0f;
        if (sender.center.x <= _scrollView.bounds.size.width / 2.0) {
            offsetX = 0.0f;
        }else if (_scrollView.contentSize.width - sender.center.x <= _scrollView.bounds.size.width / 2.0) {
            offsetX = _scrollView.contentSize.width - _scrollView.bounds.size.width;
        }else {
            offsetX = sender.center.x - _scrollView.center.x;
        }
        
        [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(topScrollButtonClicked:)]) {
        [self.delegate topScrollButtonClicked:sender];
    }
    
}

- (void)scrollToPage:(NSInteger)page {
    if (page < _buttonArray.count) {
        SCTopButton *button = [_buttonArray objectAtIndex:page];
        [self topButtonClicked:button];
    }
}

- (void)topScrollViewScrollPart:(float)part page:(NSInteger)page {
    
    
//    SCTopButton *frontButton;
//    SCTopButton *behindButton;
//    
//    if (page >= 0 && page + 1 <= _buttonArray.count - 1) {
//        frontButton = [_buttonArray objectAtIndex:page];
//        behindButton = [_buttonArray objectAtIndex:page + 1];
//    }
//    
//    
//    if (_scrollView.contentSize.width > self.bounds.size.width) {
//        
//        
//        
//        CGFloat bgViewWidth = _bgView.bounds.size.width;
//        CGFloat bgViewFX = _bgView.frame.origin.x;
//        if (_part < part) {
//            //左划
//            if (frontButton.center.x >= _scrollView.center.x && frontButton.center.x <= _scrollView.contentSize.width - _scrollView.bounds.size.width / 2.0) {
//                //现在已经居中 bgView 居中显示  scrollView需要滚动
//                
//                CGFloat gapW = behindButton.bounds.size.width - frontButton.bounds.size.width  + bgInset * 2;
//                bgViewWidth = frontButton.bounds.size.width + (part - (1.0 / _buttonArray.count) * page) * _buttonArray.count * gapW;
//                
//                CGFloat gapX = behindButton.frame.origin.x - frontButton.frame.origin.x - gapW / 2.0;
//                bgViewFX = frontButton.frame.origin.x + (part - (1.0 / _buttonArray.count) * page) * _buttonArray.count * gapX;
//                
//                
//                
//                
//                
//                [_scrollView setContentOffset:CGPointMake(bgViewFX + frontButton.bounds.size.width / 2.0 - _scrollView.bounds.size.width / 2.0, 0)];
//            }
//            
//            
//            
////            if (_scrollView.contentOffset.x + _scrollView.bounds.size.width <= _scrollView.contentSize.width) {
////                [_scrollView setContentOffset:CGPointMake(_scrollView.contentSize.width * part, 0)];
////            }
//        }else {
//            //右划
////            if (_scrollView.contentOffset.x >= 0) {
////                [_scrollView setContentOffset:CGPointMake(_scrollView.contentSize.width * part, 0)];
////            }
//        }
//        _bgView.frame = CGRectMake(bgViewFX, _bgView.frame.origin.y, bgViewWidth, _bgView.bounds.size.height);
//        _part = part;
//    }else {
//        //scrollView 不动  改变bgView的frame
//        CGFloat bgViewWidth = _bgView.bounds.size.width;
//        CGFloat bgViewFX = _bgView.frame.origin.x;
//        if (_part < part) {
//            //左划
//            if (frontButton && behindButton) {
//                
//                CGFloat gapW = behindButton.bounds.size.width - frontButton.bounds.size.width;
//                bgViewWidth = frontButton.bounds.size.width + bgInset * 2 + (part - (1.0 / _buttonArray.count) * page) * _buttonArray.count * gapW;
//                
//                CGFloat gapX = behindButton.frame.origin.x - frontButton.frame.origin.x;
//                bgViewFX = frontButton.frame.origin.x + (part - (1.0 / _buttonArray.count) * page) * _buttonArray.count * gapX;
//            }
//        }else {
//            //右划
//            if (frontButton && behindButton) {
//                CGFloat gapW = frontButton.bounds.size.width - behindButton.bounds.size.width;
//                bgViewWidth = behindButton.bounds.size.width  + bgInset * 2 + ((1.0 / _buttonArray.count) * (page + 1) - part) * _buttonArray.count * gapW;
//                
//                CGFloat gapX = frontButton.frame.origin.x - behindButton.frame.origin.x;
//                bgViewFX = behindButton.frame.origin.x + ((1.0 / _buttonArray.count) * (page + 1) - part) * _buttonArray.count * gapX;
//            }
//        }
//        _bgView.frame = CGRectMake(bgViewFX, _bgView.frame.origin.y, bgViewWidth, _bgView.bounds.size.height);
//        NSLog(@"+++++++++++++++++++++++++++++%@", _bgView);
//        _part = part;
//    }
//    
//    
//    
    
    
    
    
    
    
//    if (_totalWidth >= self.bounds.size.width) {
//        NSInteger firstButtonIndex = 0;
//        NSInteger lastButtonIndex = _buttonArray.count - 1;
//        
//        for (int i = 0; i < _buttonArray.count; i++) {
//            SCTopButton *button = [_buttonArray objectAtIndex:i];
//            if (button.center.x > _scrollView.bounds.size.width / 2.0f) {
//                firstButtonIndex = i;
//                break;
//            }
//        }
//        
//        for (NSInteger i = _buttonArray.count; i >= 0; i--) {
//            SCTopButton *button = [_buttonArray objectAtIndex:i];
//            if (_scrollView.contentSize.width - button.center.x <= _scrollView.bounds.size.width / 2.0) {
//                lastButtonIndex = i;
//                break;
//            }
//        }
//    }else {
//        
//    }
//    
//    
//    if (part >= 0 && part <= (_titleArray.count - 1) / (float)_titleArray.count) {
//        [_scrollView setContentOffset:CGPointMake(_scrollView.contentSize.width * part, 0)];
//    }
    
    
}

- (CGSize)textWidthWithText:(NSString *)text {
    CGSize size = CGSizeZero;
    
    size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) // 用于计算文本绘制时占据的矩形块
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textFont]}        // 文字的属性
                                     context:nil].size;
    
    return size;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    [_buttonArray removeAllObjects];
    for (UIView *view in _scrollView.subviews) {
        if ([view isMemberOfClass:[SCTopButton class]]) {
            [view removeFromSuperview];
        }
    }
    
    _totalWidth = bgInset;
    for (int i = 0; i < _titleArray.count; i++) {
        NSString *title = [_titleArray objectAtIndex:i];
        CGFloat buttonWith = [self textWidthWithText:title].width;
        CGFloat buttonHeight = [self textWidthWithText:title].height;

        buttonWith += 6;
        buttonHeight += 4;
        
        SCTopButton *button = [SCTopButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(topButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(_totalWidth, (_scrollView.bounds.size.height - buttonHeight), buttonWith, buttonHeight);
        button.titleLabel.font = [UIFont systemFontOfSize:textFont];
        button.titleLabel.alpha = 0.6f;
        [_scrollView addSubview:button];
        [_buttonArray addObject:button];
        button.subTitle = title;
        button.buttonWidth = buttonWith;
        button.index = i;
        
        if (i != _titleArray.count - 1) {
            buttonWith += _space;
        }
        
        _totalWidth += buttonWith;
    }
    _totalWidth += bgInset;
    if (_totalWidth >= self.bounds.size.width) {
        _scrollView.frame = self.bounds;
        _scrollView.contentSize = CGSizeMake(_totalWidth, _scrollView.bounds.size.height);
    }else {
        _scrollView.frame = CGRectMake((self.bounds.size.width - _totalWidth) / 2.0, 0, _totalWidth, self.bounds.size.height);
        _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width, _scrollView.bounds.size.height);
    }
    
    if (_selectedIndex < _buttonArray.count) {
        [self topButtonClicked:[_buttonArray objectAtIndex:_selectedIndex]];
    }
    
    
    
}


@end




@implementation SCTopButton


- (void)setSubTitle:(NSString *)subTitle {
    if (_subTitle != subTitle) {
        _subTitle = subTitle;
        
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    
}

@end





