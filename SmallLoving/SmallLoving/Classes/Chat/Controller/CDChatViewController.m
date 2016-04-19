//
//  CDChatViewController.m
//  SmallLoving
//
//  Created by macbookpro on 16/3/25.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CDChatViewController.h"
#import <CDChatManager.h>
#import <AVOSCloud.h>
#import <AVIMImageMessage.h>
#import "CYAccountTool.h"
#import "CYAccount.h"


@interface CDChatViewController ()<AVIMClientDelegate>
@property (nonatomic, strong) AVIMClient *client;
@property(nonatomic,strong)NSArray * array;


@end

@implementation CDChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutNavigationBar];
    
//    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

//布局导航栏
-(void)layoutNavigationBar{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"nav-bar-dark-close-btn"] style:(UIBarButtonItemStyleDone) target:self action:@selector(cancelAction)];
}

- (void)cancelAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}




// 接收消息的回调函数
//- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message {
////    NSLog(@"%@", message.text); // 耗子，起床！
//}      

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
