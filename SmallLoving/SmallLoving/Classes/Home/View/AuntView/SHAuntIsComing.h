//
//  SHAuntIsComing.h
//  Happiness
//
//  Created by xIang on 16/3/24.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHAccountHome;

@interface SHAuntIsComing : UIView
//姨妈巾背景图
@property (nonatomic, strong) UIImageView * auntTowelImageView;
//恭迎姨妈大驾光临背景图
@property (nonatomic, strong) UIImageView * auntComeImageView;
//姨妈巾上方Label
@property (nonatomic, strong) UILabel * auntTowelFirstLabel;
//姨妈巾下方Label
@property (nonatomic, strong) UILabel * auntTowelSecondLabel;
//男性提示Label
@property (nonatomic, strong) UILabel * manLabel;
//女性点击btn
@property (nonatomic, strong) UIButton * womanBtn;

- (void)setupViewWithAccountHome:(SHAccountHome *)accountHome;

//设置月经差多久到来
- (void)setupAuntTowelSecondLabelWithAccountHome:(SHAccountHome *)accountHome;

@end
