//
//  SHSexViewController.m
//  Happiness
//
//  Created by xIang on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHSexViewController.h"
#import "SHSexView.h"
#import "SHIconView.h"
#import "SHAccountHome.h"
#import "SHAccountTool.h"
#import "CYAccount.h"
#import <MJExtension.h>
#import "CYAccountTool.h"

@interface SHSexViewController ()
@property (nonatomic, strong) SHSexView * sexView;
@end

@implementation SHSexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.sexView = [[SHSexView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.sexView];
    [self.sexView.confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.sexView.manIconView.iconBtn addTarget:self action:@selector(manIconBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.sexView.womanIconView.iconBtn addTarget:self action:@selector(womanIconBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //获取账户信息
    CYAccount *cyAccount = [CYAccountTool account];
    if ([cyAccount.sex isEqualToString:@"f"]) {
        self.sexView.womanIconView.selectedImageView.hidden = NO;
    }else{
        self.sexView.manIconView.selectedImageView.hidden = NO;
    }
    
    
}

//设置导航栏
- (void)setNavigationBar{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"设置";
    
    //左键返回
    SHLeftBackButton *backButton = [[SHLeftBackButton alloc] init];
    [backButton setSelfWithImageName:@"nav-bar-white-back-btn" title:@"小姨妈"];
    [backButton addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)leftItemAction:(UIBarButtonItem *)leftItem{
    [self.navigationController popViewControllerAnimated:YES];
}


//确定btn点击事件
- (void)confirmBtnAction:(UIButton *)confirmBtn{
    NSString *genderStr = [NSString string];
    if (!self.sexView.manIconView.selectedImageView.hidden) {
        genderStr = @"m";
    }else if (!self.sexView.womanIconView.selectedImageView.hidden){
        genderStr = @"f";
    }

    if ([genderStr isEqualToString:@"m"] || [genderStr isEqualToString:@"f"]) {
        CYAlertController *alertVC = [CYAlertController showAlertControllerWithTitle:@"提示" message:@"性别修改成功" preferredStyle:UIAlertControllerStyleActionSheet isSucceed:YES viewController:self];
        CYAlertAction *actionCamera = [CYAlertAction actionWithTitle:@"确定" handler:^(UIAlertAction *action) {
            //获取账户信息
            CYAccount *cyAccount = [CYAccountTool account];
            cyAccount.sex = genderStr;
            //存储到沙盒
            //上传到云端
            [CYAccountTool saveAccount:cyAccount];
            //上传到云端
            AVObject *accountAV = [AVObject objectWithoutDataWithClassName:@"CYAccount" objectId:cyAccount.objectId];
            [accountAV setObject:cyAccount.sex forKey:@"sex"];
            __weak typeof(self) weakSelf = self;
            [accountAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    //存储到本地
                    CYLog(@"存储性别成功");
                    [CYAccountTool saveAccount:cyAccount];
                    if ([genderStr isEqualToString:@"m"]) {
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }else{
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }
                }
            }];

        }];
        alertVC.allActions = @[actionCamera];
    }
}

//选择男性btn点击事件
- (void)manIconBtnAction:(UIButton *)iconBtn{
    self.sexView.manIconView.selectedImageView.hidden = NO;
    self.sexView.womanIconView.selectedImageView.hidden = YES;
}

//选择女性btn点击事
- (void)womanIconBtnAction:(UIButton *)iconBtn{
    self.sexView.manIconView.selectedImageView.hidden = YES;
    self.sexView.womanIconView.selectedImageView.hidden = NO;
}


@end
