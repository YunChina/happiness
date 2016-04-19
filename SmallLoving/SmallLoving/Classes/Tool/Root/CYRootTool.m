//
//  CYRootTool.m
//  SmallLoving
//
//  Created by Cheney on 16/3/19.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYRootTool.h"
#import "CYTabBarController.h"
#import "CYAccountViewController.h"
#import "CYNavigationController.h"
#import "CYAccountTool.h"
#import "CYAccountView.h"

@implementation CYRootTool

+ (void)setRootViewController {
    
    UIWindow  *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = nil;
    // SB 一样的移除视图
    for (UIView * view in window.subviews) {
        [view removeFromSuperview];
    }
     if ([CYAccountTool account]) {
        CYTabBarController * tabBarVC = [[CYTabBarController alloc]init];
        window.rootViewController = tabBarVC;
    } else {
        CYAccountViewController * accountVC = [[CYAccountViewController alloc]init];
        window.rootViewController = accountVC;
    }
}

@end
