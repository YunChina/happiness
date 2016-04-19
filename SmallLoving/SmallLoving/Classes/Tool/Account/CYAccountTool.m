
//
//  CYAccountTool.m
//  SmallLoving
//
//  Created by Cheney on 16/3/24.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYAccountTool.h"
#import "CYAccount.h"

// 账号存储路径 沙盒路径
#define CYAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation CYAccountTool

+ (void)saveAccount:(CYAccount *)account {
    
    [NSKeyedArchiver archiveRootObject:account toFile:CYAccountPath];
}

+ (CYAccount *)account {
    CYAccount * account = [NSKeyedUnarchiver unarchiveObjectWithFile:CYAccountPath];
    return account;
}

+ (void)removeAccount {
    [[NSFileManager defaultManager]removeItemAtPath:CYAccountPath error:nil];
}

@end
