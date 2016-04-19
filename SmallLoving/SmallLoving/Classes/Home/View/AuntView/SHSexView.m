//
//  SHSexView.m
//  Happiness
//
//  Created by xIang on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHSexView.h"
#import "SHIconView.h"

@implementation SHSexView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}

- (UILabel *)changeSexLabel{
    if (!_changeSexLabel) {
        _changeSexLabel = [[UILabel alloc] init];
        [self addSubview:_changeSexLabel];
    }
    return _changeSexLabel;
}

- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_confirmBtn];
    }
    return _confirmBtn;
}

- (SHIconView *)manIconView{
    if (!_manIconView) {
        _manIconView = [[SHIconView alloc] init];
        [self addSubview:_manIconView];
    }
    return _manIconView;
}

- (SHIconView *)womanIconView{
    if (!_womanIconView) {
        _womanIconView = [[SHIconView alloc] init];
        [self addSubview:_womanIconView];
    }
    return _womanIconView;
}


- (void)allViews{
    self.backgroundColor = SHColorCreater(251, 232, 243, 1);
    [self.changeSexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(60);
    }];
    self.changeSexLabel.text = @"请选择你的性别";
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.manIconView.mas_bottom).offset(50);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    [self.confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];

    [self.confirmBtn setBackgroundImage:[UIImage imageNamed:@"album-delete-btn"] forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    
    [self.manIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.equalTo(self.changeSexLabel.mas_bottom).offset(50);
        make.size.mas_equalTo(CGSizeMake(kScreenW/2-50, kScreenW/2));
    }];
    [self.manIconView setupWithImage:@"menses-gender-man" gender:@"男"];
    
    [self.womanIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-30);
        make.top.equalTo(self.changeSexLabel.mas_bottom).offset(50);
        make.size.mas_equalTo(CGSizeMake(kScreenW/2-50, kScreenW/2));
    }];
    [self.womanIconView setupWithImage:@"menses-gender-woman" gender:@"女"];
     
}



@end
