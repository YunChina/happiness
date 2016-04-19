//
//  SHSweetSpaceController.m
//  Happiness
//
//  Created by lanou3g on 16/3/17.
//  Copyright © 2016年 Cheney. All rights reserved.


#import "SHSweetSpaceController.h"
#import "SHSpaceCell.h"
#import "SHPostMoodController.h"
#import "CYAccountTool.h"
#import "CYAccount.h"
#import <UIImageView+WebCache.h>
#import "SHImageTool.h"
#import <MJRefresh.h>

#define kScreenWith [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface SHSweetSpaceController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)NSMutableArray *spaceArray;

@end

@implementation SHSweetSpaceController
- (NSMutableArray *)spaceArray{
    if (!_spaceArray) {
        _spaceArray = [NSMutableArray array];
    }
    return _spaceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
    UIView *llview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kScreenHeight*0.33+20)];
    //背景图片
    self.headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, kScreenHeight*0.33)];
    self.headerImageView.image = [UIImage imageNamed:@"image0.png"];
    
    UIView *contentView = [[UIView alloc]initWithFrame:self.headerImageView.bounds];
    self.headerImageView.center = contentView.center ;
    contentView.layer.masksToBounds = YES ;
    self.headerContentView = contentView;
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.headerContentView.bounds.size.height-30, kScreenWith-76, 30)];
    CYAccount *cyAccount = [CYAccountTool account];
    
    //调用数据库/leancloud中用户名称
    self.label.text = cyAccount.nickName;
    self.label.textAlignment = NSTextAlignmentRight;
    self.label.textColor = [UIColor brownColor];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.font = [UIFont boldSystemFontOfSize:18];
    [llview addSubview:self.label];
    //信息内容
    CGRect icon_frame = CGRectMake([UIScreen mainScreen].bounds.size.width-70, self.headerContentView.bounds.size.height-40, 60, 60);

    UIImageView *icon = [[UIImageView alloc] initWithFrame:icon_frame];
    icon.backgroundColor = [UIColor clearColor];
    
    //调用用户图片
    SHImageModel *imageModel = [SHImageTool imageModel];
    if (imageModel.iconImage) {
        icon.image = imageModel.iconImage;
    }else{
        [icon sd_setImageWithURL:[NSURL URLWithString:cyAccount.iconURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            imageModel.iconImage = icon.image;
            [SHImageTool saveImageModel:imageModel];
        }];
    }
    
    icon.layer.masksToBounds = YES;
    icon.layer.borderWidth = 3.0f;
    icon.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.headerContentView addSubview:self.headerImageView];
    [llview addSubview:icon];
    self.icon = icon;
    [llview addSubview:self.headerContentView];
    [llview bringSubviewToFront:self.label];
    [llview bringSubviewToFront:icon];
    llview.layer.borderColor = [UIColor redColor].CGColor;
    self.tableView.tableHeaderView = llview;
    self. tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO ;
    self.navigationController.navigationBar.translucent = NO;
    
    //注册cell
    [self.tableView registerClass:[SHSpaceCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    //下拉刷新
    [self setupDownRefresh];
    //上拉加载
    [self setupUpRefresh];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset_Y = scrollView.contentOffset.y;
    CGFloat alpha = (offset_Y + 40)/300.0f;
    self.backView.backgroundColor = [self.backColor colorWithAlphaComponent:alpha];
    if (offset_Y <0) {
        //放大比例
        CGFloat add_topHeight = -offset_Y;
        self.scale = (kScreenHeight*0.33+add_topHeight)/(kScreenHeight*0.33);
        //改变 frame
        CGRect contentView_frame = CGRectMake(0, -add_topHeight, kScreenWith, kScreenHeight*0.33+add_topHeight);
        self.headerContentView.frame = contentView_frame;
        CGRect imageView_frame = CGRectMake(-(kScreenWith*self.scale-kScreenWith)/2.0f,
                                            0,
                                            kScreenWith*self.scale,
                                            kScreenHeight*0.33+add_topHeight);
        self.headerImageView.frame = imageView_frame;

    
       CGRect icon_frame = CGRectMake([UIScreen mainScreen].bounds.size.width-70, (self.headerContentView.bounds.size.height-40)-add_topHeight, 60, 60);
        self.icon.frame = icon_frame;
       CGRect label_frame = CGRectMake(0, self.headerContentView.bounds.size.height-30-add_topHeight, kScreenWith-76, 30);
        self.label.frame =label_frame;
    }
    
}

- (void)layoutViews{
    
    self.navigationItem.title = @"情侣空间";
    self.tabBarController.tabBar.hidden = YES ;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bar-bg"] forBarMetrics:UIBarMetricsDefault];
    [self.tableView reloadData];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发布心情" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
    self.navigationItem.rightBarButtonItem = rightItem ;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction)];
    self.navigationItem.leftBarButtonItem = leftItem ;
    
}

