//
//  CYAlertAction.h
//  SmallLoving
//
//  Created by Cheney on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYAlertAction : UIAlertAction

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(UIAlertAction * action))handler;

@end
