//
//  SHImageModel.h
//  SmallLoving
//
//  Created by xIang on 16/4/3.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHImageModel : NSObject
@property(nonatomic, strong)UIImage *iconImage;
@property(nonatomic, strong)UIImage *otherImage;
@property(nonatomic, strong)NSMutableArray *photosArr;
@property(nonatomic, strong)UIImage *coverImage;

@end
