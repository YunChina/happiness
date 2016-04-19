//
//  SHAddMemorialTableViewController.m
//  SmallLoving
//
//  Created by xIang on 16/3/31.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHAddMemorialTableViewController.h"
#import "SHAddMemorialTableViewCell.h"
#import "SHMenstruationTableViewCell.h"
#import "SHAccountTool.h"
#import "SHMemorialModel.h"
#import "CYAccountTool.h"
#import "CYAccount.h"
#import <MJExtension.h>

@interface SHAddMemorialTableViewController ()
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property(nonatomic, strong)NSDate *tempDate;

@end

@implementation SHAddMemorialTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"SHAddMemorialTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SHMenstruationTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.tableView addGestureRecognizer:tapGestureRecognizer];

    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 100)];
    UIButton *deleteButton = [[UIButton alloc] init];
    [deleteButton setBackgroundImage:[UIImage imageNamed:@"album-delete-btn"] forState:UIControlStateNormal];
    deleteButton.frame = CGRectMake(30, 20, kScreenW-60, 30);
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [footerView addSubview:deleteButton];
    
    self.tableView.tableFooterView = footerView;
    
    if (self.indexRow && self.indexRow.intValue != 0) {
        self.tableView.tableFooterView.hidden = NO;
        [deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        self.tableView.tableFooterView.hidden = YES;
    }
    [self setNavigationBar];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}

- (void)deleteButtonAction:(UIButton *)btn{
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"删除纪念日" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //获取账户信息
        SHAccountHome *accountHome = [SHAccountTool account];
        NSMutableArray *memorialArr = [NSMutableArray arrayWithArray:accountHome.memorialArray];
        [memorialArr removeObjectAtIndex:weakSelf.indexRow.intValue];
        accountHome.memorialArray = memorialArr;
        //存储到沙盒
        CYAccount *cyAccount = [CYAccountTool account];
        //上传到云端
        if (cyAccount.accountHomeObjID) {
            AVObject *accountAV = [AVObject objectWithoutDataWithClassName:@"SHAccountHome" objectId:cyAccount.accountHomeObjID];
            [accountAV setObject:accountHome.mj_keyValues forKey:@"accountHome"];
            [accountAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    //存储到本地
                    CYLog(@"存储纪念日信息成功");
                    //存储到沙盒
                    [SHAccountTool saveAccount:accountHome];
                }
            }];
        }

        [SHAccountTool saveAccount:accountHome];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    [alertVC addAction:cancel];
    [alertVC addAction:confirm];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

//设置导航栏
- (void)setNavigationBar{
    if (self.indexRow) {
        self.navigationItem.title = @"编辑纪念日";
    }else{
        self.navigationItem.title = @"添加纪念日";
    }
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    //左键返回
    SHLeftBackButton *backButton = [[SHLeftBackButton alloc] init];
    [backButton setSelfWithImageName:@"nav-bar-white-back-btn" title:@"取消    "];
    [backButton addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)leftItemAction:(UIBarButtonItem *)leftItem{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightItemAction:(UIBarButtonItem *)rightItem{
    SHMenstruationTableViewCell *dateCell = self.tableView.visibleCells[1];
    SHAddMemorialTableViewCell *nameCell = self.tableView.visibleCells[0];
    //获取账户信息
    SHAccountHome *accountHome = [SHAccountTool account];
    NSMutableArray *memorialArr = [NSMutableArray arrayWithArray:accountHome.memorialArray];
    SHMemorialModel *memorialModel = [[SHMemorialModel alloc] init];
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";

    memorialModel.memorialDate = [formatter stringFromDate:dateCell.datePicker.date];
    if ([self.indexRow isEqualToString:@"0"] || !accountHome.memorialArray) {
        memorialModel.memorialName = nameCell.nameLabel.text;
    }else{
        memorialModel.memorialName = nameCell.nameTextField.text;
    }
    if (!self.indexRow) {
        [memorialArr addObject:memorialModel];
    }else{
        [memorialArr replaceObjectAtIndex:self.indexRow.intValue withObject:memorialModel];
    }
    accountHome.memorialArray = memorialArr;
    //存储到沙盒
    CYAccount *cyAccount = [CYAccountTool account];
    //上传到云端
    if (cyAccount.accountHomeObjID) {
        AVObject *accountAV = [AVObject objectWithoutDataWithClassName:@"SHAccountHome" objectId:cyAccount.accountHomeObjID];
        [accountAV setObject:accountHome.mj_keyValues forKey:@"accountHome"];
        [accountAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                //存储到本地
                CYLog(@"存储纪念日信息成功");
                //存储到沙盒
                [SHAccountTool saveAccount:accountHome];
            }
        }];
    }
    [SHAccountTool saveAccount:accountHome];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dateChanged:(id)sender {
    SHMenstruationTableViewCell *dateCell = self.tableView.visibleCells[1];
    //获取日期
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    NSString *timestamp = [formatter stringFromDate:dateCell.datePicker.date];
    dateCell.leftLabel.text = timestamp;
    self.tempDate = dateCell.datePicker.date;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取账户信息
    SHAccountHome *accountHome = [SHAccountTool account];
    SHMemorialModel *memorialModel = accountHome.memorialArray[self.indexRow.integerValue];

    if (indexPath.row == 0) {
        SHAddMemorialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if ([self.indexRow isEqualToString:@"0"] || !accountHome.memorialArray) {
            cell.nameTextField.hidden = YES;
            cell.nameLabel.hidden = NO;
        }else if(!self.indexRow){
            cell.nameTextField.hidden = NO;
            cell.nameLabel.hidden = YES;
        }else{
            cell.nameTextField.hidden = NO;
            cell.nameLabel.hidden = YES;
            cell.nameTextField.text = memorialModel.memorialName;
        }
        return cell;
    } else {
        SHMenstruationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.datePicker.hidden = YES;
        cell.datePickerView.hidden = YES;
        
        cell.leftImageView.image = [UIImage imageNamed:@"menses-recent-icon"];
        cell.rightLabel.text = @"日期选择";
        //获取日期
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd";
        if (self.tempDate) {
            NSString *timestamp = [formatter stringFromDate:self.tempDate];
            cell.leftLabel.text = timestamp;
        } else if(self.indexRow) {
            NSString *timestamp = memorialModel.memorialDate;
            cell.leftLabel.text = timestamp;
        } else {
            NSString *timestamp = [formatter stringFromDate:[NSDate date]];
            cell.leftLabel.text = timestamp;
        }
        if (indexPath == self.selectedIndexPath) {
            [cell.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
            if ([self.indexRow isEqualToString:@"0"] || !accountHome.memorialArray) {
                cell.datePicker.maximumDate = [NSDate date];
            }
            if (self.tempDate) {
                cell.datePicker.date = self.tempDate;
            } else if(self.indexRow) {
                cell.datePicker.date = [formatter dateFromString:memorialModel.memorialDate];
            } else {
                cell.datePicker.date = [NSDate date];
            }
            cell.datePicker.hidden = NO;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
    if(self.selectedIndexPath == nil)
    {
        self.selectedIndexPath = indexPath;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        bool hasSelectedOtherRow = ![self.selectedIndexPath isEqual:indexPath];
        NSIndexPath *temp = self.selectedIndexPath;
        self.selectedIndexPath = nil;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:temp] withRowAnimation:UITableViewRowAnimationAutomatic];
        if(hasSelectedOtherRow){
            self.selectedIndexPath = indexPath;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath == self.selectedIndexPath) {
        return 200;
    }
    return 44;
}

@end
