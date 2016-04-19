//
//  SHSleepingView.m
//  Happiness
//
//  Created by xIang on 16/3/22.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHSleepingView.h"

@implementation SHSleepingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}

- (UIImageView *)sleepingImageView{
    if (!_sleepingImageView) {
        _sleepingImageView = [[UIImageView alloc] init];
        [self addSubview:_sleepingImageView];
    }
    return _sleepingImageView;
}

- (UIImageView *)bubbleImageView{
    if (!_bubbleImageView) {
        _bubbleImageView = [[UIImageView alloc] init];
        [self.sleepingImageView addSubview:_bubbleImageView];
    }
    return _bubbleImageView;
}

- (void)allViews{
    [self.sleepingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.sleepingImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.sleepingImageView.image = [UIImage imageNamed:@"sleep_people"];
    [self.bubbleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.bubbleImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addImageAnmation];
}

#pragma mark----添加多张图片
- (void)addImageAnmation{
    //设置图片
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        //array 添加图片
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"sleep_bubble_0%d",i+1]];
        [array addObject:image];
    }
    for (int i = 5; i > 0; i--) {
        //array 添加图片
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"sleep_bubble_0%d",i]];
        [array addObject:image];
    }
    self.bubbleImageView.animationImages = array;
    //设置动画时长
        self.bubbleImageView.animationDuration = 1.5;
    //动画循环次数
    //    self.imageView.animationRepeatCount = 1;
    //开始动画
    [self.bubbleImageView startAnimating];
}

@end
