//
//  CYTabBarButton.m
//  SmallLoving
//
//  Created by Cheney on 16/3/25.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYTabBarButton.h"

#define CYImageRidio 0.7


@implementation CYTabBarButton

// 重写 setHighlighted 来取消高亮做的事情
- (void)setHighlighted:(BOOL)highlighted {}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 设置字体颜色
        [self setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [self setTitleColor:[UIColor blueColor] forState:(UIControlStateSelected)];
        // 图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 设置文字字体
        self.titleLabel.font = [UIFont systemFontOfSize:10];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 1.imageView
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.cy_width;
    CGFloat imageH = self.cy_height * CYImageRidio;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    // 2.title
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 5;
    CGFloat titleW = self.cy_width;
    CGFloat titleH = self.cy_height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
}

@end
