//
//  CYOtherAccountTool.h
//  SmallLoving
//
//  Created by xIang on 16/4/4.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CYAccount;

@interface CYOtherAccountTool : NSObject
/**
 *  储存账号信息
 */
+ (void)saveOtherAccount:(CYAccount *)otherAccount;

/**
 *  返回账号信息, 如果账号过期, 返回nil
 */
+ (CYAccount *)otherAccount;

/**
 *  删除账号信息
 */
+ (void)removeOtherAccount;

@end
