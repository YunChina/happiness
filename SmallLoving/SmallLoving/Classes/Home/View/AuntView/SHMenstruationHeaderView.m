//
//  SHMenstruationHeaderView.m
//  Happiness
//
//  Created by xIang on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHMenstruationHeaderView.h"

@implementation SHMenstruationHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}

- (UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        [self addSubview:_backgroundImageView];
    }
    return _backgroundImageView;
}

- (UILabel *)firstLabel{
    if (!_firstLabel) {
        _firstLabel = [[UILabel alloc] init];
        [self addSubview:_firstLabel];
    }
    return _firstLabel;
}

- (UILabel *)secondLabel{
    if (!_secondLabel) {
        _secondLabel = [[UILabel alloc] init];
        [self addSubview:_secondLabel];
    }
    return _secondLabel;
}

- (void)allViews{
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-15);
    }];
    self.firstLabel.font = [UIFont systemFontOfSize:13];
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(15);
    }];
    self.secondLabel.font = [UIFont systemFontOfSize:13];
}

- (void)setupWithBackgroundImageName:(NSString *)imageName firstName:(NSString *)firstName secondName:(NSString *)secondName{
    self.backgroundImageView.image = [UIImage imageNamed:imageName];
    self.firstLabel.text = firstName;
    self.secondLabel.text = secondName;
}

@end
