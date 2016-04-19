//
//  SHImageTool.m
//  SmallLoving
//
//  Created by xIang on 16/4/3.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHImageTool.h"
//图片沙盒路径
#define SHImageModelPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"imageModel.archive"]

@implementation SHImageTool
//存储图片类
+ (void)saveImageModel:(SHImageModel *)imageModel{
    [NSKeyedArchiver archiveRootObject:imageModel toFile:SHImageModelPath];
}

//返回图片类
+ (SHImageModel *)imageModel{
    SHImageModel *imageModel = [NSKeyedUnarchiver unarchiveObjectWithFile:SHImageModelPath];
    if (!imageModel) {
        imageModel = [[SHImageModel alloc] init];
    }
    return imageModel;
}

//删除照片类
+ (void)removeImageModel{
    [[NSFileManager defaultManager]removeItemAtPath:SHImageModelPath error:nil];
}

@end
