//
//  CYAlertController.h
//  SmallLoving
//
//  Created by Cheney on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYAlertAction.h"

@interface CYAlertController : UIAlertController

/**
 *  设置成功亦或失败
 */
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle isSucceed:(BOOL)succeed;

/**
 *  直接显示提示框
 */
+ (instancetype)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle isSucceed:(BOOL)succeed viewController:(UIViewController *)viewController;

@property (nonatomic, strong) NSArray<CYAlertAction *> * allActions;

@end
