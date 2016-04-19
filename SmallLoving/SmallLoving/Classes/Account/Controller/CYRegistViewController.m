//
//  CYRegistViewController.m
//  SmallLoving
//
//  Created by Cheney on 16/3/21.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYRegistViewController.h"
#import "CYNavigationController.h"
#import "CYRegistView.h"
#import "CYAccount.h"
#import "CYAccountTool.h"
#import "CYAlertController.h"
#import "CYVerificationViewController.h"

@interface CYRegistViewController ()

/**
 *  控制器主 View
 */
@property (nonatomic, weak) CYRegistView * registView;

/**
 *  账号注册的信息
 */
@property (nonatomic, strong) CYAccount * account;

@end

@implementation CYRegistViewController


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutNavigationBar];
    [self.registView.registEndBtn addTarget:self action:@selector(registAction) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([CYAccountTool account]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (CYRegistView *)registView {
    if (!_registView) {
        CYRegistView * view = [[CYRegistView alloc]initWithFrame:self.view.bounds];
        _registView = view;
        [self.view addSubview:view];
    }
    return _registView;
}

/**
 *  布局 navigationBar
 */
- (void)layoutNavigationBar {
    self.title = @"手机注册";
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:(UIBarButtonItemStyleDone) target:self action:@selector(cancelAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

/**
 *  注册按钮的点击事件
 */
- (void)registAction {
    // 判断密码是否一致
    if (![self.registView.passwordTf.text isEqualToString:self.registView.passwordTf2.text]) {
        [CYAlertController showAlertControllerWithTitle:@"失败" message:@"两次密码不一致" preferredStyle:(UIAlertControllerStyleActionSheet) isSucceed:NO viewController:self];
        // 判断密码长度
    } else if (self.registView.passwordTf.text.length < 6) {
        [CYAlertController showAlertControllerWithTitle:@"失败" message:@"密码长度不能少于 6 位" preferredStyle:(UIAlertControllerStyleActionSheet) isSucceed:NO viewController:self];
        // 判断网络
    } else if ([[self getNetWorkStates] isEqualToString:@"无网络"]) {
        [CYAlertController showAlertControllerWithTitle:@"失败" message:@"网络不给力, 请稍后再试" preferredStyle:(UIAlertControllerStyleActionSheet) isSucceed:NO viewController:self];
    } else {
        // 成功的提示框
        CYAlertController * ac = [CYAlertController showAlertControllerWithTitle:@"确认手机号码" message:[NSString stringWithFormat:@"我们将发送验证码短信到这个号码:%@", self.registView.numberTf.text] preferredStyle:(UIAlertControllerStyleActionSheet) isSucceed:YES viewController:self];
        // 好
        CYAlertAction * action = [CYAlertAction actionWithTitle:@"好" handler:^(UIAlertAction *action) {
            [self getVerificationCode];
        }];
        ac.allActions = @[action];
    }
}

/**
 *  取消的点击事件
 */
- (void)cancelAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  获取验证码
 */
- (void)getVerificationCode {
    // 储存到本地的账号信息
    AVUser * user = [AVUser user];
    user.username = self.registView.numberTf.text;
    user.mobilePhoneNumber = self.registView.numberTf.text;
    user.password = self.registView.passwordTf.text;
    self.account = [CYAccount new];
    self.account.userName = user.username;
    self.account.password = user.password;
    NSError *error = nil;
    [user signUp:&error];
    if (!error) {
        CYVerificationViewController * verificationVC = [[CYVerificationViewController alloc]init];
        verificationVC.account = self.account;
        CYNavigationController * naVC = [[CYNavigationController alloc]initWithRootViewController:verificationVC];
        naVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self showDetailViewController:naVC sender:nil];
    } else {
        CYLog(@"%@", error);
        [CYAlertController showAlertControllerWithTitle:@"失败" message:@"验证码发送失败, 请重试" preferredStyle:(UIAlertControllerStyleActionSheet) isSucceed:NO viewController:self];
    }
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
