//
//  CYAccount.h
//  SmallLoving
//
//  Created by Cheney on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface CYAccount : AVObject <AVSubclassing>

/**
 *  账号
 */
@property (nonatomic, strong) NSString * userName;

/**
 *  手机号
 */
@property (nonatomic, strong) NSString * number;

/**
 *  密码
 */
 @property (nonatomic, strong) NSString * password;

/**
 *  邮箱
 */
@property (nonatomic, strong) NSString * mail;

//用户昵称
@property(nonatomic, strong)NSString *nickName;

//AccountHomeObjID
@property(nonatomic, strong)NSString *accountHomeObjID;

//用户头像iconURL
@property(nonatomic, strong)NSString *iconURL;

//另一半账户
@property(nonatomic, strong)NSString *otherUserName;

//性别
@property(nonatomic, strong)NSString *sex;

//地理位置
@property (nonatomic, assign)NSString *latitude;//纬度
@property (nonatomic, assign)NSString *longitude;//经度

@property(nonatomic, strong)NSString *sleepTimeDate;//开始睡觉的时间
@property(nonatomic, strong)NSString  *isSleep;//是否正在睡觉

@end
