//
//  SHImageTool.h
//  SmallLoving
//
//  Created by xIang on 16/4/3.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHImageModel.h"

@interface SHImageTool : NSObject
//存储图片类
+ (void)saveImageModel:(SHImageModel *)imageModel;

//返回图片类
+ (SHImageModel *)imageModel;

//删除照片类
+ (void)removeImageModel;

@end
