//
//  SHSpaceCell.h
//  Happiness
//
//  Created by lanou3g on 16/3/19.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHSpaceCell : UITableViewCell
//1.头像
@property (nonatomic,weak)UIImageView *iconView;
//2.昵称
@property (nonatomic,weak)UILabel *nameView;

//4.标题
@property (nonatomic,weak)UILabel *titleView;
//5.正文
@property (nonatomic,weak)UILabel *textView;

//7.cell之间的分割线
@property (nonatomic,strong)UIView *cellView;
//8.日期
@property (nonatomic,strong)UILabel *dateView;
+ (CGFloat)heithtForLabelText:(NSString *)text;
@end
