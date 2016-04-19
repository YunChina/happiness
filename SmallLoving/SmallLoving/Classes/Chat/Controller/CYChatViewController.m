//
//  CYChatViewController.m
//  SmallLoving
//
//  Created by Cheney on 16/3/19.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYChatViewController.h"
#import <AVOSCloud.h>
#import <AVIMImageMessage.h>


@interface CYChatViewController ()<AVIMClientDelegate>
@property (nonatomic, strong) AVIMClient *client;
@property(nonatomic,strong)NSArray * array;
@end

@implementation CYChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutNavigationBar];
    [self tomSendMessageToJerry];
    [self jerryReceiveMessageFromTom];
}

/**
 *  布局导航栏
 */
- (void)layoutNavigationBar {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"nav-bar-dark-close-btn"] style:(UIBarButtonItemStyleDone) target:self action:@selector(cancelAction)];
}

- (void)cancelAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//单聊
- (void)tomSendMessageToJerry {
    // Tom 创建了一个 client，用自己的名字作为 clientId
    self.client = [[AVIMClient alloc] initWithClientId:@"Tom"];
    
    // Tom 打开 client
    [self.client openWithCallback:^(BOOL succeeded, NSError *error) {
        // Tom 建立了与 Jerry 的会话
        [self.client createConversationWithName:@"猫和老鼠" clientIds:@[@"Jerry"] callback:^(AVIMConversation *conversation, NSError *error) {
            // Tom 发了一条消息给 Jerry
            [conversation sendMessage:[AVIMTextMessage messageWithText:@"耗子，起床！" attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    
                }
            }];
        }];
    }];
}
//接受消息
- (void)jerryReceiveMessageFromTom {
    // Jerry 创建了一个 client，用自己的名字作为 clientId
    self.client = [[AVIMClient alloc] initWithClientId:@"Jerry"];
    
    // 设置 client 的 delegate，并实现 delegate 方法
    self.client.delegate = self;
    
    // Jerry 打开 client
    [self.client openWithCallback:^(BOOL succeeded, NSError *error) {
        // ...
    }];
}




// 接收消息的回调函数
- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message {
    //    NSLog(@"%@", message.text); // 耗子，起床！
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
