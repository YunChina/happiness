//
//  SHCoverImageView.m
//  Happiness
//
//  Created by xIang on 16/3/18.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHCoverImageView.h"

@implementation SHCoverImageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}

- (UIButton *)cameraBtn{
    if (!_cameraBtn) {
        _cameraBtn = [[UIButton alloc] init];
        [self addSubview:_cameraBtn];
    }
    return _cameraBtn;
}

- (UIButton *)loveTimeBtn{
    if (!_loveTimeBtn) {
        _loveTimeBtn = [[UIButton alloc] init];
        [self addSubview:_loveTimeBtn];
    }
    return _loveTimeBtn;
}

- (void)allViews{
    //左侧相爱时间btn
    [self.loveTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.bottom.equalTo(self);
    }];
    
    [self.loveTimeBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
//    self.loveTimeBtn.backgroundColor = [UIColor redColor];
    //右侧相机相册btn
    [self.cameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-2);
    }];
    [self.cameraBtn setImage:[UIImage imageNamed:@"dashboard-camera-icon"] forState:UIControlStateNormal];
    self.userInteractionEnabled = YES;
}



@end
