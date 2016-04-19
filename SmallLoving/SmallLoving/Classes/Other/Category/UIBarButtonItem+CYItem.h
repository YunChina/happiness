//
//  UIBarButtonItem+CYItem.h
//  CYTwitter
//
//  Created by Cheney on 3/6/16.
//  Copyright © 2016 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CYItem)

/**
 *  通过自定义的 button 创建 barButtonItem
 */
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;



@end
