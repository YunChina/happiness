//
//  SHHeaderView.m
//  SmallLoving
//
//  Created by xIang on 16/3/31.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHHeaderView.h"

@implementation SHHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}

- (UIImageView *)heartImageView{
    if (!_heartImageView) {
        _heartImageView = [[UIImageView alloc] init];
        [self addSubview:_heartImageView];
    }
    return _heartImageView;
}

- (UILabel *)leftTopLabel{
    if (!_leftTopLabel) {
        _leftTopLabel = [[UILabel alloc] init];
        [self addSubview:_leftTopLabel];
    }
    return _leftTopLabel;
}

- (UILabel *)rightLable{
    if (!_rightLable) {
        _rightLable = [[UILabel alloc] init];
        [self addSubview:_rightLable];
    }
    return _rightLable;
}

- (void)allViews{
    self.backgroundColor = [UIColor whiteColor];
    
    [self.heartImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20);
    }];
    self.heartImageView.image = [UIImage imageNamed:@"extension-anniversary-header-icon"];
    
    [self.leftTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.heartImageView.mas_right).offset(5);
    }];
        
    [self.rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-20);
    }];
}

- (void)setupHeaderViewLabelWithLoveDate:(NSDate *)date{
    //获取日期
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    NSString *timestamp = [formatter stringFromDate:date];
    NSString *leftStr = [NSString stringWithFormat:@"我们已经相爱\n从 %@ 至今",timestamp];
    
    NSMutableAttributedString *leftAttributeStr = [[NSMutableAttributedString alloc] initWithString:leftStr];
    [leftAttributeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, 6)];
    NSRange leftStrRange = NSMakeRange(7, leftStr.length-7);
    [leftAttributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:leftStrRange];
    [leftAttributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.7 alpha:1] range:leftStrRange];
    self.leftTopLabel.attributedText = leftAttributeStr;
    self.leftTopLabel.numberOfLines = 0;
    
    NSDate *nowDate = [NSDate date];
    NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:date];
    NSString *rightStr = [NSString stringWithFormat:@"%d 天",(int)timeInterval/86400];
    NSMutableAttributedString *rightAttributeStr = [[NSMutableAttributedString alloc] initWithString:rightStr];
    NSRange rightStrRange = NSMakeRange(0, rightStr.length-2);
    [rightAttributeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:40] range:rightStrRange];
    [rightAttributeStr addAttribute:NSForegroundColorAttributeName value:SHColorCreater(248, 87, 148, 1) range:rightStrRange];
    
    [rightAttributeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(rightStr.length-2, 2)];
    self.rightLable.attributedText = rightAttributeStr;
}
@end
