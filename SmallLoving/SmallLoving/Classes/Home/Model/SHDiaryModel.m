//
//  SHDiaryModel.m
//  SmallLoving
//
//  Created by xIang on 16/4/2.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHDiaryModel.h"
#import <MJExtension.h>

@implementation SHDiaryModel
//归档 序列化 压缩
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [self mj_encode:aCoder];
}

//反归档 反序列化 解压
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    //如果父类实现了initWithCoder方法,此时执行父类的initWithCoder的方法
    self = [super init];
    if (self) {
        [self mj_decode:aDecoder];
    }
    return self;
}
@end
