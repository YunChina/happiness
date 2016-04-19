//
//  CYLoginView.h
//  SmallLoving
//
//  Created by Cheney on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYLoginView : UIView

/**
 *  用户名 textField
 */
@property (nonatomic, weak) UITextField * userNameTf;

/**
 *  密码 textField
 */
@property (nonatomic, weak) UITextField * passwordTf;

/**
 *  登录按钮
 */
@property (nonatomic, weak) UIButton * loginBtn;

/**
 *  找回密码按钮
 */
@property (nonatomic, weak) UIButton * findPasswordBtn;

@end
