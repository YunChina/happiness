//
//  SHSleepView.m
//  Happiness
//
//  Created by xIang on 16/3/22.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHSleepView.h"
#import "SHSleepingView.h"
#import "NSDate+XWBExtension.h"


@implementation SHSleepView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}


- (SHSleepingView *)sleepingView{
    if (!_sleepingView) {
        _sleepingView = [[SHSleepingView alloc] init];
        [self.backgroundImageView addSubview:_sleepingView];
    }
    return _sleepingView;
}

- (UILabel *)sleepTimeLabel{
    if (!_sleepTimeLabel) {
        _sleepTimeLabel = [[UILabel alloc] init];
        [self.backgroundImageView addSubview:_sleepTimeLabel];
    }
    return _sleepTimeLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        [self.backgroundImageView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UIButton *)wakeBtn{
    if (!_wakeBtn) {
        _wakeBtn = [[UIButton alloc] init];
        [self.backgroundImageView addSubview:_wakeBtn];
    }
    return _wakeBtn;
}

- (UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        [self addSubview:_backgroundImageView];
    }
    return _backgroundImageView;
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        [self.backgroundImageView addSubview:_backBtn];
    }
    return _backBtn;
}

- (void)allViews{
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.backgroundImageView.image = [UIImage imageNamed:@"sleeping_bg"];
    self.backgroundImageView.userInteractionEnabled = YES;
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroundImageView).offset(20);
        make.top.equalTo(self.backgroundImageView).offset(30);
    }];
    [self.backBtn setImage:[UIImage imageNamed:@"sleep_close_btn"] forState:UIControlStateNormal];
    
    [self.wakeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundImageView);
        make.bottom.equalTo(self.backgroundImageView).offset(-30);
    }];
    [self.wakeBtn setTitle:@"我醒了" forState:UIControlStateNormal];
    [self.wakeBtn setBackgroundImage:[UIImage imageNamed:@"sleep_btn"] forState:UIControlStateNormal];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundImageView);
        make.top.equalTo(self.backBtn.mas_bottom);
    }];
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期格式(声明字符串里面每个数字和单词的含义)
    fmt.dateFormat = @"HH:mm";
    self.timeLabel.text = [fmt stringFromDate:now];
    //当前时间
    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(dataChangeAction) userInfo:nil repeats:YES];
   
    
    self.timeLabel.font = [UIFont systemFontOfSize:35];
    self.timeLabel.textColor = [UIColor whiteColor];
    
    [self.sleepTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundImageView);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
    }];
    
    
    self.sleepTimeLabel.font = [UIFont systemFontOfSize:15];
    self.sleepTimeLabel.textColor = [UIColor whiteColor];
    
    [self.sleepingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.backgroundImageView);
        make.size.mas_equalTo(CGSizeMake(kScreenW/2+50, kScreenW/2+50));
    }];
}

- (void)dataChangeAction {
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期格式(声明字符串里面每个数字和单词的含义)
    fmt.dateFormat = @"HH:mm";
    self.timeLabel.text = [fmt stringFromDate:now];
}

- (NSString *)createdSinceNowWithDate:(NSString *)date{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期格式(声明字符串里面每个数字和单词的含义)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *myDate = [fmt dateFromString:date];

    
    //通过NSCALENDAR类来创建日期
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setHour:24];
    [comp setMinute:00];
    
    NSCalendar *myCal = [NSCalendar currentCalendar];
    NSDate *myDate1 = [myCal dateFromComponents:comp];
    
    //当前时间
    NSDate *now = [NSDate date];
    //日历对象(方便比较两个日期之间的差距)
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //NSCalendarUnit枚举代想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //计算两个日期之间的差值
    
    NSDateComponents *cmps = [calendar components:unit fromDate:myDate toDate:now options:0];
    
    NSDateComponents *cmps1 = [calendar components:unit fromDate:myDate toDate:myDate1 options:0];
    
        if ([myDate isYesterday]) {//昨天
            return [NSString stringWithFormat:@"睡了%ld小时%ld分钟",(long)(cmps.hour+cmps1.hour+24),(long)(cmps.minute+cmps1.minute+60)];
        }else if([myDate isToday]){//今天
            if (cmps.hour >= 1) {//大于一小时前发的
                return [NSString stringWithFormat:@"睡了%ld小时%ld分钟",(long)cmps.hour,(long)cmps.minute];
            }else if(cmps.minute >= 1){//一小时内
                return [NSString stringWithFormat:@"睡了%ld分钟",(long)cmps.minute];
            } else {
                return [NSString stringWithFormat:@"睡了%ld秒",cmps.second];
            }
        }else{//今年的其他日子
            return [NSString stringWithFormat:@"都睡了%ld天啦,赶紧起床",cmps.day];
        }
}


@end
