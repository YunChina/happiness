//
//  SHMenstruationHeaderView.h
//  Happiness
//
//  Created by xIang on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHMenstruationHeaderView : UIView
@property (nonatomic, strong) UIImageView * backgroundImageView;
@property (nonatomic, strong) UILabel * firstLabel;
@property (nonatomic, strong) UILabel * secondLabel;

- (void)setupWithBackgroundImageName:(NSString *)imageName firstName:(NSString *)firstName secondName:(NSString *)secondName;
@end
