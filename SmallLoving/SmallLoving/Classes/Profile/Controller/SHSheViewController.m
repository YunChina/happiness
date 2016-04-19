//
//  SHSheViewController.m
//  Happiness
//
//  Created by 云志强 on 16/3/21.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHSheViewController.h"
#import "SHLeftBackButton.h"
#import "CYAccountTool.h"
#import "CYAccount.h"
#import "CYOtherAccountTool.h"
#import "SHImageTool.h"
#import <UIImageView+WebCache.h>
#import "SHIconTableViewCell.h"
#import "SHNickNameTableViewCell.h"
#import "SHOtherViewController.h"
#import "MBProgressHUD.h"
#import "SHAccountTool.h"
#import "CYOtherAccountTool.h"
#import "SHImageTool.h"



@interface SHSheViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)MBProgressHUD * hud;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)CYAccount *otherAccount;

@end

@implementation SHSheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"另一半";
    self.tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableview];
    
    
    [self.tableview registerClass:[SHIconTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableview registerClass:[SHNickNameTableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.bounces=NO;
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;//分割线
    //左键返回
    SHLeftBackButton *backButton = [[SHLeftBackButton alloc] init];
    [backButton setSelfWithImageName:@"nav-bar-white-back-btn" title:@" 我      "];
    [backButton addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.otherAccount = [CYOtherAccountTool otherAccount];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CYAccount *cyAccount = [CYAccountTool account];
    if (cyAccount.otherUserName) {
        AVQuery *query = [CYAccount query];
        __weak typeof(self) weakSelf = self;
        [query whereKey:@"userName" equalTo:cyAccount.otherUserName];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                weakSelf.otherAccount = [objects objectAtIndex:0];
                [CYOtherAccountTool saveOtherAccount:weakSelf.otherAccount];
                [weakSelf.tableview reloadData];
            }
        }];
    }else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"您还没有设置另一半账户" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"现在就去" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            SHOtherViewController *otherVC = [[SHOtherViewController alloc] init];
            [self.navigationController pushViewController:otherVC animated:YES];
        }];
        
        [alertVC addAction:cancel];
        [alertVC addAction:confirm];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}

- (void)leftItemAction:(UIBarButtonItem *)leftItem{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //分组数 也就是section数
    return 2;
}

//设置每个分组下tableview的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }else{
        return 1;
    }
}
//每个分组上边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

//每个分组下边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 60;
    }else{
        return 10;
    }
}

//每一个分组下对应的tableview 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
    }
    return 40;
}

//设置每行对应的cell（展示的内容）
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SHNickNameTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (indexPath.section==0 && indexPath.row==0) {
        SHIconTableViewCell *iconCell = [tableView dequeueReusableCellWithIdentifier:
                                         @"cell"];
        [iconCell.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.otherAccount.iconURL] placeholderImage:self.sheIconImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!error) {
                SHImageModel *imageModel = [SHImageTool imageModel];
                imageModel.otherImage = image;
                [SHImageTool saveImageModel:imageModel];
            }
        }];
        iconCell.iconLabel.text = @"头像";
        return iconCell;
    }
    if(indexPath.section == 0 && indexPath.row == 1){
        cell.nameLabel.text = @"昵称";
        //自己的昵称
        cell.nickNameLabel.text = self.otherAccount.nickName;
    }
    if(indexPath.section == 0 && indexPath.row == 2){
        cell.nameLabel.text = @"幸福号";
        cell.nickNameLabel.text = self.otherAccount.userName;
    }
    if(indexPath.section == 0 && indexPath.row == 3){
        cell.nameLabel.text = @"手机号";
        cell.nickNameLabel.text = self.otherAccount.userName;
    }
    if(indexPath.section == 1){
        CYAccount *account = [CYAccountTool account];
        if (account.otherUserName) {
            UITableViewCell *tabCell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
            tabCell.textLabel.text=@"解除关系";
            tabCell.textLabel.textColor = [UIColor redColor];
            tabCell.textLabel.textAlignment=NSTextAlignmentCenter;
            return tabCell;
        }else{
            UITableViewCell *tabCell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
            tabCell.textLabel.text=@"添加另一半";
            tabCell.textLabel.textColor = [UIColor blackColor];
            tabCell.textLabel.textAlignment=NSTextAlignmentCenter;
            return tabCell;

        }
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击cell  松开后颜色恢复点击前的颜色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==1) {
        CYAccount *cyAccount = [CYAccountTool account];
        if (cyAccount.otherUserName) {
            UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"十年修得同船渡,百年修得共枕眠.除非不爱了,否则我们不建议您轻易迈出这一步,请珍惜,请三思." preferredStyle:(UIAlertControllerStyleAlert)];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"解除关系" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                [self unchain];
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"手滑,点错了" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alerVC addAction:action1];
            [alerVC addAction:action2];
            [self presentViewController:alerVC animated:YES completion:nil];
        }else{
            SHOtherViewController *otherVC = [[SHOtherViewController alloc] init];
            [self.navigationController pushViewController:otherVC animated:YES];
        }
    }
}

-(void)unchain{
    //保存
    [self layoutHUD];
    CYAccount *cyAccount = [CYAccountTool account];
    NSString *otherUserName = cyAccount.otherUserName;
    NSString *accountHomeObjID = cyAccount.accountHomeObjID;
    cyAccount.otherUserName = nil;
    cyAccount.accountHomeObjID = nil;
    SHImageModel *imageModel = [SHImageTool imageModel];
    imageModel.otherImage = nil;
    imageModel.photosArr = nil;
    imageModel.coverImage = nil;
    
    //上传到云端
    AVObject *accountAV = [AVObject objectWithoutDataWithClassName:@"CYAccount" objectId:cyAccount.objectId];
    [accountAV setObject:cyAccount.otherUserName forKey:@"otherUserName"];
    [accountAV setObject:cyAccount.accountHomeObjID forKey:@"accountHomeObjID"];
    
    
    __weak typeof(self) weakSelf = self;
    [accountAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //存储到本地
            CYLog(@"关系解除成功");
            [CYAccountTool saveAccount:cyAccount];
            [SHImageTool saveImageModel:imageModel];
            //清除本地信息
            [CYOtherAccountTool removeOtherAccount];
            [SHAccountTool removeAccountHome];
            
            //取出服务器存储的home信息 删除
            AVObject *accountHomeAV = [AVObject objectWithoutDataWithClassName:@"SHAccountHome" objectId:accountHomeObjID];
            [accountHomeAV deleteInBackground];
            
            //将另一半账号相关信息制空
            AVQuery *query = [CYAccount query];
            [query whereKey:@"userName" equalTo:otherUserName];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    CYAccount *otherAccount = [objects objectAtIndex:0];
                    otherAccount.otherUserName = nil;
                    [otherAccount setObject:nil forKey:@"otherUserName"];
                    otherAccount.accountHomeObjID = nil;
                    [otherAccount setObject:nil forKey:@"accountHomeObjID"];
                    [otherAccount saveInBackground];
                }
            }];
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"关系解除成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alertVC addAction:confirm];
            [weakSelf.hud removeFromSuperview];
            [weakSelf presentViewController:alertVC animated:YES completion:nil];
        }else{
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"关系解除失败" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alertVC addAction:confirm];
            [weakSelf.hud removeFromSuperview];
            [weakSelf presentViewController:alertVC animated:YES completion:nil];
        }
    }];
}

- (void)layoutHUD {
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    self.hud.frame = self.view.bounds;
    self.hud.labelText = @"关系解除中...";
    self.hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:self.hud];
    [self.hud show:YES];
}
@end
