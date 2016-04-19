//
//  CYOtherAccountTool.m
//  SmallLoving
//
//  Created by xIang on 16/4/4.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYOtherAccountTool.h"
#import "CYAccount.h"
// 账号存储路径 沙盒路径
#define CYOtherAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"otherAccount.archive"]


@implementation CYOtherAccountTool
+ (void)saveOtherAccount:(CYAccount *)otherAccount{
    
    [NSKeyedArchiver archiveRootObject:otherAccount toFile:CYOtherAccountPath];
}

+ (CYAccount *)otherAccount {
    CYAccount * account = [NSKeyedUnarchiver unarchiveObjectWithFile:CYOtherAccountPath];
    if (!account) {
        account = [[CYAccount alloc] init];
    }
    return account;
}

+ (void)removeOtherAccount {
    [[NSFileManager defaultManager]removeItemAtPath:CYOtherAccountPath error:nil];
}

@end
