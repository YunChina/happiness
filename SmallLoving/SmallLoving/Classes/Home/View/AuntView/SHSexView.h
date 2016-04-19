//
//  SHSexView.h
//  Happiness
//
//  Created by xIang on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHIconView;

@interface SHSexView : UIView
@property (nonatomic, strong) UILabel *changeSexLabel;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) SHIconView * manIconView;
@property (nonatomic, strong) SHIconView * womanIconView;
@end
