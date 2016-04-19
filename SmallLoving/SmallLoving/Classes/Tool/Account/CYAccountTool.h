//
//  CYAccountTool.h
//  SmallLoving
//
//  Created by Cheney on 16/3/24.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CYAccount;

@interface CYAccountTool : NSObject

/**
 *  储存账号信息
 */
+ (void)saveAccount:(CYAccount *)account;

/**
 *  返回账号信息, 如果账号过期, 返回nil
 */
+ (CYAccount *)account;

/**
 *  删除账号信息
 */
+ (void)removeAccount;

@end
