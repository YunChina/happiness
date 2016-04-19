//
//  SHHTTPManager.h
//  SmallLoving
//
//  Created by xIang on 16/4/6.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CYAccount;
typedef void(^ReloadDataBlock)();

@interface SHHTTPManager : NSObject
+ (SHHTTPManager *)shareHTTPManager;
@property(nonatomic, strong)CYAccount *cyAccount;
@property(nonatomic, copy)ReloadDataBlock reloadDataBlock;

- (void)synchronizationAccountWithCyAccount:(CYAccount *)cyAccount;
@end
