//
//  UIView+Frame.h
//  WeiBo
//
//  Created by Cheney on 16/2/17.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

/**
 *  view frame 的 x 值
 */
@property (nonatomic) CGFloat x;

/**
 *  view frame 的 y 值
 */
@property (nonatomic) CGFloat y;

/**
 *  view frame 的 width 值
 */
@property (nonatomic) CGFloat width;

/**
 *  view frame 的 height 值
 */
@property (nonatomic) CGFloat height;

/**
 *  view frame 的 size 值
 */
@property (nonatomic) CGSize size;

/**
 *  view frame 的 origin 值
 */
@property (nonatomic) CGPoint origin;

/**
 *  view frame 的 center 的 x 值
 */
@property (nonatomic) CGFloat centerX;

/**
 *  view frame 的 center 的 y 值
 */
@property (nonatomic) CGFloat centerY;

@end
