//
//  SHDiaryTableViewController.m
//  Happiness
//
//  Created by xIang on 16/3/21.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHDiaryTableViewController.h"
#import "SHWriteDiaryViewController.h"
#import "SHDiaryTableViewCell.h"
#import "SHAccountTool.h"
#import "SHDiaryModel.h"
#import "CYAccountTool.h"
#import "CYAccount.h"
#import "SHImageTool.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "CYOtherAccountTool.h"

@interface SHDiaryTableViewController ()
@property(nonatomic, strong)NSMutableDictionary *diaryDic;
@property(nonatomic, strong)NSMutableArray *keyArray;

@end

@implementation SHDiaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    self.tabBarController.tabBar.hidden = YES;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[SHDiaryTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    SHAccountHome *account = [SHAccountTool account];
    self.diaryDic = [NSMutableDictionary dictionaryWithDictionary:account.diaryDic];
    NSArray *keyArr = [self.diaryDic allKeys];
    self.keyArray =  [NSMutableArray arrayWithArray:[keyArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSDiacriticInsensitiveSearch] == NSOrderedAscending;
    }]];
    
    
    [self.tableView reloadData];
}

//设置导航栏
- (void)setNavigationBar{
    self.navigationItem.title = @"日记本";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithOriginalName:@"nav-bar-white-add-btn"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //左键返回
    SHLeftBackButton *backButton = [[SHLeftBackButton alloc] init];
    [backButton setSelfWithImageName:@"nav-bar-white-back-btn" title:@"小幸福"];
    [backButton addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)leftItemAction:(UIBarButtonItem *)leftItem{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightItemAction:(UIBarButtonItem *)rightItem{
    SHWriteDiaryViewController *writeDiaryVC = [[SHWriteDiaryViewController alloc] init];
    [self.navigationController pushViewController:writeDiaryVC animated:YES];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.keyArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = self.keyArray[section];
    NSArray *arr = self.diaryDic[key];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SHDiaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *key = self.keyArray[indexPath.section];
    NSArray *arr = self.diaryDic[key];
    NSDictionary *diaryModelDic = arr[indexPath.row];
    SHDiaryModel *diaryModel = [SHDiaryModel mj_objectWithKeyValues:diaryModelDic];
    CYAccount *cyAccount = [CYAccountTool account];
    SHImageModel *imageModel = [SHImageTool imageModel];
    CYAccount *otherAccount = [CYOtherAccountTool otherAccount];
    if ([diaryModel.myUserName isEqualToString:cyAccount.userName]) {
        if (imageModel.iconImage) {
            cell.iconImageView.image = imageModel.iconImage;
        }else{
            [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:cyAccount.iconURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                imageModel.iconImage = cell.iconImageView.image;
            }];
        }
    }else{
        if (imageModel.otherImage) {
            cell.iconImageView.image = imageModel.otherImage;
        }else{
            [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:otherAccount.iconURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                imageModel.otherImage = cell.iconImageView.image;
            }];
        }
    }
    cell.timeLabel.text = diaryModel.timeStr;
    cell.contentLabel.text = diaryModel.contentStr;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 20)];
    NSString *timeStr = self.keyArray[section];
    timeStr = [NSString stringWithFormat:@"%@年%@月",[timeStr substringToIndex:4],[timeStr substringFromIndex:5]];
    label.text = timeStr;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:14];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SHWriteDiaryViewController *writeDiaryVC = [[SHWriteDiaryViewController alloc] init];
    SHDiaryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    writeDiaryVC.timeStr = cell.timeLabel.text;
    writeDiaryVC.contentStr = cell.contentLabel.text;
    writeDiaryVC.indexRow = indexPath.row;
    [self.navigationController pushViewController:writeDiaryVC animated:YES];
}
@end
