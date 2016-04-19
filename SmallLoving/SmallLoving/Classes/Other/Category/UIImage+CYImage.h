//
//  UIImage+CYImage.h
//  CYTwitter
//
//  Created by Cheney on 3/6/16.
//  Copyright © 2016 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CYImage)

/**
 *  通过 imageName 获得一个未渲染的图片
 */
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

/**
 *  创建边角不拉伸的图片
 */
+ (instancetype)imageWithStretchableName:(NSString *)imageName;

/**
 *  设置图片的颜色
 */
- (UIImage *)imageColor:(UIColor *)color;

@end