- (void)rightItemAction{
    //获取数据
    SHPostMoodController *postMood = [[SHPostMoodController alloc]init];
    
    [self.navigationController pushViewController:postMood animated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupDownRefresh];
    
}


//下拉刷新
- (void)setupDownRefresh{
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshStateChangeDown)];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    //添加刷新控件
    self.tableView.mj_header = header;
    //马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}

- (void)refreshStateChangeDown{
    
    AVQuery *query = [AVQuery queryWithClassName:@"SweetTime"];
    if (self.spaceArray.count > 0) {
        AVObject *objAV = self.spaceArray.firstObject;
        NSDate *createdDate = [objAV objectForKey:@"createdAt"];
        [query whereKey:@"createdAt" greaterThan:createdDate];
    }
    [query orderByDescending:@"createdAt"];
    query.limit = 10; // 最多返回 10 条结果
    __weak typeof(self) weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSRange range = NSMakeRange(0, objects.count);
            NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
            [weakSelf.spaceArray insertObjects:objects atIndexes:set];
        }
        //结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
    }];
}

//上拉加载
- (void)setupUpRefresh{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshStateChangeUp)];
}

- (void)refreshStateChangeUp{
    if (self.spaceArray.count == 0) {
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    AVQuery *query = [AVQuery queryWithClassName:@"SweetTime"];
    NSDate *createdDate = [self.spaceArray.lastObject objectForKey:@"createdAt"];
    [query whereKey:@"createdAt" lessThan:createdDate];
    [query orderByDescending:@"createdAt"];
    query.limit = 10; // 最多返回 10 条结果
    __weak typeof(self) weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [weakSelf.spaceArray addObjectsFromArray:objects];
        }
        [weakSelf.tableView reloadData];
        //结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];

}






- (void)leftItemAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (id)init{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.spaceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AVObject *obj = self.spaceArray[indexPath.row];
    NSString *titleString = [obj objectForKey:@"titleString"];//标题
    NSString *textString = [obj objectForKey:@"textString"];//内容
    NSString *iconURL = [obj objectForKey:@"iconURL"];//头像
    NSString *nickName = [obj objectForKey:@"nickName"];//昵称
    NSString *timestamp = [obj objectForKey:@"timestamp"];//时间

    //1.创建cell
    SHSpaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:iconURL]];
    cell.nameView.text = nickName;
    cell.titleView.text = titleString;
    cell.textView.text = textString;
    cell.dateView.text = timestamp;
    
    //必须的
    cell.backgroundColor = [UIColor colorWithRed:(255)
                                           green:(255)  blue:(255) alpha:.4];
    cell.selected = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //3.返回cell
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AVObject *obj = self.spaceArray[indexPath.row];
    NSString *textString = [obj objectForKey:@"textString"];//内容
    CGFloat height = [SHSpaceCell heithtForLabelText:textString];
    return height + 135;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
} 
@end
