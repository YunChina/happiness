//
//  SHUserFactory.m
//  SmallLoving
//
//  Created by xIang on 16/4/5.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHUserFactory.h"
#import <CDUserModel.h>
#import "CYAccount.h"
#import "CYOtherAccountTool.h"
#import "CYAccountTool.h"
@interface CDUser : NSObject <CDUserModelDelegate>

@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *avatarUrl;

@end

@implementation CDUser

@end


@implementation SHUserFactory
- (void)cacheUserByIds:(NSSet *)userIds block:(AVBooleanResultBlock)block {
    block(YES, nil);
}


- (id<CDUserModelDelegate>)getUserById:(NSString *)userId{
    CDUser *user = [[CDUser alloc] init];
    CYAccount *otherAccount = [CYOtherAccountTool otherAccount];
    CYAccount *cyAccount = [CYAccountTool account];
    user.userId = userId;
    //在cell中显示的聊天对象的名字
    if ([userId isEqualToString:cyAccount.userName]) {
        user.username = cyAccount.nickName;
        //聊天对象的头像
        user.avatarUrl = cyAccount.iconURL;
    }else{
        user.username = otherAccount.nickName;
        user.avatarUrl = otherAccount.iconURL;
    }
    
    return user;
}

@end
