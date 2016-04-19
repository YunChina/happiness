//
//  SHAlbumToolBarView.m
//  SmallLoving
//
//  Created by xIang on 16/3/28.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHAlbumToolBarView.h"

@implementation SHAlbumToolBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [self addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] init];
        [self addSubview:_deleteBtn];
    }
    return _deleteBtn;
}

- (void)allViews{
    self.image = [UIImage imageNamed:@"album-editing-bar-bg"];
    self.userInteractionEnabled = YES;
    //取消按钮
    self.cancelBtn.frame = CGRectMake(10, 10, kScreenW/2-15, 44-20);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setBackgroundImage:[UIImage imageNamed:@"album-gray-border-btn"] forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:SHColorCreater(106, 111, 115, 1) forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    //删除按钮
    self.deleteBtn.frame = CGRectMake(kScreenW/2+5, 10, kScreenW/2-15, 44-20);
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateDisabled];
    [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"album-delete-btn-disabled"] forState:UIControlStateDisabled];
    [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"album-delete-btn"] forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[UIColor colorWithWhite:0.9 alpha:1] forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
}

@end
