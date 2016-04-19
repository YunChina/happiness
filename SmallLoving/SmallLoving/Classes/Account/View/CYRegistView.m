//
//  CYRegistView.m
//  SmallLoving
//
//  Created by Cheney on 16/3/21.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYRegistView.h"
#import "Masonry.h"

@interface CYRegistView ()

/**
 *  上面的提示 Label
 */
@property (nonatomic, weak) UILabel * titleLabel;

/**
 *  下面的提示 Label
 */
@property (nonatomic, weak) UILabel * detailLabel;

@end

@implementation CYRegistView

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel * label = [UILabel new];
        _titleLabel = label;
        label.text = @"请填写正确的手机号码";
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    return _titleLabel;
}

- (UITextField *)numberTf {
    if (!_numberTf) {
        UITextField * tf = [UITextField new];
        _numberTf = tf;
        UILabel * leftLabel = [UILabel new];
        leftLabel.cy_width = 75;
        leftLabel.cy_height = 50;
        leftLabel.text = @"+86";
        leftLabel.textAlignment = NSTextAlignmentCenter;
        tf.borderStyle = UITextBorderStyleBezel;
        tf.leftView = leftLabel;
        tf.keyboardType = UIKeyboardTypeNumberPad;
        tf.placeholder = @"请输入手机号码";
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.clearButtonMode = UITextFieldViewModeAlways;
        [self addSubview:tf];
    }
    return _numberTf;
}

- (UITextField *)passwordTf {
    if (!_passwordTf) {
        UITextField * tf = [UITextField new];
        _passwordTf = tf;
        UILabel * leftLabel = [UILabel new];
        leftLabel.cy_width = 75;
        leftLabel.cy_height = 50;
        leftLabel.text = @"密码";
        leftLabel.textAlignment = NSTextAlignmentCenter;
        tf.secureTextEntry = YES;
        tf.borderStyle = UITextBorderStyleBezel;
        tf.leftView = leftLabel;
        tf.keyboardType = UIKeyboardTypeNamePhonePad;
        tf.placeholder = @"密码不能少于 6 位";
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.clearButtonMode = UITextFieldViewModeAlways;
        [self addSubview:tf];
    }
    return _passwordTf;
}

- (UITextField *)passwordTf2 {
    if (!_passwordTf2) {
        UITextField * tf = [UITextField new];
        _passwordTf2 = tf;
        UILabel * leftLabel = [UILabel new];
        leftLabel.cy_width = 75;
        leftLabel.cy_height = 50;
        leftLabel.text = @"确认密码";
        tf.secureTextEntry = YES;
        leftLabel.textAlignment = NSTextAlignmentCenter;
        tf.borderStyle = UITextBorderStyleBezel;
        tf.leftView = leftLabel;
        tf.keyboardType = UIKeyboardTypeNamePhonePad;
        tf.placeholder = @"请再次输入密码";
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.clearButtonMode = UITextFieldViewModeAlways;
        [self addSubview:tf];
    }
    return _passwordTf2;
}

- (UIButton *)registEndBtn {
    if (!_registEndBtn) {
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _registEndBtn = btn;
        [btn setTitle:@"注册" forState:(UIControlStateNormal)];
        [btn setBackgroundImage:[UIImage imageNamed:@"nav-bar-bg"]forState:(UIControlStateNormal)];
        [self addSubview:btn];
    }
    return _registEndBtn;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        UILabel * label = [UILabel new];
        _detailLabel = label;
        label.text = @"手机号码是登录的账号, 是取回密码的重要凭证, 请确保手机号码的真实有效";
        label.numberOfLines = 0;
        label.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        [self addSubview:label];
    }
    return _detailLabel;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30);
        make.left.width.equalTo(self);
    }];
    [self.numberTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(30);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(50);
    }];
    [self.passwordTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numberTf.mas_bottom).offset(15);
        make.left.right.height.equalTo(self.numberTf);
    }];
    [self.passwordTf2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTf.mas_bottom).offset(15);
        make.left.right.height.equalTo(self.numberTf);
    }];
    [self.registEndBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTf2.mas_bottom).offset(10);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.height.mas_equalTo(50);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registEndBtn.mas_bottom).offset(15);
        make.left.equalTo(self.registEndBtn).offset(10);
        make.right.equalTo(self.registEndBtn).offset(-10);
    }];
}

@end
