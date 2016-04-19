//
//  UIImage+SHImage.h
//  Happiness
//
//  Created by Cheney on 16/3/16.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SHImage)

/**
 *  通过 imageName 获得一个未渲染的图片
 */
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

/**
 *  通过 imageName 获得一个边角不拉伸的图片
 */
+ (instancetype)imageWithStretchableName:(NSString *)imageName;

/**
 *  设置 image 的颜色
 */
+ (instancetype)imageWithName:(NSString *)imageName imageColor:(UIColor *)imageColor;

@end
