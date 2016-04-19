//
//  SHSpaceCell.m
//  Happiness
//
//  Created by lanou3g on 16/3/19.
//  Copyright © 2016年 Cheney. All rights reserved.
//
#define kNameFont [UIFont boldSystemFontOfSize:15]
#define kTextFont [UIFont systemFontOfSize:14]
#import "SHSpaceCell.h"
#import <Masonry.h>

@implementation SHSpaceCell

//构造方法(在初始化对象的时候被调用)
//一般在这里添加子控件 ,只添加控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1.头像
        UIImageView *iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        //2.昵称
        UILabel *nameView = [[UILabel alloc]init];
        nameView.font = kNameFont;
        [self.contentView addSubview:nameView];
        self.nameView = nameView;

        //4.标题
        UILabel *titleView = [[UILabel alloc]init];
        [self.contentView addSubview:titleView];
        self.titleView = titleView;
        //5.正文
        UILabel *textView = [[UILabel alloc]init];
        textView.numberOfLines =0;
        textView.font = kTextFont;
        [self.contentView addSubview:textView];
        self.textView = textView ;
        //7.cell之间的分割线
        UIView *cellView = [[UIView alloc]init];
        [self.contentView addSubview:cellView];
        self.cellView = cellView;
        //date
        UILabel *dateView = [[UILabel alloc]init];
        [self.contentView addSubview:dateView];
        self.dateView = dateView;
        
        [self allViews];
    }
    return self;
}

- (void)allViews{
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    self.iconView.layer.cornerRadius = 25;
    self.iconView.layer.masksToBounds = YES;
    
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconView);
        make.left.equalTo(self.iconView.mas_right).offset(10);
    }];
    self.nameView.font = [UIFont systemFontOfSize:20];
    
    [self.dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).offset(5);
        make.left.equalTo(self.iconView);
    }];
    self.dateView.font = [UIFont systemFontOfSize:12];
    self.dateView.textColor = [UIColor colorWithWhite:.6 alpha:1];

    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.dateView.mas_bottom).offset(10);
    }];
    self.titleView.font = [UIFont systemFontOfSize:20];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom).offset(10);
        make.left.equalTo(self.titleView);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    self.textView.numberOfLines = 0;
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    
    [self.cellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(10);
        make.left.equalTo(self.textView);
        make.size.mas_equalTo(CGSizeMake(kScreenW-20,1));
    }];
    self.cellView.backgroundColor = SHColorCreater(231, 138, 157, 1);
}

+ (CGFloat)heithtForLabelText:(NSString *)text{
    //设置文本自适应高度
    //size:设置自适应矩形框的size
    //options:配置属性
    //attributes配置文本相关的信息
    //context:内容属性
    //注意:设置的相关属性 和 显示控件的相关属性的设置保持一致
    CGSize size = CGSizeMake(kScreenW-20, 1000);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}


@end
