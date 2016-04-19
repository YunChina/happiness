//
//  CYVerificationView.m
//  SmallLoving
//
//  Created by Cheney on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYVerificationView.h"
#import "Masonry.h"

@interface CYVerificationView ()

@property (nonatomic, weak) UILabel * titleLabel;

@end

@implementation CYVerificationView

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel * label = [UILabel new];
        _titleLabel = label;
        label.font = [UIFont systemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithWhite:0.4 alpha:1];
        label.text = @"我们已发送验证码短信到这个号码";
        [self addSubview:label];
    }
    return _titleLabel;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        UILabel * label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithWhite:0.6 alpha:1];
        _numberLabel = label;
        [self addSubview:label];
    }
    return _numberLabel;
}

- (UITextField *)authCodeTF {
    if (!_authCodeTF) {
        UITextField * tf = [UITextField new];
        _authCodeTF = tf;
        tf.placeholder = @"请输入验证码";
        tf.keyboardType = UIKeyboardTypeNumberPad;
        tf.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:tf];
    }
    return _authCodeTF;
}

- (UIButton *)referBtn {
    if (!_referBtn) {
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _referBtn = btn;
        [btn setTitle:@"提交" forState:(UIControlStateNormal)];
        [btn setBackgroundImage:[UIImage imageNamed:@"nav-bar-bg"]forState:(UIControlStateNormal)];
        [self addSubview:btn];
    }
    return _referBtn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30);
        make.left.right.equalTo(self);
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.right.equalTo(self);
    }];
    [self.authCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numberLabel.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.titleLabel.mas_centerX);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(50);
    }];
    [self.referBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authCodeTF.mas_bottom).offset(15);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.height.mas_equalTo(50);
    }];
}

@end
