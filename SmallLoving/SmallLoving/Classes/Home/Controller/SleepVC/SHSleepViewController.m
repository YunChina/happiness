//
//  SHSleepViewController.m
//  Happiness
//
//  Created by xIang on 16/3/22.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHSleepViewController.h"
#import "SHSleepView.h"
#import "SHAccountHome.h"
#import "SHAccountTool.h"
#import <MJExtension.h>
#import "CYAccount.h"
#import "CYAccountTool.h"

@interface SHSleepViewController ()

@property (nonatomic, strong) SHSleepView * sleepView;

@end

@implementation SHSleepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //取出账号信息

    CYAccount *cyAccount = [CYAccountTool account];
    
    SHSleepView *sleepView = [[SHSleepView alloc] initWithFrame:self.view.bounds];
    _sleepView = sleepView;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dataChangeAction) userInfo:nil repeats:YES];
    
    sleepView.sleepTimeLabel.text = [sleepView createdSinceNowWithDate:cyAccount.sleepTimeDate];
    
    [self.view addSubview:sleepView];
    
    //设置返回按钮
    [sleepView.backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //设置我醒了按钮
    [sleepView.wakeBtn addTarget:self action:@selector(wakeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dataChangeAction {
    CYAccount *cyAccount = [CYAccountTool account];
    _sleepView.sleepTimeLabel.text = [_sleepView createdSinceNowWithDate:cyAccount.sleepTimeDate];

}

- (void)wakeBtnAction:(UIButton *)button{
    //取出账号信息
    CYAccount *cyAccount = [CYAccountTool account];
    cyAccount.isSleep = @"NO";
    cyAccount.sleepTimeDate = nil;
    //存进沙盒
    //上传到云端

    AVObject *accountAV = [AVObject objectWithoutDataWithClassName:@"CYAccount" objectId:cyAccount.objectId];
    [accountAV setObject:cyAccount.isSleep forKey:@"isSleep"];
    [accountAV setObject:cyAccount.sleepTimeDate forKey:@"sleepTimeDate"];
    [accountAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //存储到本地
            CYLog(@"存储睡觉信息成功");
            //存储到沙盒
            [CYAccountTool saveAccount:cyAccount];
        }
    }];

    [CYAccountTool saveAccount:cyAccount];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)backBtnAction:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
