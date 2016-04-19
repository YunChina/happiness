//
//  SHSweetGameController.m
//  Happiness
//
//  Created by lanou3g on 16/3/17.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHSweetGameController.h"
#import "SHSweetGameCell.h"
#import "SHWebGameController.h"
#import "UIImage+SHRoundedRectImage.h"
@interface SHSweetGameController ()
@property (nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)NSMutableDictionary *dic;
@end

@implementation SHSweetGameController
- (NSArray *)dataArr{
    
    if (_dataArr ==nil) {
        _dataArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sweetGame.plist" ofType:nil]];
    }
    return _dataArr;
}
- (id)init{
    
    if (self =[super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"情侣游戏";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bar-bg"] forBarMetrics:UIBarMetricsDefault];
    //    [self.tableView registerClass:[SHSweetGameCell class] forCellReuseIdentifier:@"aaaaaa"];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction)];
    self.navigationItem.leftBarButtonItem = leftItem ;
    [self.tableView registerNib:[UINib nibWithNibName:@"SHSweetGameCell" bundle:nil] forCellReuseIdentifier:@"aaaaaa"];
    [self.tableView reloadData];
    
}
- (void)leftItemAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES ;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.dataArr[section];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SHSweetGameCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"aaaaaa" forIndexPath:indexPath ];
    self.dic = self.dataArr[indexPath.section][indexPath.row];
    //设置图形为圆角
    UIImage *image = [UIImage imageNamed:self.dic[@"icon"]];
    CGSize size = CGSizeMake(75, 70);
    cell.imageV.image = [UIImage createRoundedRectImage:image size:size radius:10];
    cell.titleLabel.text = self.dic[@"title"];
    cell.smstitle.text = self.dic[@"smstitle"];
    [cell.beginBtn addTarget:self action:@selector(beginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selected = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



-(void)beginBtnAction:(UIButton *)btn
{
    
//    NSLog(@"MyRow:%ld",[self.tableView indexPathForCell:((SHSweetGameCell *)[[btn superview]superview])].row);
    SHWebGameController *webGame = [[SHWebGameController alloc]init];
    self.dic = self.dataArr[[self.tableView indexPathForCell:((SHSweetGameCell *)[[btn   superview]superview])].section][[self.tableView indexPathForCell:((SHSweetGameCell *)[[btn   superview]superview])].row];
    webGame.urlStr = self.dic[@"url"];
    webGame.titleName = self.dic[@"title"];
    [self.navigationController pushViewController:webGame animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *str = @"网页游戏(免安装)";
    return str;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

@end
