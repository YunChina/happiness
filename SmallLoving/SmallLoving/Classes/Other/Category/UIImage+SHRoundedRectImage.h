//
//  UIImage+SHRoundedRectImage.h
//  Happiness
//
//  Created by lanou3g on 16/3/22.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SHRoundedRectImage)
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;

@end
