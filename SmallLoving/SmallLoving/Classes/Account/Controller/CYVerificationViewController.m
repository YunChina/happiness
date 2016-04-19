//
//  CYVerificationViewController.m
//  SmallLoving
//
//  Created by Cheney on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYVerificationViewController.h"
#import "CYVerificationView.h"
#import "CYAccountTool.h"
#import "CYAccount.h"
#import "CYOtherAccountTool.h"

@interface CYVerificationViewController ()

/**
 *  控制器主 View
 */
@property (nonatomic, weak) CYVerificationView * verificationView;


@end

@implementation CYVerificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutNavigationBar];
    [self layoutSubviews];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (CYVerificationView *)verificationView {
    if (!_verificationView) {
        CYVerificationView * view = [[CYVerificationView alloc]initWithFrame:self.view.bounds];
        _verificationView = view;
        [self.view addSubview:view];
    }
    return _verificationView;
}

/**
 *  布局子视图
 */
- (void)layoutSubviews {
    self.verificationView.numberLabel.text = self.account.userName;
    [self.verificationView.referBtn addTarget:self action:@selector(referAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

/**
 *  点击提交的方法
 */
- (void)referAction:(UIButton *)btn {
    [AVUser verifyMobilePhone:self.verificationView.authCodeTF.text withBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //存储到服务器
            CYAccount *cyAccount = [CYAccount object];
            cyAccount.userName = self.account.userName;
            cyAccount.password = self.account.password;
            [cyAccount saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                // 存到本地
                [CYAccountTool saveAccount:self.account];
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        } else {
            UIAlertController * defAlertVC = [UIAlertController alertControllerWithTitle:@"失败" message:@"验证码错误, 请重试" preferredStyle:(UIAlertControllerStyleActionSheet)];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
            [defAlertVC addAction:cancelAction];
            [self presentViewController:defAlertVC animated:YES completion:nil];
        }
    }];
}

/**
 *  布局 navigationBar
 */
- (void)layoutNavigationBar {
    self.title = @"手机注册";
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:(UIBarButtonItemStyleDone) target:self action:@selector(cancelAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)cancelAction {
    [self dismissViewControllerAnimated:YES completion:nil];
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
