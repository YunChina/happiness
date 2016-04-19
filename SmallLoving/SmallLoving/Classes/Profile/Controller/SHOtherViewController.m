//
//  SHOtherViewController.m
//  SmallLoving
//
//  Created by xIang on 16/4/4.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHOtherViewController.h"
#import "SHLeftBackButton.h"
#import "CYAccountTool.h"
#import "CYAccount.h"
#import "MBProgressHUD.h"
#import "CYOtherAccountTool.h"
#import "SHAccountTool.h"
#import <MJExtension.h>

@interface SHOtherViewController ()
@property(nonatomic,strong)UITextField *textfield;
@property(nonatomic,strong)UIButton *buttonconserve;
@property(nonatomic,strong)MBProgressHUD * hud;
@property(nonatomic, strong)CYAccount *cyAccount;
@property(nonatomic, strong)SHAccountHome *accountHome;
@property(nonatomic, strong)CYAccount *otherAccount;



@end

@implementation SHOtherViewController

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
    self.hud.labelText = @"另一半保存中...";
    self.hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:self.hud];
    [self.hud show:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"另一半账户";
    UITextField *textfiled = [[UITextField alloc]initWithFrame:CGRectMake(0, 30, kScreenW, 40)];
    textfiled.placeholder = @"请输入另一半的幸福号";
    textfiled.borderStyle = UITextBorderStyleRoundedRect;
    textfiled.clearButtonMode = UITextFieldViewModeAlways;
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
    __weak typeof(self) weakSelf = self;
    if (self.textfield.text.length == 11) {
        [self layoutHUD];
        //保存
        self.cyAccount = [CYAccountTool account];
        //绑定另一半账号
        self.otherAccount = [CYAccount new];
        AVQuery *query = [CYAccount query];
        [query whereKey:@"userName" equalTo:self.textfield.text];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                if (objects.count == 0) {
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"没有找到此用户" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [weakSelf.hud removeFromSuperview];
                    [alertVC addAction:confirm];
                    [weakSelf presentViewController:alertVC animated:YES completion:nil];
                    return;
                }
                weakSelf.otherAccount = [objects objectAtIndex:0];
                if (weakSelf.otherAccount.otherUserName) {
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"对方已绑定另一半" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alertVC addAction:confirm];
                    [self presentViewController:alertVC animated:YES completion:nil];
                    [weakSelf.hud removeFromSuperview];
                    return;
                }else{
                    weakSelf.cyAccount.otherUserName = weakSelf.textfield.text;
                    //上传到云端
                    AVObject *accountAV = [AVObject objectWithoutDataWithClassName:@"CYAccount" objectId:weakSelf.cyAccount.objectId];
                    [accountAV setObject:weakSelf.cyAccount.otherUserName forKey:@"otherUserName"];
                    [accountAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        weakSelf.otherAccount.otherUserName = weakSelf.cyAccount.userName;
                        [weakSelf.otherAccount setObject:weakSelf.cyAccount.userName forKey:@"otherUserName"];
                        //上传一个首页对象到服务器
                        weakSelf.accountHome = [SHAccountTool account];
                        NSMutableDictionary *accountHomeDic = weakSelf.accountHome.mj_keyValues;
                        AVObject *accountHomeAV = [[AVObject alloc] initWithClassName:@"SHAccountHome"];// 构建对象
                        [accountHomeAV setObject:accountHomeDic forKey:@"accountHome"];// 设置名称
                        [accountHomeAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            if (succeeded) {
                                CYLog(@"首页对象上传成功");
                                [accountAV setObject:accountHomeAV.objectId forKey:@"accountHomeObjID"];
                                [accountAV saveInBackground];
                                weakSelf.otherAccount.accountHomeObjID = accountHomeAV.objectId;
                                [weakSelf.otherAccount setObject:accountHomeAV.objectId forKey:@"accountHomeObjID"];
                                [weakSelf.otherAccount saveInBackground];
                                [CYOtherAccountTool saveOtherAccount:weakSelf.otherAccount];
                                //存储到本地
                                CYLog(@"存储另一半账户成功");
                                weakSelf.cyAccount.accountHomeObjID = accountHomeAV.objectId;
                                [CYAccountTool saveAccount:weakSelf.cyAccount];
                                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"另一半保存成功" preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                    [weakSelf.navigationController popViewControllerAnimated:YES];
                                }];
                                [alertVC addAction:confirm];
                                [weakSelf.hud removeFromSuperview];
                                [weakSelf presentViewController:alertVC animated:YES completion:nil];
                            }
                        }];
                    }];
                }
            }else{
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"绑定另一半失败" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [weakSelf.hud removeFromSuperview];
                [alertVC addAction:confirm];
                [weakSelf presentViewController:alertVC animated:YES completion:nil];
            }
        }];
    }else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"请输入正确的手机号" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:confirm];
        [weakSelf presentViewController:alertVC animated:YES completion:nil];
    }
    
    

    
    
    
    
    //上传到云端
