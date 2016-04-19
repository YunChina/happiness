//
//  SHHeaderView.h
//  SmallLoving
//
//  Created by xIang on 16/3/31.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHHeaderView : UIView
@property(nonatomic, strong)UIImageView *heartImageView;
@property(nonatomic, strong)UILabel *leftTopLabel;
@property(nonatomic, strong)UILabel *rightLable;

- (void)setupHeaderViewLabelWithLoveDate:(NSDate *)date;
@end
