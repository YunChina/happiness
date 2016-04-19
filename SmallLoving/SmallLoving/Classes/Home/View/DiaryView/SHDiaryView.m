//
//  SHDiaryView.m
//  SmallLoving
//
//  Created by xIang on 16/4/1.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHDiaryView.h"

@implementation SHDiaryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UITextView *)contentTextView{
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc] init];
        [self addSubview:_contentTextView];
    }
    return _contentTextView;
}

- (void)allViews{
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(10);
    }];
    self.timeLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1];
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(20);
        make.bottom.equalTo(self).offset(-10);
    }];
    self.contentTextView.alwaysBounceVertical = YES;
    self.contentTextView.font = [UIFont systemFontOfSize:15];
    
    self.contentTextView.layer.cornerRadius = 10;
    self.contentTextView.layer.borderWidth = .5;
    self.contentTextView.layer.masksToBounds = YES;

}

- (void)setupTimeLabel{
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    form.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    form.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDate *weekDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSWeekdayCalendarUnit;
    comps = [calendar components:unitFlags fromDate:weekDate];
    [comps weekday];
    NSArray *weekArr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    self.timeLabel.text = [NSString stringWithFormat:@"%@ 星期%@",[form stringFromDate:date],weekArr[[comps weekday] - 1]];

}
@end
