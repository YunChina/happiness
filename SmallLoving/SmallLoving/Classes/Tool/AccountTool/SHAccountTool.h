//
//  SHAccountTool.h
//  Happiness
//
//  Created by xIang on 16/3/22.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHAccountHome.h"

@interface SHAccountTool : NSObject
//存储账号信息
+ (void)saveAccount:(SHAccountHome *)account;

//返回账号信息 如果账号过期 返回nil
+ (SHAccountHome *)account;
//删除首页类
+ (void)removeAccountHome;
@end
