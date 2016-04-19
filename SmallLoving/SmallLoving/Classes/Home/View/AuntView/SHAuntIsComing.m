//
//  SHAuntIsComing.m
//  Happiness
//
//  Created by xIang on 16/3/24.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHAuntIsComing.h"
#import "SHAccountHome.h"
#import "UIImage+GIF.h"
#import "CYAccount.h"
#import "CYAccountTool.h"

@implementation SHAuntIsComing
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}

- (void)allViews{
    
    //姨妈巾背景图
    [self.auntTowelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(60);
    }];
    
    //姨妈光临图
    [self.auntComeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(140);
        make.right.left.equalTo(self);
        make.height.mas_equalTo(0);
    }];
    NSString  *name = @"menses-in.gif";
    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:name ofType:nil];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    self.auntComeImageView.image = [UIImage sd_animatedGIFWithData:imageData];
    self.auntComeImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.auntComeImageView.hidden = YES;
    
    //姨妈巾上方Label
    [self.auntTowelFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.auntTowelImageView).offset(20);
    }];
    self.auntTowelFirstLabel.font = [UIFont systemFontOfSize:13];
    self.auntTowelFirstLabel.textColor = SHColorCreater(214, 142, 168, 1);
    
    //姨妈巾下方Label
    [self.auntTowelSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.auntTowelImageView);
    }];
    
    self.auntTowelSecondLabel.font = [UIFont systemFontOfSize:15];
    self.auntTowelSecondLabel.textColor = SHColorCreater(244, 83, 129, 1);
    
    //男性提示Label
    [self.manLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(20);
    }];
    self.manLabel.font = [UIFont systemFontOfSize:17];
    self.manLabel.textColor = SHColorCreater(120, 43, 49, 1);
    
    
    //女性点击btn
    [self.womanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.manLabel.mas_bottom);
    }];
    [self.womanBtn setBackgroundImage:[UIImage imageNamed:@"menses-in-btn"] forState:UIControlStateNormal];
    [self.womanBtn setTitleColor:SHColorCreater(229, 85, 143, 1) forState:UIControlStateNormal];
    [self.womanBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    self.womanBtn.hidden = YES;
}

- (UIImageView *)auntTowelImageView{
    if (!_auntTowelImageView) {
        _auntTowelImageView = [[UIImageView alloc] init];
        [self addSubview:_auntTowelImageView];
    }
    return _auntTowelImageView;
}

- (UIImageView *)auntComeImageView{
    if (!_auntComeImageView) {
        _auntComeImageView = [[UIImageView alloc] init];
        [self addSubview:_auntComeImageView];
    }
    return _auntComeImageView;
}

- (UILabel *)auntTowelFirstLabel{
    if (!_auntTowelFirstLabel) {
        _auntTowelFirstLabel = [[UILabel alloc] init];
        [self addSubview:_auntTowelFirstLabel];
    }
    return _auntTowelFirstLabel;
}

- (UILabel *)auntTowelSecondLabel{
    if (!_auntTowelSecondLabel) {
        _auntTowelSecondLabel = [[UILabel alloc] init];
        [self addSubview:_auntTowelSecondLabel];
    }
    return _auntTowelSecondLabel;
}

- (UILabel *)manLabel{
    if (!_manLabel) {
        _manLabel = [[UILabel alloc] init];
        [self addSubview:_manLabel];
    }
    return _manLabel;
}

- (UIButton *)womanBtn{
    if (!_womanBtn) {
        _womanBtn = [[UIButton alloc] init];
        [self addSubview:_womanBtn];
    }
    return _womanBtn;
}

- (void)setupViewWithAccountHome:(SHAccountHome *)accountHome{
    self.backgroundColor = SHColorCreater(251, 232, 243, 1);
    CYAccount *cyAccount = [CYAccountTool account];
    if ([accountHome.isMenstruation isEqualToString:@"YES"]) {//正处在姨妈期
        self.auntTowelFirstLabel.text = nil;
        self.auntTowelSecondLabel.text = nil;
        if ([cyAccount.sex isEqualToString:@"m"]) {
            self.auntComeImageView.hidden = YES;
            self.auntTowelImageView.hidden = NO;
            self.auntTowelImageView.image = [UIImage imageNamed:@"menses-coming-bg"];
            self.manLabel.hidden = NO;
            self.womanBtn.hidden = YES;
            self.manLabel.text = @"她的姨妈来了,要加倍呵护他哦";
        } else if ([cyAccount.sex isEqualToString:@"f"]){
            self.auntComeImageView.hidden = NO;
            self.auntTowelImageView.hidden = YES;
            self.manLabel.hidden = YES;
            self.womanBtn.hidden = NO;
            [self.womanBtn setTitle:@"告诉他,姨妈走了" forState:UIControlStateNormal];
        }
    }else{//姨妈没来期
        [self setupIsNotMenstruationWithAccountHome:accountHome];
    }
}

