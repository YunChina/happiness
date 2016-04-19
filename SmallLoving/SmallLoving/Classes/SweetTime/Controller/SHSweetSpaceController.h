//
//  SHSweetSpaceController.h
//  Happiness
//
//  Created by lanou3g on 16/3/17.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHSweetSpaceController : UITableViewController
//顶部视图 图片
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIView *headerContentView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIColor *backColor;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) CGFloat scale;

@end
