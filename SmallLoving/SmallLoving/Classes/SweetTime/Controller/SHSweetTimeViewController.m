//
//  SHSweetTimeViewController.m
//  Happiness
//
//  Created by Cheney on 16/3/16.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHSweetTimeViewController.h"
#import "UIImage+SHRoundedRectImage.h"
@interface SHSweetTimeViewController ()
@property (nonatomic,strong)NSArray *data;
@property (nonatomic,strong)UIView *headerView;
@end

@implementation SHSweetTimeViewController
- (NSArray *)data{
    if (_data ==nil) {
        _data = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sweetTime.plist" ofType:nil]];
//        NSLog(@"%@",_data);
    }
    return  _data;
}
- (id)init{
    
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (void)viewDidAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.data[section];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    NSDictionary *dict = self.data[indexPath.section][indexPath.row];
    //设置图片
    UIImage *image = [UIImage imageNamed:dict[@"icon"]];
    cell.imageView.image = image;
    
    //    cell.imageView.image = [UIImage imageNamed:dict[@"icon"]];
    cell.textLabel.text = dict[@"title"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.data[indexPath.section][indexPath.row];
    NSString *classStr = dict[@"vcClass"];
    Class c = NSClassFromString(classStr);
    UIViewController *vc = [[c alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES ];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
@end
