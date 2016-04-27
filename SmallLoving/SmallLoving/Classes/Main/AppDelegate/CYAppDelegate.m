//
//  CYAppDelegate.m
//  SmallLoving
//
//  Created by Cheney on 16/3/19.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYAppDelegate.h"
#import "CYRootTool.h"
#import "AVOSCloudSNS.h"
#import "CYAccount.h"
#import "CYAccountTool.h"
#import "SHAccountTool.h"
#import <MJExtension.h>
#import "CYOtherAccountTool.h"
#import "SHImageTool.h"
#import "SHUserFactory.h"
#import <CDChatManager.h>
#import "SHHTTPManager.h"
#import "JPUSHService.h"
@interface CYAppDelegate ()
@property(nonatomic, strong)CYAccount *cyAccount;

@end

@implementation CYAppDelegate
/**
 *  程序准备就绪即将运行
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    
    [AVOSCloud setApplicationId:@"kpXxKrkTjlgyw3uTWPDKCLLC-gzGzoHsz"
                      clientKey:@"MhUJHBVAPtplMw7rg18JCECh"];
    [CYAccount registerSubclass];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    //我是推送
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"PushConfig" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    //可以添加自定义categories
    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                      UIUserNotificationTypeSound |
                                                      UIUserNotificationTypeAlert)
                                          categories:nil];
    // Required
    //如需兼容旧版本的方式，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化和同时使用pushConfig.plist文件声明appKey等配置内容。
    [JPUSHService setupWithOption:launchOptions appKey:[data objectForKey:@"APP_KEY"] channel:[data objectForKey:@"CHANNEL"] apsForProduction:@"False"];
    
    //重置账户信息
    
    self.cyAccount = [CYAccountTool account];
    if (self.cyAccount) {
//        AVQuery *query = [CYAccount query];
//        __weak typeof(self) weakSelf = self;
//        [query whereKey:@"userName" equalTo:self.cyAccount.userName];
//        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            if (!error) {
//                weakSelf.cyAccount = [objects objectAtIndex:0];
//                
//                //同步home数据到本地
//                AVQuery *query = [AVQuery queryWithClassName:@"SHAccountHome"];
//                [query getObjectInBackgroundWithId:weakSelf.cyAccount.accountHomeObjID block:^(AVObject *object, NSError *error) {
//                    NSDictionary *accountHomeDic = [object objectForKey:@"accountHome"];
//                    SHAccountHome *accountHome = [SHAccountTool account];
//                    accountHome = [SHAccountHome mj_objectWithKeyValues:accountHomeDic];
//                    
//                    SHImageModel *imageModel = [SHImageTool imageModel];
//                    if (accountHome.photoUrlArray) {
//                        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                            NSMutableArray *photoArr = [NSMutableArray array];
//                            for (NSString *photoUrl in accountHome.photoUrlArray) {
//                                NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:photoUrl]];
//                                [photoArr addObject:[UIImage imageWithData:data]];
//                            }
//                            CYLog(@"同步云端相册成功");
//                            imageModel.photosArr = photoArr;
//                            [SHImageTool saveImageModel:imageModel];
//                        });
//                    }
//                    [SHImageTool saveImageModel:imageModel];
//                    [SHAccountTool saveAccount:accountHome];
//                    CYLog(@"同步首页数据成功");
//                    [CYAccountTool saveAccount:weakSelf.cyAccount];
//                    if (weakSelf.cyAccount.otherUserName) {
//                        AVQuery *query = [CYAccount query];
//                        [query whereKey:@"userName" equalTo:weakSelf.cyAccount.otherUserName];
//                        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//                            if (!error) {
//                                CYAccount *otherAccount = [objects objectAtIndex:0];
//                                [CYOtherAccountTool saveOtherAccount:otherAccount];
//                            }
//                        }];
//                    }
//                }];
//            }
//        }];
        
        [[SHHTTPManager shareHTTPManager] synchronizationAccountWithCyAccount:self.cyAccount];
    }
    [CDChatManager manager].userDelegate = [[SHUserFactory alloc]init];
    
    [self.window makeKeyAndVisible];
    [CYRootTool setRootViewController];

    return YES;
}
//leancloud
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [AVOSCloudSNS handleOpenURL:url];
}

// When Build with IOS 9 SDK
// For application on system below ios 9
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [AVOSCloudSNS handleOpenURL:url];
}
// For application on system equals or larger ios 9
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [AVOSCloudSNS handleOpenURL:url];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //取消气泡
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


//我是推送
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}


- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    //3D Touch跳转预留
}
@end
