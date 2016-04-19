//
//  SHNumController.m
//  Happiness
//
//  Created by 云志强 on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHNumController.h"
#import "SHLeftBackButton.h"
@interface SHNumController ()
@property(nonatomic,strong)UITextField *textfield;
@property(nonatomic,strong)UIButton *buttonconserve;
@end

@implementation SHNumController

-(UIButton *)buttonconserve{
    if(!_buttonconserve){
        UIButton *btn = [UIButton new];
        _buttonconserve = btn;
        [btn addTarget:self action:@selector(ConserveAction) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"保存" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"forum-advert-download-btn"] forState:(UIControlStateNormal)];
        [self.view addSubview:btn];
    }
    return _buttonconserve;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"昵称";
    UITextField *textfiled = [[UITextField alloc]initWithFrame:CGRectMake(0, 30, kScreenW, 40)];
    textfiled.placeholder = @"请输入另一半对你的称呼";
    textfiled.borderStyle = UITextBorderStyleRoundedRect;
    textfiled.clearButtonMode = UITextFieldViewModeAlways;
    textfiled.text = @"还是测试";
    [self.view addSubview:textfiled];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 80, kScreenW-40, 60)];
    label.text = @"恩爱号只能修改一次,可以使用6~20个数字";
    label.numberOfLines = 0;
    label.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:label];
    
    self.buttonconserve.frame = CGRectMake(kScreenW-(kScreenW-30), 150, kScreenW-60, 40);
    
    //左键返回
    SHLeftBackButton *backButton = [[SHLeftBackButton alloc] init];
    [backButton setSelfWithImageName:@"nav-bar-white-back-btn" title:@"返回   "];
    [backButton addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)leftItemAction:(UIBarButtonItem *)leftItem{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ConserveAction{
    //保存
}
@end
