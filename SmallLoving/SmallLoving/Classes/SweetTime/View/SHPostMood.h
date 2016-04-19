//
//  SHPostMood.h
//  Happiness
//
//  Created by lanou3g on 16/3/24.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ClickType){
    clicktypeNone,
    clicktypeUser,
    clicktypePass
};

@interface SHPostMood : UIView
@property (nonatomic,strong)UITextField *titleField;

//猫的手
@property (strong,nonatomic) UIImageView *lefthand;
@property (strong,nonatomic) UIImageView *righthand;


//猫的蒙眼胳膊
@property (strong,nonatomic) UIImageView *lefthArm;
@property (strong,nonatomic) UIImageView *rightArm;


//图片布局
@property (nonatomic,strong)UITextView *textV;
@property (nonatomic,strong)UILabel *promptTitle;
//点击猫头部触发动画
@property (nonatomic,strong)UIButton *headButton;
@end
