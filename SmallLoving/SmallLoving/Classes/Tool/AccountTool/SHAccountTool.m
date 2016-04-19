//
//  SHAccountTool.m
//  Happiness
//
//  Created by xIang on 16/3/22.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHAccountTool.h"

//账号存储路径 沙盒路径
#define SHAccountPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation SHAccountTool
//存储账号信息
+ (void)saveAccount:(SHAccountHome *)account{
    [NSKeyedArchiver archiveRootObject:account toFile:SHAccountPath];
}

//返回账号信息
+ (SHAccountHome *)account{
    SHAccountHome *account = [NSKeyedUnarchiver unarchiveObjectWithFile:SHAccountPath];
    if (!account) {
        account = [[SHAccountHome alloc] init];
    }
    return account;
}

//删除首页类
+ (void)removeAccountHome{
    [[NSFileManager defaultManager]removeItemAtPath:SHAccountPath error:nil];
}



@end
