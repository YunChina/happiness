//
//  SHMenstruationFooterView.m
//  Happiness
//
//  Created by xIang on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHMenstruationFooterView.h"

@implementation SHMenstruationFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}

- (UIButton *)firstButton{
    if (!_firstButton) {
        _firstButton = [[UIButton alloc] init];
        [self addSubview:_firstButton];
    }
    return _firstButton;
}

- (UIButton *)secondButton{
    if (!_secondButton) {
        _secondButton = [[UIButton alloc] init];
        [self addSubview:_secondButton];
    }
    return _secondButton;
}

- (void)allViews{
    [self.firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.mas_equalTo(kScreenW - 20);
        make.top.equalTo(self).offset(20);
        make.height.mas_equalTo(30);
    }];
    [self.firstButton setBackgroundImage:[UIImage imageNamed:@"forum-advert-download-btn"] forState:UIControlStateNormal];
    [self.firstButton setTitle:@"保存" forState:UIControlStateNormal];
    
    [self.secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.firstButton.mas_bottom).offset(20);
    }];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"修改性别"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSForegroundColorAttributeName value:SHColorCreater(95, 117, 220, 1) range:strRange];
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [self.secondButton setAttributedTitle:str forState:UIControlStateNormal];
    
    [self.secondButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.secondButton sizeToFit];
}

@end
