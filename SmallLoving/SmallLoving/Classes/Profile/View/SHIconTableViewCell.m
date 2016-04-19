//
//  SHIconTableViewCell.m
//  SmallLoving
//
//  Created by xIang on 16/4/4.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHIconTableViewCell.h"

@implementation SHIconTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self allViews];
    }
    return self;
}



- (void)allViews{
    UILabel *labelpic = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, 100, 30)];
    labelpic.text = @"头像";
    self.iconLabel = labelpic;
    [self addSubview:labelpic];
    //自己的头像
    UIImageView *image1 = [[UIImageView alloc] init];
    image1.layer.cornerRadius = 35;
    image1.layer.masksToBounds = YES;
    image1.frame = CGRectMake(kScreenW-100, 5, 70, 70);
    self.iconImageView = image1;
    [self addSubview:image1];
}

@end
