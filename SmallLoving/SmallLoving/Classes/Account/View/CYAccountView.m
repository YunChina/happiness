//
//  CYAccountView.m
//  SmallLoving
//
//  Created by Cheney on 16/3/19.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYAccountView.h"
#import "Masonry.h"

@interface CYAccountView ()

/**
 *  背景的 View
 */
@property (nonatomic, weak) UIView * bgView;

/**
 *  标题的图片
 */
@property (nonatomic, weak) UIImageView * titleImgView;

/**
 *  标题的文字 label
 */
@property (nonatomic, weak) UILabel * titleLabel;

@end

@implementation CYAccountView

- (UIView *)bgView {
    if (!_bgView) {
        UIView * view = [[UIView alloc]init];
        _bgView = view;
        view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"welcome-background"]];
        [self addSubview:view];
    }
    return _bgView;
}

- (UIImageView *)titleImgView {
    if (!_titleImgView) {
        UIImageView * titleImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
        _titleImgView = titleImg;
        [self.bgView addSubview:titleImg];
    }
    return _titleImgView;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"小幸福,让幸福升温";
        label.textColor = [UIColor whiteColor];
        _titleLabel = label;
        [self.bgView addSubview:label];
    }
    return _titleLabel;
}

//- (UIButton *)qqLoginBtn {
//    if (!_qqLoginBtn) {
//        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        _qqLoginBtn = btn;
//        UIColor * color = [UIColor colorWithRed:64 / 255.0 green:190 / 255.0 blue:243 / 255.0 alpha:1];
//        [btn setBackgroundImage:[UIImage imageWithStretchableName:@"white-mask-common-btn"] forState:(UIControlStateNormal)];
//        [btn.layer setMasksToBounds:YES];
//        [btn.layer setCornerRadius:10];
//        [btn.layer setBorderWidth:1];
//        [btn.layer setBorderColor:color.CGColor];
//        [btn setTitle:@"QQ账号登录" forState:(UIControlStateNormal)];
//        [btn setTitleColor:color forState:(UIControlStateNormal)];
//        [btn setImage:[UIImage imageNamed:@"welcome-qq-icon"] forState:(UIControlStateNormal)];
//        btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, -30, 0.0, 0.0);
//        btn.tintColor = color;
//        [self addSubview:btn];
//    }
//    return _qqLoginBtn;
//}

//- (UIButton *)weChatLoginBtn {
//    if (!_weChatLoginBtn) {
//        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        _weChatLoginBtn = btn;
//        [btn setBackgroundImage:[UIImage imageWithStretchableName:@"white-mask-common-btn"] forState:(UIControlStateNormal)];
//        UIColor * color = [UIColor colorWithRed:135 / 255.0 green:199 / 255.0 blue:16 / 255.0 alpha:1];
//        [btn.layer setMasksToBounds:YES];
//        [btn.layer setCornerRadius:10];
//        [btn.layer setBorderWidth:1];
//        [btn.layer setBorderColor:color.CGColor];
//        [btn setTitle:@"微信登录" forState:(UIControlStateNormal)];
//        [btn setTitleColor:color forState:(UIControlStateNormal)];
//        UIImage * img = [[UIImage imageNamed:@"welcome-wechat-icon"] imageColor:color];
//        [btn setImage:img forState:(UIControlStateNormal)];
//        btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, -20, 0.0, 0.0);
//        [self addSubview:btn];
//    }
//    return _weChatLoginBtn;
//}

//- (UIButton *)weiBoLoginBtn {
//    if (!_weiBoLoginBtn) {
//        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        _weiBoLoginBtn = btn;
//        [btn setBackgroundImage:[UIImage imageWithStretchableName:@"white-mask-common-btn"] forState:(UIControlStateNormal)];
//        UIColor * color = [UIColor colorWithRed:218 / 255.0 green:55 / 255.0 blue:42 / 255.0 alpha:1];
//        [btn.layer setMasksToBounds:YES];
//        [btn.layer setCornerRadius:10];
//        [btn.layer setBorderWidth:1];
//        [btn.layer setBorderColor:color.CGColor];
//        [btn setTitle:@"微博登录" forState:(UIControlStateNormal)];
//        [btn setTitleColor:color forState:(UIControlStateNormal)];
//        [btn setImage:[UIImage imageNamed:@"welcome-sina-icon"] forState:(UIControlStateNormal)];
//        btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, -20, 0.0, 0.0);
//        [self addSubview:btn];
//    }
//    return _weiBoLoginBtn;
//}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _loginBtn = btn;
        [btn setBackgroundImage:[UIImage imageWithStretchableName:@"white-mask-common-btn"] forState:(UIControlStateNormal)];
        [btn setTitle:@"登录" forState:(UIControlStateNormal)];
        UIColor * color = [UIColor colorWithRed:64 / 255.0 green:190 / 255.0 blue:243 / 255.0 alpha:1];
        [btn setTitleColor:color forState:(UIControlStateNormal)];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:10];
        [btn.layer setBorderWidth:1];
        [btn.layer setBorderColor:color.CGColor];
        [self addSubview:btn];
    }
    return _loginBtn;
}

- (UIButton *)registBtn {
    if (!_registBtn) {
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _registBtn = btn;
        [btn setBackgroundImage:[UIImage imageWithStretchableName:@"white-mask-common-btn"] forState:(UIControlStateNormal)];
        [btn setTitle:@"手机注册" forState:(UIControlStateNormal)];
        UIColor * color = [UIColor colorWithRed:135 / 255.0 green:199 / 255.0 blue:16 / 255.0 alpha:1];
        [btn setTitleColor:color forState:(UIControlStateNormal)];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:10];
        [btn.layer setBorderWidth:1];
        [btn.layer setBorderColor:color.CGColor];
        [self addSubview:btn];
    }
    return _registBtn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height / 2 - 50);
    }];
    self.titleImgView.center = self.bgView.center;
    [self.titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bgView);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    self.titleLabel.center = CGPointMake(CGRectGetMidX(self.titleImgView.frame), CGRectGetMaxY(self.titleImgView.frame) + 10);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bgView).mas_offset(CGPointMake(0, 70));
    }];
//    [self.qqLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.bgView.mas_bottom).offset(50);
//        make.left.equalTo(self).offset(30);
//        make.right.equalTo(self).offset(-30);
//        make.height.mas_equalTo(50);
//    }];
//    [self.weChatLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.qqLoginBtn.mas_bottom).offset(10);
//        make.left.equalTo(self.qqLoginBtn);
//        make.height.equalTo(self.qqLoginBtn);
//    }];
//    [self.weiBoLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.weChatLoginBtn);
//        make.right.equalTo(self.qqLoginBtn);
//        make.width.equalTo(self.weChatLoginBtn);
//        make.left.equalTo(self.weChatLoginBtn.mas_right).offset(10);
//        make.height.equalTo(self.weChatLoginBtn);
//    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_bottom).offset(50);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.height.mas_equalTo(50);
    }];
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(10);
        make.left.equalTo(self.loginBtn);
        make.height.equalTo(self.loginBtn);
        make.width.equalTo(self.loginBtn);
    }];
}


@end