//姨妈没来期
- (void)setupIsNotMenstruationWithAccountHome:(SHAccountHome *)accountHome{
    self.auntTowelImageView.image = [UIImage imageNamed:@"menses-top-bg"];
    self.auntComeImageView.hidden = YES;
    self.auntTowelImageView.hidden = NO;
    CYAccount *cyAccount = [CYAccountTool account];
    //月经差几天到来
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期格式(声明字符串里面每个数字和单词的含义)
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDateComponents *cmps = [self auntTowelSecondLabelWithLastAuntDate:[fmt dateFromString:accountHome.lastAuntDate]];
    if (accountHome.lastAuntDate) {//如果设置了月经信息
        if (labs([accountHome.interval integerValue] - (long)cmps.day % [accountHome.interval integerValue]) > 3) {//如果天数大于三天
            if ([cyAccount.sex isEqualToString:@"m"]) {//如果是男性
                self.manLabel.hidden = NO;
                self.womanBtn.hidden = YES;
                self.auntTowelFirstLabel.text = @"距离她的姨妈大驾光临还有";
                self.manLabel.text = @"可以和她尽情愉快地玩耍啦!";
            }else if ([cyAccount.sex isEqualToString:@"f"]){//如果是女性
                self.manLabel.hidden = YES;
                self.womanBtn.hidden = NO;
                self.auntTowelFirstLabel.text = @"距离姨妈大驾光临还有";
                [self.womanBtn setTitle:@"告诉他,姨妈提前来了" forState:UIControlStateNormal];
            }
            [self setupAuntTowelSecondLabelWithAccountHome:accountHome];
        }else{//如果小于三天
            if ([cyAccount.sex isEqualToString:@"m"]) {//如果是男性
                self.manLabel.hidden = NO;
                self.womanBtn.hidden = YES;
                self.auntTowelFirstLabel.text = nil;
                self.auntTowelSecondLabel.text = @"她的姨妈将在近期光临";
                self.manLabel.text = @"去提醒她多注意一下吧";
            }else if ([cyAccount.sex isEqualToString:@"f"]){//如果是女性
                self.manLabel.hidden = YES;
                self.womanBtn.hidden = NO;
                self.auntTowelFirstLabel.text = nil;
                self.auntTowelSecondLabel.text = @"姨妈将在近期光临";
                [self.womanBtn setTitle:@"告诉他,姨妈已经来了" forState:UIControlStateNormal];
            }
        }
    }else{//如果没有设置月经信息
        if ([cyAccount.sex isEqualToString:@"f"]) {//如果是女性
            self.auntTowelFirstLabel.text = @"还没有设置月经信息哦";
            self.auntTowelSecondLabel.text = @"点击右上角设置月经信息";
            self.manLabel.hidden = YES;
            self.womanBtn.hidden = YES;
        }else if ([cyAccount.sex isEqualToString:@"m"]){//如果是男性
            self.auntTowelFirstLabel.text = @"她还没有设置月经信息哦";
            self.auntTowelSecondLabel.text = @"快去提醒她";
            self.manLabel.hidden = YES;
            self.womanBtn.hidden = YES;
        }
    }
}

//设置月经差多久到来
- (void)setupAuntTowelSecondLabelWithAccountHome:(SHAccountHome *)accountHome{
    //月经差几天到来
    //月经差几天到来
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期格式(声明字符串里面每个数字和单词的含义)
    fmt.dateFormat = @"yyyy-MM-dd";

    NSDateComponents *cmps = [self auntTowelSecondLabelWithLastAuntDate:[fmt dateFromString:accountHome.lastAuntDate]];
     long timeInterval = [accountHome.interval integerValue] - (long)cmps.day % [accountHome.interval integerValue];
    self.auntTowelSecondLabel.text = [NSString stringWithFormat:@"%ld天%ld小时%ld分%ld秒",timeInterval, 24 - (long)cmps.hour, 60 - (long)cmps.minute, 60 - (long)cmps.second];
//    long timeInterval = [accountHome.interval integerValue] - (long)cmps.day - 1;
//    long multiple = (long)cmps.day / [accountHome.interval integerValue];
//    self.auntTowelSecondLabel.text = [NSString stringWithFormat:@"%ld天%ld小时%ld分%ld秒",timeInterval + multiple * [accountHome.interval integerValue], 24 - (long)cmps.hour, 60 - (long)cmps.minute, 60 - (long)cmps.second];
}

- (NSDateComponents *)auntTowelSecondLabelWithLastAuntDate:(NSDate *)date{
    //当前时间
    NSDate *now = [NSDate date];
    //日历对象(方便比较两个日期之间的差距)
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //NSCalendarUnit枚举代想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    return cmps;
}

@end
