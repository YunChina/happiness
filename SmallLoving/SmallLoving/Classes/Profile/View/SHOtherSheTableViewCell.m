//
//  SHOtherSheTableViewCell.m
//  SmallLoving
//
//  Created by xIang on 16/4/4.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHOtherSheTableViewCell.h"

@implementation SHOtherSheTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self allViews];
    }
    return self;
}



- (void)allViews{
    UIImageView *image2 = [[UIImageView alloc]init];
    image2.frame = CGRectMake(10, 2, 36, 36);
    image2.layer.cornerRadius = 18;
    image2.layer.masksToBounds = YES;
    self.otherImageView = image2;
    [self addSubview:image2];
    UILabel *sheLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 0, 200, 40)];
    sheLabel.text= @"另一半账户";
    [self.contentView addSubview:sheLabel];
}
@end
