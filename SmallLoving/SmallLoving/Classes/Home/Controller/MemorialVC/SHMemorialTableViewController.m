//
//  SHMemorialTableViewController.m
//  
//
//  Created by xIang on 16/3/21.
//
//

#import "SHMemorialTableViewController.h"
#import "SHHeaderView.h"
#import "SHMemorialTableViewCell.h"
#import "SHAddMemorialTableViewController.h"
#import "SHAccountTool.h"
#import "SHMemorialModel.h"
#import "NSDate+XWBExtension.h"

@interface SHMemorialTableViewController ()
@property(nonatomic, strong)SHHeaderView *headerView;

@end

@implementation SHMemorialTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self.tableView registerClass:[SHMemorialTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    self.tableView.contentInset = UIEdgeInsetsMake(110, 0, 0, 0);
    self.tabBarController.tabBar.hidden = YES;
    SHAccountHome *account = [SHAccountTool account];
    if (!account.memorialArray) {
        SHAddMemorialTableViewController *addMemorialTVC = [[SHAddMemorialTableViewController alloc] init];
        [self.navigationController pushViewController:addMemorialTVC animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.headerView = [[SHHeaderView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, 100)];
    //获得最上面的窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    SHAccountHome *account = [SHAccountTool account];
    if (account.memorialArray) {
        SHMemorialModel *memorialModel = account.memorialArray[0];
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";

        [self.headerView setupHeaderViewLabelWithLoveDate:[formatter dateFromString:memorialModel.memorialDate]];
    }
    [window addSubview:self.headerView];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.headerView removeFromSuperview];
}

//设置导航栏
- (void)setNavigationBar{
    self.navigationItem.title = @"纪念日";
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
    SHAddMemorialTableViewController *addMemorialTVC = [[SHAddMemorialTableViewController alloc] init];
    [self.navigationController pushViewController:addMemorialTVC animated:YES];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SHAccountHome *account = [SHAccountTool account];
    return account.memorialArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SHMemorialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    SHAccountHome *account = [SHAccountTool account];
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";

    if (indexPath.row == 0) {
        UIImage *backgroundImage = [UIImage imageNamed:@"extension-anniversary-cell-bg-pink"];
        CGFloat top = 10; // 顶端盖高度
        CGFloat bottom = 10; // 底端盖高度
        CGFloat left = 20; // 左端盖宽度
        CGFloat right = 120; // 右端盖宽度
        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
        // 指定为拉伸模式，伸缩后重新赋值
        backgroundImage = [backgroundImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        cell.backgroundImageView.image = backgroundImage;
        cell.leftImageView.image = [UIImage imageNamed:@"extension_anniversary-timeline-icon-due"];
        cell.memorialNameLabel.text = @"我们已相爱";
        NSDate *date = [NSDate date];
        SHMemorialModel *memorialModel = account.memorialArray[0];
        NSTimeInterval timeInterval = [date timeIntervalSinceDate:[formatter dateFromString:memorialModel.memorialDate]];
        cell.dayLabel.text = [NSString stringWithFormat:@"%d",(int)(timeInterval/86400)];
    }else{
        UIImage *backgroundImage = [UIImage imageNamed:@"extension-anniversary-cell-bg-blue"];
        CGFloat top = 10; // 顶端盖高度
        CGFloat bottom = 10; // 底端盖高度
        CGFloat left = 20; // 左端盖宽度
        CGFloat right = 120; // 右端盖宽度
        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
        // 指定为拉伸模式，伸缩后重新赋值
        backgroundImage = [backgroundImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        cell.backgroundImageView.image = backgroundImage;
        cell.leftImageView.image = [UIImage imageNamed:@"extension_anniversary-timeline-icon-normal"];
        SHMemorialModel *memorialModel = account.memorialArray[indexPath.row];
        cell.memorialNameLabel.text = [NSString stringWithFormat:@"距离%@还有",memorialModel.memorialName];
        
        cell.dayLabel.text = [[formatter dateFromString:memorialModel.memorialDate] getDaySinceMemorial];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SHAddMemorialTableViewController *addMemorialTVC = [[SHAddMemorialTableViewController alloc] init];
    addMemorialTVC.indexRow = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [self.navigationController pushViewController:addMemorialTVC animated:YES];

}

@end
