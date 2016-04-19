//
//  SHAuntViewController.m
//  Happiness
//
//  Created by xIang on 16/3/21.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHAuntViewController.h"
#import "SHSexViewController.h"
#import "SHMenstruationTableViewController.h"
#import "SHAuntIsComing.h"
#import "SHAccountTool.h"
#import "CYAccount.h"
#import "CYAccountTool.h"
#import <MJExtension.h>

@interface SHAuntViewController ()
@property (nonatomic, strong) SHAuntIsComing * auntIsComingView;
@end

@implementation SHAuntViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setNavigationBar];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChangeAction) userInfo:nil repeats:YES];
    //设置性别视图
    //获取账户信息
    CYAccount *cyAccount = [CYAccountTool account];
    if (cyAccount.sex == nil) {
        SHSexViewController *sexVC = [[SHSexViewController alloc] init];
        [self.navigationController pushViewController:sexVC animated:YES];
    }
    SHAuntIsComing *auntIsComingView = [[SHAuntIsComing alloc] initWithFrame:self.view.bounds];
    self.auntIsComingView = auntIsComingView;
    [auntIsComingView.womanBtn addTarget:self action:@selector(womanBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:auntIsComingView];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取账户信息
    CYAccount *cyAccount = [CYAccountTool account];
    SHAccountHome *accountHome = [SHAccountTool account];
    if (cyAccount.sex) {
        //设置界面内容
        [self.auntIsComingView setupViewWithAccountHome:accountHome];
    }
}



//设置导航栏
- (void)setNavigationBar{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"小姨妈";
    //右键设置
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //左键返回
    SHLeftBackButton *backButton = [[SHLeftBackButton alloc] init];
    [backButton setSelfWithImageName:@"nav-bar-white-back-btn" title:@"小幸福"];
    [backButton addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

//女性按钮点击事件
- (void)womanBtnAction:(UIButton *)sender{
    CYAlertController *alertVC = [CYAlertController showAlertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet isSucceed:YES viewController:self];
    CYAlertAction *actionCamera = [CYAlertAction actionWithTitle:@"确认发送" handler:^(UIAlertAction *action) {
        //获取账户信息
        SHAccountHome *accountHome = [SHAccountTool account];
        if ([accountHome.isMenstruation isEqualToString:@"YES"]) {
            accountHome.isMenstruation = @"NO";
        }else{
            accountHome.isMenstruation = @"YES";
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            //设置日期格式(声明字符串里面每个数字和单词的含义)
            fmt.dateFormat = @"yyyy-MM-dd";
            accountHome.lastAuntDate = [fmt stringFromDate:[NSDate date]];
        }
        //存储到沙盒
        CYAccount *cyAccount = [CYAccountTool account];
        //上传到云端
        if (cyAccount.accountHomeObjID) {
            AVObject *accountAV = [AVObject objectWithoutDataWithClassName:@"SHAccountHome" objectId:cyAccount.accountHomeObjID];
            [accountAV setObject:accountHome.mj_keyValues forKey:@"accountHome"];
            [accountAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    //存储到本地
                    CYLog(@"存储是否正在姨妈期成功");
                    //存储到沙盒
                    [SHAccountTool saveAccount:accountHome];
                }
            }];
        }
        [SHAccountTool saveAccount:accountHome];

        SHAuntIsComing *auntIsComingView = [[SHAuntIsComing alloc] initWithFrame:self.view.bounds];
        [auntIsComingView.womanBtn addTarget:self action:@selector(womanBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.auntIsComingView removeFromSuperview];
        self.auntIsComingView = auntIsComingView;
        [self.view addSubview:auntIsComingView];
        //设置界面内容
        [self.auntIsComingView setupViewWithAccountHome:accountHome];
    }];
    alertVC.allActions = @[actionCamera];
}

- (void)leftItemAction:(UIBarButtonItem *)leftItem{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightItemAction:(UIBarButtonItem *)rightItem{
    //获取账户信息
    CYAccount *cyAccount= [CYAccountTool account];
    if ([cyAccount.sex isEqualToString:@"m"]) {
        SHSexViewController *sexVC = [[SHSexViewController alloc] init];
        [self.navigationController pushViewController:sexVC animated:YES];
    }else if ([cyAccount.sex isEqualToString:@"f"]) {
        SHMenstruationTableViewController *menstruationTVC = [[SHMenstruationTableViewController alloc] init];
        [self.navigationController pushViewController:menstruationTVC animated:YES];
    }
}

- (void)timeChangeAction{
    //获取账户信息
    SHAccountHome *accountHome = [SHAccountTool account];
    if (([accountHome.isMenstruation isEqualToString:@"NO"] || self.auntIsComingView.auntTowelFirstLabel.text) && accountHome.lastAuntDate && accountHome.interval) {
        [self.auntIsComingView setupAuntTowelSecondLabelWithAccountHome:accountHome];
    }
}
@end
