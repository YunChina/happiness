//
//  CYAccountViewController.m
//  SmallLoving
//
//  Created by Cheney on 16/3/19.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYAccountViewController.h"
#import "CYAccountView.h"
#import "CYRegistViewController.h"
#import "CYLoginViewController.h"
#import "CYNavigationController.h"
#import "CYRootTool.h"
#import "CYAccountTool.h"
#import "AVOSCloudSNS.h"
# import <LeanCloudSocial/AVUser+SNS.h>

@interface CYAccountViewController ()

/**
 *  控制器主 View
 */
@property (nonatomic, weak) CYAccountView * accountView;

@end

@implementation CYAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllTargetAction];
}

/**
 *  添加所有的 button 点击事件
 */
- (void)addAllTargetAction {
    [self.accountView.registBtn addTarget:self action:@selector(registAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.accountView.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.accountView.qqLoginBtn addTarget:self action:@selector(qqLoginAction) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.accountView.weChatLoginBtn addTarget:self action:@selector(weChatLoginAction) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.accountView.weiBoLoginBtn addTarget:self action:@selector(weiBoLoginAction) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 如果登录
    if ([CYAccountTool account]) {
        // 重新设置根视图
        [CYRootTool setRootViewController];
        
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}

- (CYAccountView *)accountView {
    if (!_accountView) {
        CYAccountView * view = [[CYAccountView alloc]initWithFrame:self.view.bounds];
        _accountView = view;
        [self.view addSubview:view];
    }
    return _accountView;
}

/**
 *  注册按钮的点击事件
 */
- (void)registAction {
    CYRegistViewController * registVC = [[CYRegistViewController alloc]init];
    CYNavigationController * naVC = [[CYNavigationController alloc]initWithRootViewController:registVC];
    naVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self showDetailViewController:naVC sender:nil];
}

/**
 *  登录按钮的点击事件
 */
- (void)loginAction {
    CYLoginViewController * loginVC = [[CYLoginViewController alloc]init];
    CYNavigationController * naVC = [[CYNavigationController alloc]initWithRootViewController:loginVC];
    naVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self showDetailViewController:naVC sender:nil];
}

/**
 *  QQ 登录按钮的点击事件
 */
- (void)qqLoginAction {

}

/**
 *  微信登录按钮的点击事件
 */
- (void)weChatLoginAction {
    
}

/**
 *  微博登录按钮的点击事件
 */
- (void)weiBoLoginAction {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
