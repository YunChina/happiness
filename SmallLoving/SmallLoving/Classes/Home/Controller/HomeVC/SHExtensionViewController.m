//
//  SHExtensionViewController.m
//  Happiness
//
//  Created by xIang on 16/3/19.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "SHExtensionViewController.h"
#import "SHExtensionCollectionViewCell.h"
#import "SHExtensionView.h"
#import "SHAuntViewController.h"
#import "SHAlbumViewController.h"
#import "SHMemorialTableViewController.h"
#import "SHDiaryTableViewController.h"
#import "SHSleepViewController.h"
#import "SHAccountTool.h"
#import "SHAccountHome.h"
#import <MJExtension.h>
#import "CYAccount.h"
#import "CYAccountTool.h"
#import "SHHTTPManager.h"
#import <CDChatManager.h>


#define kWAndH ([UIScreen mainScreen].bounds.size.width - 40) / 3


@interface SHExtensionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,CLLocationManagerDelegate>
@property(nonatomic, strong)NSArray *picArray;
@property(nonatomic, strong)NSArray *picTitleArr;
@property (nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic, strong) AVIMClient *client;
@end

@implementation SHExtensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建对象
    //1.1先创建UICollectionViewFlowLayout对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //1.2配置UICollectionViewFlowLayout的相关属性
    //行间距
    flowLayout.minimumLineSpacing = 10;
    
    //列间距
//    flowLayout.minimumInteritemSpacing = 10;
    //每个item的大小
    flowLayout.itemSize = CGSizeMake(kWAndH, kWAndH);
    //设置距屏幕边缘的距离
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    //滚动方向(默认上下滚动)
    //    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //1.3实例化UICollectionViewFlowLayout并设置flowLayout
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kScreenH/2.5 - 64 - 49) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    //2.配置属性
    
    //3.添加到父视图
    [self.view addSubview:self.collectionView];
    
    //设置代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[SHExtensionCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.picArray = @[@"extension-wake-icon",@"extension-distance-icon",@"extension-menses-icon",@"extension-album-icon",@"extension-anniversary-icon",@"extension-todo-icon"];
    self.picTitleArr = @[@"我睡了",@"发送距离",@"小姨妈",@"私密相册",@"纪念日",@"日记本"];
    
    __weak typeof(self) weakSelf = self;
    [SHHTTPManager shareHTTPManager].reloadDataBlock = ^(){
        [weakSelf.collectionView reloadData];
    };
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SHExtensionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSString *picName = self.picArray[indexPath.row];
    NSString *picTitle = self.picTitleArr[indexPath.row];
    //获取账户信息
    CYAccount *cyAccount = [CYAccountTool account];
    if (indexPath.row == 0) {
        if ([cyAccount.isSleep isEqualToString:@"YES"]) {
            cell.extensionView.imageView.image = [UIImage imageNamed:@"extension-sleeping-icon"];
            cell.extensionView.label.text = @"正在睡觉";
            return cell;
        }
    }
    cell.extensionView.imageView.image = [UIImage imageNamed:picName];
    cell.extensionView.label.text = picTitle;
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    //获取账户信息
    CYAccount *cyAccount = [CYAccountTool account];
    
    if (indexPath.row == 0) {//我睡了
        if ([cyAccount.isSleep isEqualToString:@"YES"]) {
            SHSleepViewController *sleepVC = [[SHSleepViewController alloc] init];
            sleepVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:sleepVC animated:YES completion:nil];
        }else{
        //添加事件
        //我睡了
        UIAlertAction *actionSleep = [UIAlertAction actionWithTitle:@"我睡了" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            SHExtensionCollectionViewCell *cell = (SHExtensionCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            cell.extensionView.imageView.image = [UIImage imageNamed:@"extension-sleeping-icon"];
            cell.extensionView.label.text = @"正在睡觉";
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            //设置日期格式(声明字符串里面每个数字和单词的含义)
            fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            cyAccount.sleepTimeDate = [fmt stringFromDate:[NSDate date]];
            cyAccount.isSleep = @"YES";
            //存入沙盒
            //上传到云端
            AVObject *accountAV = [AVObject objectWithoutDataWithClassName:@"CYAccount" objectId:cyAccount.objectId];
            [accountAV setObject:cyAccount.sleepTimeDate forKey:@"sleepTimeDate"];
            [accountAV setObject:cyAccount.isSleep forKey:@"isSleep"];
            [accountAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    //存储到本地
                    CYLog(@"存储睡觉信息成功");
                    //存储到沙盒
                    [CYAccountTool saveAccount:cyAccount];
                }
            }];

            [CYAccountTool saveAccount:cyAccount];
        }];
        [alertVC addAction:actionSleep];
            
        //取消
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
            
        }];
        [alertVC addAction:actionCancel];
        // 模态显示
        [self presentViewController:alertVC animated:YES completion:nil];
        }
    } else if (indexPath.row == 1){//发送距离
        // 添加事件
        //发送距离
        UIAlertAction *actionSleep = [UIAlertAction actionWithTitle:@"发送距离" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            [self areaLocation];
        }];
        [alertVC addAction:actionSleep];
        
        //取消
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
            
        }];
        [alertVC addAction:actionCancel];
        // 模态显示
        [self presentViewController:alertVC animated:YES completion:nil];
    } else if (indexPath.row == 2){//小姨妈
        SHAuntViewController *auntVC = [[SHAuntViewController alloc] init];
        [self.navigationController pushViewController:auntVC animated:YES];
    } else if (indexPath.row == 3){
        SHAlbumViewController *albumVC = [[SHAlbumViewController alloc] init];
        [self.navigationController pushViewController:albumVC animated:YES];
    } else if (indexPath.row == 4){
        SHMemorialTableViewController *memorialTVC = [[SHMemorialTableViewController alloc] init];
        [self.navigationController pushViewController:memorialTVC animated:YES];
    } else if (indexPath.row == 5){
        SHDiaryTableViewController *diaryTVC = [[SHDiaryTableViewController alloc] init];
        [self.navigationController pushViewController:diaryTVC animated:YES];
    }
}


