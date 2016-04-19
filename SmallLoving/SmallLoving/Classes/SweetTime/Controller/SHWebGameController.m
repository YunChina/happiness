//
//  SHWebGameController.m
//  Happiness
//
//  Created by lanou3g on 16/3/17.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHWebGameController.h"

@interface SHWebGameController ()

@end

@implementation SHWebGameController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleStr =self.titleName;
    self.navigationItem.title = self.titleStr;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self layoutViews];
    
}
- (void)viewDidAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES ;
}

- (void)layoutViews{
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    self.url = self.urlStr ;
    NSURL *url = [[NSURL alloc]initWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    //self.webView.scalesPageToFit = YES ;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"退出游戏" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonAction)];
    self.navigationItem.leftBarButtonItem = leftButton ;
}
- (void)leftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
