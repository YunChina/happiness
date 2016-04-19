//
//  CYTabBarController.m
//  SmallLoving
//
//  Created by Cheney on 16/3/19.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYTabBarController.h"
#import "SHHomeViewController.h"
#import "SHSweetTimeViewController.h"
#import "CDChatViewController.h"
#import "CYNotificationViewController.h"
#import "SHProfileViewController.h"
#import "CYNavigationController.h"
#import "CYTabBarButton.h"
#import "CYTabBar.h"
#import <CDChatManager.h>
#import "CYAccount.h"
#import "CYAccountTool.h"

@interface CYTabBarController ()

@property (nonatomic, strong) SHHomeViewController * smallLovingVC;
@property (nonatomic, strong) SHSweetTimeViewController * discoverVC;
@property (nonatomic, strong) CDChatViewController * chatVC;
@property (nonatomic, strong) CYNotificationViewController * notificationVC;
@property (nonatomic, strong) SHProfileViewController * profileVC;

@end

@implementation CYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    CYTabBar * tabBar = [[CYTabBar alloc]initWithFrame:self.tabBar.bounds];
    [self setValue:tabBar forKey:@"tabBar"];
    [self addAllChildViewControllers];
}

/**
 *  添加所有的子视图控制器
 */
- (void)addAllChildViewControllers {
    // 创建控制器
    SHHomeViewController * smallLovingVC = [[SHHomeViewController alloc]init];
    _smallLovingVC = smallLovingVC;
    SHSweetTimeViewController * discoverVC = [[SHSweetTimeViewController alloc]init];
    _discoverVC = discoverVC;
    CDChatViewController * chatVC = [[CDChatViewController alloc]init];
    _chatVC = chatVC;
    CYNotificationViewController * notificationVC = [[CYNotificationViewController alloc]init];
    _notificationVC = notificationVC;
    SHProfileViewController * profileVC = [[SHProfileViewController alloc]init];
    _profileVC = profileVC;
    // 添加控制器
    [self addOneChildViewController:smallLovingVC image:[UIImage imageWithOriginalName:@"tab-bar-home-icon-normal"] selectedImage:[UIImage imageWithOriginalName:@"tab-bar-home-icon-selected"] title:@"小幸福"];
    [self addOneChildViewController:discoverVC image:[UIImage imageWithOriginalName:@"tab-bar-discovery-icon-normal"] selectedImage:[UIImage imageWithOriginalName:@"tab-bar-discovery-icon-selected"] title:@"发现"];
    [((CYTabBar *)self.tabBar).barBtn addTarget:self action:@selector(chatAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self addOneChildViewController:notificationVC image:[UIImage imageWithOriginalName:@"tab-bar-notification-icon-normal"] selectedImage:[UIImage imageWithOriginalName:@"tab-bar-notification-icon-selected"] title:@"通知"];
    [self addOneChildViewController:profileVC image:[UIImage imageWithOriginalName:@"tab-bar-profile-icon-normal"] selectedImage:[UIImage imageWithOriginalName:@"tab-bar-profile-icon-selected"] title:@"我"];
}

/**
 *  添加一个子视图控制器
 */
- (void)addOneChildViewController:(UIViewController *)viewController image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title {
    CYNavigationController * naVC = [[CYNavigationController alloc]initWithRootViewController:viewController];
    viewController.title = title;
    naVC.tabBarItem.title = title;
    naVC.tabBarItem.image = image;
    naVC.tabBarItem.selectedImage = selectedImage;
    [self addChildViewController:naVC];
}

- (void)chatAction {
    CYAccount *cyAccount = [CYAccountTool account];
    if (cyAccount.otherUserName) {
        [[CDChatManager manager]openWithClientId:cyAccount.userName callback:^(BOOL succeeded, NSError *error) {
            [[CDChatManager manager]fetchConversationWithOtherId:cyAccount.otherUserName callback:^(AVIMConversation *conversation, NSError *error) {
                CDChatViewController *chat = [[CDChatViewController alloc] initWithConversation:conversation];
                CYNavigationController * nav = [[CYNavigationController alloc]initWithRootViewController:chat];
                [self presentViewController:nav animated:YES completion:nil];
        }];
        }];
    }else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"还没有设置另一半" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:confirm];
        [self presentViewController:alertVC animated:YES completion:nil];
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