//定位发送距离
- (void)areaLocation{
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled]) {
        [self sendDistance];
    }else {
        //提示用户无法进行定位操作
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"无法进行定位操作" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
        }];
        [alertVC addAction:action];
        // 模态显示
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    
}

//计算两点距离
- (void)sendDistance{
    //获取账户信息
    CYAccount *cyAccount = [CYAccountTool account];
    if (cyAccount.otherUserName) {
        AVQuery *query = [CYAccount query];
        [query whereKey:@"userName" equalTo:cyAccount.otherUserName];
        __weak typeof(self) weakSelf = self;
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                CYAccount *otherAccount = [objects objectAtIndex:0];
                //对方坐标
                //第一个坐标
                CLLocation *current= [[CLLocation alloc] initWithLatitude:cyAccount.latitude.doubleValue longitude:cyAccount.longitude.doubleValue];
                
                CLLocation *otherLoation = [[CLLocation alloc] initWithLatitude:otherAccount.latitude.doubleValue longitude:otherAccount.longitude.doubleValue];
                // 计算距离
                CLLocationDistance meters = [current distanceFromLocation:otherLoation];
                NSString *distanceStr;
                if (meters >= 1000) {//公里
                    distanceStr = [NSString stringWithFormat:@"%.1f公里",meters/1000];
                } else {//米
                    distanceStr = [NSString stringWithFormat:@"%d米",(int)meters];
                }
                
                [self meSendMessageToOtherWithDistanceStr:distanceStr];
                //提示框
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"发送距离成功" message:[NSString stringWithFormat:@"你们两人距离为:%@",distanceStr] preferredStyle:(UIAlertControllerStyleActionSheet)];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                }];
                [alertVC addAction:action];
                // 模态显示
                [weakSelf presentViewController:alertVC animated:YES completion:nil];
            }
        }];
    } else {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"还没有设置另一半" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:confirm];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    
}


- (void)meSendMessageToOtherWithDistanceStr:(NSString *)distanceStr {
    // Tom 创建了一个 client，用自己的名字作为 clientId
    CYAccount *cyAccount = [CYAccountTool account];
    self.client = [[AVIMClient alloc] initWithClientId:cyAccount.userName];
    
    // Tom 打开 client
    [self.client openWithCallback:^(BOOL succeeded, NSError *error) {
        // Tom 建立了与 Jerry 的会话
        [self.client createConversationWithName:nil clientIds:@[cyAccount.otherUserName] callback:^(AVIMConversation *conversation, NSError *error) {
            // Tom 发了一条消息给 Jerry
            [conversation sendMessage:[AVIMTextMessage messageWithText:distanceStr attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"发送距离给对方成功！");
                }
            }];
        }];
    }];
}




@end
