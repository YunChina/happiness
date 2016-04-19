//
//  SHMenstruationTableViewController.m
//  Happiness
//
//  Created by xIang on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHMenstruationTableViewController.h"
#import "SHMenstruationHeaderView.h"
#import "SHMenstruationTableViewCell.h"
#import "SHMenstruationFooterView.h"
#import "SHSexViewController.h"
#import "SHAccountHome.h"
#import "SHAccountTool.h"
#import "CYAccountTool.h"
#import "CYAccount.h"
#import <MJExtension.h>


@interface SHMenstruationTableViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic,strong) NSMutableArray *dayArray;
@end

@implementation SHMenstruationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    
    self.selectedIndexPath = nil;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SHMenstruationTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    SHMenstruationHeaderView *headerView = [[SHMenstruationHeaderView alloc] init];
    [headerView setupWithBackgroundImageName:@"menses-setting-bg" firstName:@"请设置你的月经信息" secondName:@"当来大姨妈时,另一半会第一时间知道哦"];
    headerView.frame = CGRectMake(0, 0, kScreenW, (kScreenH-64)/3);
    self.tableView.tableHeaderView = headerView;
    
    SHMenstruationFooterView *footerView = [[SHMenstruationFooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 100)];
    self.tableView.tableFooterView = footerView;
    
    [footerView.firstButton addTarget:self action:@selector(firstButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView.secondButton addTarget:self action:@selector(secondButtoAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取账户信息
    CYAccount *cyAccount = [CYAccountTool account];
    if ([cyAccount.sex isEqualToString:@"m"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)firstButtonAction:(UIButton *)sender{
    CYAlertController *alertVC = [CYAlertController showAlertControllerWithTitle:@"提示" message:@"保存成功" preferredStyle:UIAlertControllerStyleActionSheet isSucceed:YES viewController:self];
    CYAlertAction *actionCamera = [CYAlertAction actionWithTitle:@"确定" handler:^(UIAlertAction *action) {
        //获取账户信息
        SHAccountHome *accountHome = [SHAccountTool account];
        
        //上次姨妈时间cell
        SHMenstruationTableViewCell *dateCell = self.tableView.visibleCells[0];
        //设置上次姨妈时间
        accountHome.lastAuntDate = dateCell.rightLabel.text;
        
        //姨妈间隔cell
        SHMenstruationTableViewCell *intervalCell = self.tableView.visibleCells[1];
        //设置姨妈间隔时间
        accountHome.interval = [intervalCell.rightLabel.text substringToIndex:2];
        //存储到沙盒
        CYAccount *cyAccount = [CYAccountTool account];
        //上传到云端
        if (cyAccount.accountHomeObjID) {
            AVObject *accountAV = [AVObject objectWithoutDataWithClassName:@"SHAccountHome" objectId:cyAccount.accountHomeObjID];
            [accountAV setObject:accountHome.mj_keyValues forKey:@"accountHome"];
            [accountAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    //存储到本地
                    CYLog(@"存储姨妈信息成功");
                    //存储到沙盒
                    [SHAccountTool saveAccount:accountHome];
                }
            }];
        }
        [SHAccountTool saveAccount:accountHome];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    alertVC.allActions = @[actionCamera];
}

- (void)secondButtoAction:(UIButton *)sender{
    SHSexViewController *sexVC = [[SHSexViewController alloc] init];
    [self.navigationController pushViewController:sexVC animated:YES];
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

- (void)dateChanged:(id)sender {
    SHMenstruationTableViewCell *dateCell = self.tableView.visibleCells[0];
    SHMenstruationTableViewCell *intervalCell = self.tableView.visibleCells[1];
    //获取日期
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    formatter.dateFormat =  @"yyyy-MM-dd";
    NSString *timestamp = [formatter stringFromDate:dateCell.datePicker.date];
    dateCell.rightLabel.text = timestamp;
    //获取账户信息
    SHAccountHome *accountHome = [SHAccountTool account];
    accountHome.lastAuntDate = [formatter stringFromDate:dateCell.datePicker.date];
    accountHome.interval = [intervalCell.rightLabel.text substringToIndex:2];
    //存储到沙盒
    [SHAccountTool saveAccount:accountHome];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SHMenstruationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //获取账户信息
    SHAccountHome *accountHome = [SHAccountTool account];
    cell.datePicker.hidden = YES;
    cell.datePicker.maximumDate = [NSDate date];
    
    cell.datePickerView.hidden = YES;
    cell.datePickerView.dataSource = self;
    cell.datePickerView.delegate = self;
    
    self.dayArray = [NSMutableArray array];
    for (int i = 15; i<91; i++) {
        [self.dayArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [cell.datePickerView reloadAllComponents];
    
    
    //获取日期
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    formatter.dateFormat =  @"yyyy-MM-dd";
    if (indexPath.row == 0) {
        cell.leftImageView.image = [UIImage imageNamed:@"menses-recent-icon"];
        cell.leftLabel.text = @"上一次来姨妈";
        if (!accountHome.lastAuntDate) {
            NSString *timestamp = [formatter stringFromDate:[NSDate date]];
            cell.rightLabel.text = timestamp;
        } else {
            NSString *timestamp = accountHome.lastAuntDate;
            cell.rightLabel.text = timestamp;
        }
        if (indexPath == self.selectedIndexPath) {
            [cell.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
            if (accountHome.lastAuntDate) {
                cell.datePicker.date = [formatter dateFromString:accountHome.lastAuntDate];
            }else{
                cell.datePicker.date = [NSDate date];
            }
            cell.datePicker.hidden = NO;
        }
    }else if(indexPath.row == 1){
        cell.leftImageView.image = [UIImage imageNamed:@"menses-interval-icon"];
        cell.leftLabel.text = @"姨妈间隔";
        if (!accountHome.interval) {
            cell.rightLabel.text = @"28天";
        }else{
            cell.rightLabel.text = accountHome.interval;
        }
        if (indexPath == self.selectedIndexPath) {
            cell.datePicker.hidden = YES;
            cell.datePickerView.hidden = NO;
            [cell.datePickerView selectRow:[cell.rightLabel.text substringToIndex:2].integerValue - 15  inComponent:0 animated:NO];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.selectedIndexPath == nil)
    {
        self.selectedIndexPath = indexPath;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else{
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath == self.selectedIndexPath) {
        return 200;
    }
    return 44;
}


#pragma mark --  UIPickerViewDataSource

/**
 *  返回有几个PickerView
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dayArray.count;
}

#pragma mark --  UIPickerViewDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.dayArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    SHMenstruationTableViewCell *intervalCell = self.tableView.visibleCells[1];
    intervalCell.rightLabel.text = [NSString stringWithFormat:@"%@天",[self.dayArray objectAtIndex:row]];
    //获取账户信息
    SHAccountHome *accountHome = [SHAccountTool account];
    accountHome.interval = [self.dayArray objectAtIndex:row];
    //存储到沙盒
    [SHAccountTool saveAccount:accountHome];
}


@end
