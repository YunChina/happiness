//
//  SHIconView.h
//  Happiness
//
//  Created by xIang on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHIconView : UIView
@property (nonatomic, strong) UIButton * iconBtn;
@property (nonatomic, strong) UILabel * sexLabel;
@property (nonatomic, strong) UIImageView * selectedImageView;

//设置属性
- (void)setupWithImage:(NSString *)imageName gender:(NSString *)gender;
@end
