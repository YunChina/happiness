//
//  NSDate+XWBExtension.h
//  微博
//
//  Created by xIang on 16/3/10.
//  Copyright © 2016年 xuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XWBExtension)
//判断某个时间是不是今年
- (BOOL)isThisYear;
//判断某个时间是不是昨天
- (BOOL)isYesterday;
//判断某个时间是不是今天
- (BOOL)isToday;
//计算今天距离纪念日还有几天
- (NSString *)getDaySinceMemorial;
@end
