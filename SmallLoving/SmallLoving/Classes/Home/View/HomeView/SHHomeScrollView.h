//
//  SHHomeScrollView.h
//  Happiness
//
//  Created by xIang on 16/3/18.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHCoverImageView;

@interface SHHomeScrollView : UIView

//封面
@property(nonatomic, strong)SHCoverImageView *coverImageView;

//扩展功能
@property(nonatomic, strong)UIView *extensionView;
@end
