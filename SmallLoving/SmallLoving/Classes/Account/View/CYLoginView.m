//
//  CYLoginView.m
//  SmallLoving
//
//  Created by Cheney on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYLoginView.h"
#import "Masonry.h"

@implementation CYLoginView

- (UITextField *)userNameTf {
    if (!_userNameTf) {
        UITextField * tf = [UITextField new];
        _userNameTf = tf;
        UIImageView * imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"account-icon"]];
        imgView.cy_width += 20;
        imgView.contentMode = UIViewContentModeCenter;
        tf.borderStyle = UITextBorderStyleBezel;
        tf.leftView = imgView;
        tf.keyboardType = UIKeyboardTypeNumberPad;
        tf.placeholder = @"请输入手机号码";
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.clearButtonMode = UITextFieldViewModeAlways;
        [self addSubview:tf];
    }
    return _userNameTf;
}

- (UITextField *)passwordTf {
    if (!_passwordTf) {
        UITextField * tf = [UITextField new];

        _passwordTf = tf;
        UIImageView * imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password-icon"]];
        imgView.cy_width += 20;
        imgView.contentMode = UIViewContentModeCenter;
        tf.borderStyle = UITextBorderStyleBezel;
        tf.leftView = imgView;
        tf.secureTextEntry = YES;
        tf.keyboardType = UIKeyboardTypeNamePhonePad;
        tf.placeholder = @"请输入密码";
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.clearButtonMode = UITextFieldViewModeAlways;
        [self addSubview:tf];
    }
    return _passwordTf;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _loginBtn = btn;
        [btn setTitle:@"登录" forState:(UIControlStateNormal)];
        [btn setBackgroundImage:[UIImage imageNamed:@"nav-bar-bg"]forState:(UIControlStateNormal)];
        [self addSubview:btn];
    }
    return _loginBtn;
}

- (UIButton *)findPasswordBtn {
    if (!_findPasswordBtn) {
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _findPasswordBtn = btn;
        [btn setTitle:@"找回密码" forState:(UIControlStateNormal)];
        [btn setBackgroundImage:[UIImage imageNamed:@"nav-bar-bg"]forState:(UIControlStateNormal)];
        [self addSubview:btn];
    }
    return _findPasswordBtn;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.userNameTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(50);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(50);
    }];
    [self.passwordTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameTf.mas_bottom);
        make.left.right.height.equalTo(self.userNameTf);
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTf.mas_bottom).offset(30);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.height.mas_equalTo(50);
    }];
//    [self.findPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.loginBtn.mas_bottom).offset(10);
//        make.left.right.height.equalTo(self.loginBtn);
//    }];
}

@end
