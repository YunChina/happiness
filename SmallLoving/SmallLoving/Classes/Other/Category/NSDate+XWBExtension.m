//
//  NSDate+XWBExtension.m
//  微博
//
//  Created by xIang on 16/3/10.
//  Copyright © 2016年 xuxiang. All rights reserved.
//

#import "NSDate+XWBExtension.h"

@implementation NSDate (XWBExtension)
//判断某个时间是不是今年
- (BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear;
    //获得某个时间的年月日时分秒
    NSDateComponents *createDateCmps = [calendar components:unit fromDate:self];
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    return createDateCmps.year == nowCmps.year;
}

//判断某个时间是不是昨天
- (BOOL)isYesterday{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    NSDate *date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //想获得年月日差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

//判断某个时间是不是今天
- (BOOL)isToday{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    return [dateStr isEqualToString:nowStr];
}

//计算今天距离纪念日还有几天
- (NSString *)getDaySinceMemorial{
    //获取日期
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *timestamp = [formatter stringFromDate:self];
    timestamp = [timestamp substringFromIndex:5];
    NSString *nowDateStr = [formatter stringFromDate:nowDate];
    nowDateStr = [nowDateStr substringToIndex:4];
    NSString *timeDateYear = [NSString stringWithFormat:@"%@-%@",nowDateStr,timestamp];
    NSDate *date = [formatter dateFromString:timeDateYear];
    //日历对象(方便比较两个日期之间的差距)
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //NSCalendarUnit枚举代想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitDay;
    //计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:nowDate toDate:date options:0];
    if (cmps.day >= 0) {
        return [NSString stringWithFormat:@"%ld",(long)cmps.day];
    }else{
        NSString *yearStr = [nowDateStr substringFromIndex:3];
        nowDateStr = [nowDateStr substringToIndex:3];
        nowDateStr = [NSString stringWithFormat:@"%@%d",nowDateStr,yearStr.intValue + 1];
        timeDateYear = [NSString stringWithFormat:@"%@-%@",nowDateStr,timestamp];
        NSDate *date = [formatter dateFromString:timeDateYear];
        cmps = [calendar components:unit fromDate:nowDate toDate:date options:0];
        return [NSString stringWithFormat:@"%ld",cmps.day];
    }
}
@end
