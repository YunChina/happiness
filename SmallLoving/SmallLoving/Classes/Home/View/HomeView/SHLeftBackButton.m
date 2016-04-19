//
//  SHLeftBackButton.m
//  Happiness
//
//  Created by xIang on 16/3/21.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHLeftBackButton.h"

@implementation SHLeftBackButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
        
    }
    return self;
}

- (void)setSelfWithImageName:(NSString *)imageName title:(NSString *)title{
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [self sizeToFit];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = self.titleLabel.x - 9;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 68);
}


@end
