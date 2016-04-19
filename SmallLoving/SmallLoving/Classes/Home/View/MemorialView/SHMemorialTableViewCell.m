//
//  SHMemorialTableViewCell.m
//  SmallLoving
//
//  Created by xIang on 16/3/31.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHMemorialTableViewCell.h"

@implementation SHMemorialTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self allViews];
    }
    return self;
}

- (UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        [self addSubview:_backgroundImageView];
    }
    return _backgroundImageView;
}

- (UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        [self addSubview:_leftImageView];
    }
    return _leftImageView;
}


- (UILabel *)memorialNameLabel{
    if (!_memorialNameLabel) {
        _memorialNameLabel = [[UILabel alloc] init];
        [self.backgroundImageView addSubview:_memorialNameLabel];
    }
    return _memorialNameLabel;
}
- (UILabel *)dayLabel{
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] init];
        [self.backgroundImageView addSubview:_dayLabel];
    }
    return _dayLabel;
}


- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        [self.backgroundImageView addSubview:_rightLabel];
    }
    return _rightLabel;
}

- (void)allViews{
    self.backgroundColor = [UIColor colorWithWhite:.95 alpha:1];
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(35);
    }];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(-2);
        make.left.equalTo(self).offset(10);
    }];
    
    [self.memorialNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(-2);
        make.left.equalTo(self.backgroundImageView).offset(20);
    }];
    self.memorialNameLabel.font = [UIFont systemFontOfSize:15];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(-2);
        make.right.equalTo(self.backgroundImageView).offset(-17);
    }];
    self.rightLabel.text = @"天";
    self.rightLabel.textColor = [UIColor whiteColor];
    self.rightLabel.font = [UIFont systemFontOfSize:15];
    
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(-2);
        make.right.equalTo(self.rightLabel.mas_left).offset(-15);
    }];
    self.dayLabel.textColor = [UIColor whiteColor];
    
}

@end
