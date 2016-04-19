//
//  SHIconView.m
//  Happiness
//
//  Created by xIang on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHIconView.h"

@implementation SHIconView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}

- (UILabel *)sexLabel{
    if (!_sexLabel) {
        _sexLabel = [[UILabel alloc] init];
        [self addSubview:_sexLabel];
    }
    return _sexLabel;
}

- (UIButton *)iconBtn{
    if (!_iconBtn) {
        _iconBtn = [[UIButton alloc] init];
        [self addSubview:_iconBtn];
    }
    return _iconBtn;
}

- (UIImageView *)selectedImageView{
    if (!_selectedImageView) {
        _selectedImageView = [[UIImageView alloc] init];
        [self addSubview:_selectedImageView];
    }
    return _selectedImageView;
}

- (void)allViews{
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kScreenW/2-50, kScreenW/2-50));
    }];
    
    [self.sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.iconBtn.mas_bottom).offset(10);
    }];
    
    [self.selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconBtn);
        make.right.equalTo(self.iconBtn);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    self.selectedImageView.image = [UIImage imageNamed:@"menses-gender-selected"];
    self.selectedImageView.hidden = YES;
}

- (void)setupWithImage:(NSString *)imageName gender:(NSString *)gender{
    [self.iconBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    self.sexLabel.text = gender;
}

@end
