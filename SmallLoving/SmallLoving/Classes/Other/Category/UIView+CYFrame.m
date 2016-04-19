//
//  UIView+CYFrame.m
//  CYCarouselFigure
//
//  Created by Cheney on 3/1/16.
//  Copyright © 2016 Cheney. All rights reserved.
//

#import "UIView+CYFrame.h"

@implementation UIView (CYFrame)


- (void)setCy_x:(CGFloat)cy_x {
    CGRect frame = self.frame;
    frame.origin.x = cy_x;
    self.frame = frame;
}

- (CGFloat)cy_x {
    return self.frame.origin.x;
}


- (void)setCy_y:(CGFloat)cy_y {
    CGRect frame = self.frame;
    frame.origin.y = cy_y;
    self.frame = frame;
}

- (CGFloat)cy_y {
    return self.frame.origin.y;
}

- (void)setCy_width:(CGFloat)cy_width {
    CGRect frame = self.frame;
    frame.size.width = cy_width;
    self.frame = frame;
}

- (CGFloat)cy_width {
    return self.frame.size.width;
}

- (void)setCy_height:(CGFloat)cy_height {
    CGRect frame = self.frame;
    frame.size.height = cy_height;
    self.frame = frame;
}

- (CGFloat)cy_height {
    return self.frame.size.height;
}

- (void)setCy_size:(CGSize)cy_size {
    CGRect frame = self.frame;
    frame.size = cy_size;
    self.frame = frame;
}

- (CGSize)cy_size {
    return self.frame.size;
}

- (void)setCy_origin:(CGPoint)cy_origin {
    CGRect frame = self.frame;
    frame.origin = cy_origin;
    self.frame = frame;
}

- (CGPoint)cy_origin {
    return self.frame.origin;
}

- (void)setCy_centerX:(CGFloat)cy_centerX {
    CGPoint center = self.center;
    center.x = cy_centerX;
    self.center = center;
}

- (CGFloat)cy_centerX {
    return self.center.x;
}

- (void)setCy_centerY:(CGFloat)cy_centerY {
    CGPoint center = self.center;
    center.y = cy_centerY;
    self.center = center;
}

- (CGFloat)cy_centerY {
    return self.center.y;
}

@end
