//
//  SHPhotoCollectionViewCell.m
//  SmallLoving
//
//  Created by xIang on 16/3/26.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHPhotoCollectionViewCell.h"

@implementation SHPhotoCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}

- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.photoImageView addSubview:_selectBtn];
    }
    return _selectBtn;
}

- (UIImageView *)photoImageView{
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] init];
        [self addSubview:_photoImageView];
    }
    return _photoImageView;
}

- (void)allViews{
    self.photoImageView.frame = self.bounds;
    //内容模式
    self.photoImageView.contentMode = UIViewContentModeScaleAspectFill;
    //超出边框的内容都剪掉
    self.photoImageView.clipsToBounds = YES;
    self.photoImageView.userInteractionEnabled = YES;
    
    self.selectBtn.frame = CGRectMake(self.width-30, 0, 30, 30);
    [self.selectBtn setImage:[UIImage imageNamed:@"album-select-btn-normal"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"album-select-btn-selected"] forState:UIControlStateSelected];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}
@end
