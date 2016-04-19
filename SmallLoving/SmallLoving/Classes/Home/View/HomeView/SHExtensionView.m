//
//  SHExtensionView.m
//  Happiness
//
//  Created by xIang on 16/3/21.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHExtensionView.h"

@implementation SHExtensionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)label{
    if (!_label){
        _label = [[UILabel alloc] init];
        [self addSubview:_label];
    }
    return _label;
}

- (void)allViews{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.width.height.mas_equalTo(self.width - 30);
    }];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
    }];
    self.label.font = [UIFont systemFontOfSize:13];
}
@end
