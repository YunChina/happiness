//
//  SHAboutusViewController.m
//  Happiness
//
//  Created by 云志强 on 16/3/21.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHAboutusViewController.h"
#import "SHLeftBackButton.h"
#import <Masonry.h>

@interface SHAboutusViewController ()
@property(nonatomic,strong)UILabel *labeltitle;
@property(nonatomic,strong)UILabel *label;
@end

@implementation SHAboutusViewController


- (UILabel *)labeltitle{
    if (!_labeltitle) {
        UILabel * label = [UILabel new];
        _labeltitle = label;
        label.text = @"关于我们";
        label.font = [UIFont systemFontOfSize:20];
        [self.view addSubview:label];
    }
    return _labeltitle;
}

- (UILabel *)label{
    if (!_label) {
        UILabel * label = [UILabel new];
        _label = label;
        label.text = @"       小幸福是一个基于情侣关系的对点即时通讯产品,情侣可以通过小幸福进行聊天,私密相册,纪念日,日记本等功能.以此快速增加情侣之间的恩爱程度.\n\n       还可以记录自己的睡眠时间,以及获取两人之间的距离.另外女方可以设置自己的姨妈信息,方便男方知道,并更加贴心的照顾你.精心为您成为好男友提供帮助.\n\n       情侣和情侣之间也可以通过我们的情侣说来进行互动,相当于一个朋友圈.大家可以尽情的去秀你们的幸福啦.\n\n       在平时还可以通过玩一些情侣小游戏来增加生活乐趣.让你在幸福的同时更加快乐\n\n       喜欢小幸福的朋友请给我们五星好评,另外多多推荐给身边的朋友使用哦,让自己幸福的同时,也让周围的人一起幸福";
        label.font = [UIFont systemFontOfSize:15];
        label.numberOfLines = 0;
        [self.view addSubview:label];
    }
    return _label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];

//    self.labeltitle.frame = CGRectMake(10, 10, 140, 40);
    [self.labeltitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(10);
    }];
//    self.label.frame = CGRectMake(20,130 , kScreenW-40, 240);
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labeltitle.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    self.label.numberOfLines = 0;
    //左键返回
    SHLeftBackButton *backButton = [[SHLeftBackButton alloc] init];
    [backButton setSelfWithImageName:@"nav-bar-white-back-btn" title:@" 我      "];
    [backButton addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)leftItemAction:(UIBarButtonItem *)leftItem{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
