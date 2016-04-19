//
//  CYTabBar.m
//  SmallLoving
//
//  Created by Cheney on 16/3/25.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYTabBar.h"
#import "CYTabBarButton.h"

@interface CYTabBar ()

@end

@implementation CYTabBar

- (CYTabBarButton *)barBtn {
    if (!_barBtn) {
        CYTabBarButton * btn = [[CYTabBarButton alloc]init];
        _barBtn = btn;
        [btn setTitle:@"聊天" forState:(UIControlStateNormal)];
        [btn setImage:[UIImage imageNamed:@"tab-bar-chat-icon-normal"] forState:(UIControlStateNormal)];
        [self addSubview:btn];
    }
    return _barBtn;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    // 调整系统 tabBar 的位置
    CGFloat w = self.cy_width;
    CGFloat h = self.cy_height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w / (self.items.count + 1);
    CGFloat btnH = h;
    int i = 0;
    CGSize size = CGSizeZero;
    for (UIView * tabBarBt in self.subviews) {
        if ([tabBarBt isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == 2) {
                i = 3;
            }
            btnX = btnW * i;
            tabBarBt.frame = CGRectMake(btnX, btnY, btnW, btnH);
            size = tabBarBt.cy_size;
            i++;
        }
        self.barBtn.cy_size = size;
        self.barBtn.center = CGPointMake(w / 2, h / 2);
    }
}


@end
