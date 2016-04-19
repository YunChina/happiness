//
//  UIBarButtonItem+CYItem.m
//  CYTwitter
//
//  Created by Cheney on 3/6/16.
//  Copyright © 2016 Cheney. All rights reserved.
//

#import "UIBarButtonItem+CYItem.h"

@implementation UIBarButtonItem (CYItem)

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
