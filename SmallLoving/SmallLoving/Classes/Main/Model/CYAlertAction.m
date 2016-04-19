//
//  CYAlertAction.m
//  SmallLoving
//
//  Created by Cheney on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYAlertAction.h"

@implementation CYAlertAction

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(UIAlertAction *))handler {
    CYAlertAction * action = [self actionWithTitle:title style:(UIAlertActionStyleDefault) handler:handler];
    return action;
}

@end
