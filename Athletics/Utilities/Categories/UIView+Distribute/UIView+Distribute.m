//
//  UIView+Distribute.m
//  MrzjExpert
//
//  Created by shenchuang on 15/8/6.
//  Copyright (c) 2015年 shenchuang. All rights reserved.
//

#import "UIView+Distribute.h"

@implementation UIView (Distribute)

- (CGFloat)left
{
    return self.frame.origin.x;
}
- (CGFloat)right
{
    return self.frame.origin.x + [self fWidth];
}
- (CGFloat)top
{
    return self.frame.origin.y;
}
- (CGFloat)bottom
{
    return self.frame.origin.y + [self fHeight];
}

- (CGFloat)fWidth
{
    return self.bounds.size.width;
}

- (CGFloat)fHeight
{
    return self.bounds.size.height;
}

@end
