//
//  SHNameController.m
//  Happiness
//
//  Created by 云志强 on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHNameController.h"
#import "SHLeftBackButton.h"
#import "CYAccountTool.h"
#import "CYAccount.h"
#import "MBProgressHUD.h"


@interface SHNameController ()
@property(nonatomic,strong)UITextField *textfield;
@property(nonatomic,strong)UIButton *buttonconserve;
@property(nonatomic,strong)MBProgressHUD * hud;
@end

@implementation SHNameController

-(UIButton *)buttonconserve{
    if(!_buttonconserve){
        UIButton *btn = [UIButton new];
        _buttonconserve = btn;
        [btn addTarget:self action:@selector(ConserveAction) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"保存" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"forum-advert-download-btn"] forState:(UIControlStateNormal)];
        [self.view addSubview:btn];
    }
    return _buttonconserve;
}

- (void)layoutHUD {
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    self.hud.frame = self.view.bounds;
    self.hud.labelText = @"昵称保存中...";
    self.hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:self.hud];
    [self.hud show:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"昵称";
    UITextField *textfiled = [[UITextField alloc]initWithFrame:CGRectMake(0, 30, kScreenW, 40)];
    textfiled.placeholder = @"请输入另一半对你的称呼";
    textfiled.borderStyle = UITextBorderStyleRoundedRect;
    textfiled.clearButtonMode = UITextFieldViewModeAlways;
    if (![self.nickName isEqualToString:@"请设置昵称"]) {
        textfiled.text = self.nickName;
    }
    self.textfield = textfiled;
    [self.view addSubview:textfiled];
    
    self.buttonconserve.frame = CGRectMake(kScreenW-(kScreenW-30), 100, kScreenW-60, 40);
    
    //左键返回
    SHLeftBackButton *backButton = [[SHLeftBackButton alloc] init];
    [backButton setSelfWithImageName:@"nav-bar-white-back-btn" title:@"返回   "];
    [backButton addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)leftItemAction:(UIBarButtonItem *)leftItem{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ConserveAction{
    [self layoutHUD];
    //保存
    CYAccount *cyAccount = [CYAccountTool account];
    cyAccount.nickName = self.textfield.text;
    [CYAccountTool saveAccount:cyAccount];
    //上传到云端
    AVObject *accountAV = [AVObject objectWithoutDataWithClassName:@"CYAccount" objectId:cyAccount.objectId];
    [accountAV setObject:cyAccount.nickName forKey:@"nickName"];
    __weak typeof(self) weakSelf = self;
    [accountAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //存储到本地
            CYLog(@"存储昵称成功");
            [CYAccountTool saveAccount:cyAccount];
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"昵称保存成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alertVC addAction:confirm];
            [weakSelf.hud removeFromSuperview];
            [weakSelf presentViewController:alertVC animated:YES completion:nil];
        }
    }];
}

@end
