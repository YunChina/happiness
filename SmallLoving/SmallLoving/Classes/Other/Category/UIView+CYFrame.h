//
//  UIView+CYFrame.h
//  CYCarouselFigure
//
//  Created by Cheney on 3/1/16.
//  Copyright © 2016 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CYFrame)

/**
 *  view frame 的 x 值
 */
@property (nonatomic) CGFloat cy_x;

/**
 *  view frame 的 y 值
 */
@property (nonatomic) CGFloat cy_y;

/**
 *  view frame 的 width 值
 */
@property (nonatomic) CGFloat cy_width;

/**
 *  view frame 的 height 值
 */
@property (nonatomic) CGFloat cy_height;

/**
 *  view frame 的 size 值
 */
@property (nonatomic) CGSize cy_size;

/**
 *  view frame 的 origin 值
 */
@property (nonatomic) CGPoint cy_origin;

/**
 *  view frame 的 center 的 x 值
 */
@property (nonatomic) CGFloat cy_centerX;

/**
 *  view frame 的 center 的 y 值
 */
@property (nonatomic) CGFloat cy_centerY;

@end
