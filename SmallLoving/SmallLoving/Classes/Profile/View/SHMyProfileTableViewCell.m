//
//  SHMyProfileTableViewCell.m
//  SmallLoving
//
//  Created by xIang on 16/4/4.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHMyProfileTableViewCell.h"

@implementation SHMyProfileTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self allViews];
    }
    return self;
}



- (void)allViews{
    self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 70, 70)];
    self.iconImage.layer.cornerRadius = 35;
    self.iconImage.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImage];
    
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 7, kScreenW-120, 40)];
    nameLabel.font = [UIFont boldSystemFontOfSize:22.0];
    self.nickNameLabel = nameLabel;
    [self addSubview:nameLabel];
    
    UILabel *happinessnumber = [[UILabel alloc]initWithFrame:CGRectMake(100, 45, kScreenW - 100, 30)];
    happinessnumber.font = [UIFont boldSystemFontOfSize:14.0];
    self.loveNumLabel = happinessnumber;
    [self addSubview:happinessnumber];
    
}
@end
