//
//  CYRegistView.h
//  SmallLoving
//
//  Created by Cheney on 16/3/21.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYRegistView : UIView

/**
 *  手机号码的 textField
 */
@property (nonatomic, weak) UITextField * numberTf;

/**
 *  密码的 textField
 */
@property (nonatomic, weak) UITextField * passwordTf;

/**
 *  确认密码的 textField
 */
@property (nonatomic, weak) UITextField * passwordTf2;

/**
 *  注册按钮
 */
@property (nonatomic, weak) UIButton * registEndBtn;

@end