//    AVObject *accountAV = [AVObject objectWithoutDataWithClassName:@"CYAccount" objectId:self.cyAccount.objectId];
//    [accountAV setObject:self.cyAccount.otherUserName forKey:@"otherUserName"];
//    [accountAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            //绑定另一半账号
//            weakSelf.otherAccount = [CYAccount new];
//            AVQuery *query = [CYAccount query];
//            [query whereKey:@"userName" equalTo:weakSelf.cyAccount.otherUserName];
//            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//                if (!error) {
//                    weakSelf.otherAccount = [objects objectAtIndex:0];
//                    if (weakSelf.otherAccount.otherUserName) {
//                        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"对方已绑定另一半" preferredStyle:UIAlertControllerStyleAlert];
//                        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                            
//                        }];
//                        
//                        [alertVC addAction:confirm];
//                        [self presentViewController:alertVC animated:YES completion:nil];
//                        [weakSelf.hud removeFromSuperview];
//                        return;
//                    }else{
//                        weakSelf.otherAccount.otherUserName = weakSelf.cyAccount.userName;
//                        [weakSelf.otherAccount setObject:weakSelf.cyAccount.userName forKey:@"otherUserName"];
//                        //上传一个首页对象到服务器
//                        weakSelf.accountHome = [SHAccountTool account];
//                        NSMutableDictionary *accountHomeDic = weakSelf.accountHome.mj_keyValues;
//                        AVObject *accountHomeAV = [[AVObject alloc] initWithClassName:@"SHAccountHome"];// 构建对象
//                        [accountHomeAV setObject:accountHomeDic forKey:@"accountHome"];// 设置名称
//                        [accountHomeAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                            if (succeeded) {
//                                CYLog(@"首页对象上传成功");
//                                [accountAV setObject:accountHomeAV.objectId forKey:@"accountHomeObjID"];
//                                [accountAV saveInBackground];
//                                weakSelf.otherAccount.accountHomeObjID = accountHomeAV.objectId;
//                                [weakSelf.otherAccount setObject:accountHomeAV.objectId forKey:@"accountHomeObjID"];
//                                [weakSelf.otherAccount saveInBackground];
//                                [CYOtherAccountTool saveOtherAccount:weakSelf.otherAccount];
//                                //存储到本地
//                                CYLog(@"存储另一半账户成功");
//                                weakSelf.cyAccount.accountHomeObjID = accountHomeAV.objectId;
//                                [CYAccountTool saveAccount:weakSelf.cyAccount];
//                                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"另一半保存成功" preferredStyle:UIAlertControllerStyleAlert];
//                                UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                                    [weakSelf.navigationController popViewControllerAnimated:YES];
//                                }];
//                                [alertVC addAction:confirm];
//                                [weakSelf.hud removeFromSuperview];
//                                [weakSelf presentViewController:alertVC animated:YES completion:nil];
//                        }
//                    }];
//                }
//                }
//            }];
//        }
//    }];
}

@end
