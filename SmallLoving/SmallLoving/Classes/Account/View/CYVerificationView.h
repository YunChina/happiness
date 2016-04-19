//
//  CYVerificationView.h
//  SmallLoving
//
//  Created by Cheney on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYVerificationView : UIView

/**
 *  手机号
 */
@property (nonatomic, weak) UILabel * numberLabel;

/**
 *  填写验证码的 textField
 */
@property (nonatomic, weak) UITextField * authCodeTF;

/**
 *  提交的 button
 */
@property (nonatomic, weak) UIButton * referBtn;

@end
