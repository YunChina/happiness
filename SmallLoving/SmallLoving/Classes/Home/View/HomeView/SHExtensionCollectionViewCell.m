//
//  SHExtensionCollectionViewCell.m
//  Happiness
//
//  Created by xIang on 16/3/19.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHExtensionCollectionViewCell.h"
#import "SHExtensionView.h"

@implementation SHExtensionCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}

- (void)allViews{
    //实例化属性imageView (和item的内容视图等大)
    self.extensionView = [[SHExtensionView alloc] initWithFrame:self.contentView.bounds];
     
    //添加到contentView上
    [self.contentView addSubview:self.extensionView];
}

//布局改变时会执行的方法
- (void)layoutSubviews{
    [super layoutSubviews];
    self.extensionView.frame = self.contentView.bounds;
}
@end
