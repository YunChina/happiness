//
//  CYNavigationController.m
//  SmallLoving
//
//  Created by Cheney on 16/3/19.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYNavigationController.h"

@interface CYNavigationController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation CYNavigationController

+ (void)initialize {
    // 获取当前类下所有 item
    UIBarButtonItem * item = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    // 设置导航条按钮的文字颜色
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [item setTitleTextAttributes:dic forState:(UIControlStateNormal)];

    
    //设置不可用状态
    NSMutableDictionary *disableTextAtts = [NSMutableDictionary dictionary];
    //字体颜色
    disableTextAtts[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.8 alpha:0.5];
    [item setTitleTextAttributes:disableTextAtts forState:UIControlStateDisabled];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置 title 的颜色
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // 设置背景
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bar-bg"] forBarMetrics:UIBarMetricsDefault];
    // 给代理赋值
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    // 2. 全屏侧滑返回手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.popDelegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    // 禁用 (其实并没有什么用)
    self.interactivePopGestureRecognizer.enabled = NO;
}

// 开始滑动时执行
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 判断是否根视图控制器
    if (self.viewControllers.count != 1) {
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
