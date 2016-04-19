//
//  UIView+ViewFrameExt.m
//  day3
//
//  Created by xiaozhe on 15/4/15.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

#import "UIView+ViewFrameExt.h"

@implementation UIView (ViewFrameExt)

- (void)setX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    
    self.frame = rect;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setOrigin:(CGPoint)origin
{
    [self setX:origin.x];
    [self setY:origin.y];
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    
    self.frame = rect;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    [self setHeight:size.height];
    [self setWidth:size.width];
}

- (CGSize)size
{
    return self.frame.size;
}

@end
