//
//  CYVerificationViewController.h
//  SmallLoving
//
//  Created by Cheney on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYAccount;

@interface CYVerificationViewController : UIViewController

/**
 *  接受上一个界面的手机号
 */
@property (nonatomic, strong) CYAccount * account;

@end
