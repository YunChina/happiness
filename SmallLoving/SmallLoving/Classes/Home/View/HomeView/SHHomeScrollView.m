//
//  SHHomeScrollView.m
//  Happiness
//
//  Created by xIang on 16/3/18.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHHomeScrollView.h"
#import "SHCoverImageView.h"


@implementation SHHomeScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}

- (SHCoverImageView *)coverImageView{
    if (!_coverImageView) {
        SHCoverImageView *coverIV = [[SHCoverImageView alloc] init];
        
        _coverImageView = coverIV;
        [self insertSubview:coverIV atIndex:0];
    }
    return _coverImageView;
}

- (UIView *)extensionView{
    if (!_extensionView) {
        _extensionView = [[UIView alloc] init];
        [self addSubview:_extensionView];
    }
    return _extensionView;
}

- (void)allViews{
    //封面
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self);
        make.height.mas_equalTo(kScreenH/2.5);
        make.width.mas_equalTo(kScreenW);
    }];
    
    //内容模式
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    //超出边框的内容都剪掉
    self.coverImageView.clipsToBounds = YES;
    
    

    
    //扩展功能
    [self.extensionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.coverImageView.mas_bottom);
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(kScreenH - kScreenH/2.5 - 64 - 49);
        make.width.mas_equalTo(kScreenW);
    }];
    
}

@end
