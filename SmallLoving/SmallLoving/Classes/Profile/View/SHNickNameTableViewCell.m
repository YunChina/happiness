//
//  SHNickNameTableViewCell.m
//  SmallLoving
//
//  Created by xIang on 16/4/4.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHNickNameTableViewCell.h"

@implementation SHNickNameTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self allViews];
    }
    return self;
}



- (void)allViews{
    UILabel *labelname = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
    labelname.text = @"昵称";
    [self addSubview:labelname];
    self.nameLabel = labelname;
    //自己的昵称
    UILabel *labelnamenew = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW-230, 5, 200, 30)];
    labelnamenew.textAlignment = NSTextAlignmentRight;
    self.nickNameLabel = labelnamenew;
    [self addSubview:labelnamenew];
}
@end
