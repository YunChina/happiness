//
//  SHPostMood.m
//  Happiness
//
//  Created by lanou3g on 16/3/24.
//  Copyright © 2016年 Cheney. All rights reserved.
//
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeigh [UIScreen mainScreen].bounds.size.height
#define rectLeftArm CGRectMake(1, 90, 40, 65)
#define rectRightArm CGRectMake(header.frame.size.width / 2 + 60, 90, 40, 65)
#define rectLeftHand CGRectMake(kWidth/ 2 - 100, loginview.frame.origin.y - 22, 40, 40)
#define rectRightHand CGRectMake(kWidth/ 2 + 62, loginview.frame.origin.y - 22, 40, 40)


#define kY self.frame.size.width-40

#import "SHPostMood.h"
@interface SHPostMood()<UITextFieldDelegate,UITextViewDelegate>

@property (assign,nonatomic) ClickType clicktype;

@end

@implementation SHPostMood
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadViews];
            }
    return self;
}


- (void)loadViews{
    


    UIView *loginview=[[UIView alloc]initWithFrame:CGRectMake(15, 20, kWidth-30, 260)];
    loginview.layer.borderWidth=1;
    loginview.layer.borderColor=[UIColor lightGrayColor].CGColor;
    loginview.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    [self addSubview:loginview];
    self.titleField=[[UITextField alloc]initWithFrame:CGRectMake(30, 30, kWidth-90, 44)];
    self.titleField.layer.cornerRadius = 5;
    self.titleField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.titleField.layer.borderWidth=0.7;
    self.titleField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    self.titleField.leftViewMode = UITextFieldViewModeAlways;
    self.titleField.delegate = self ;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    titleLabel.text = @"标题:";
    [self.titleField.leftView addSubview:titleLabel];
    
    [loginview addSubview:self.titleField];
    
    UIImageView* pssimag = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
    pssimag.image = [UIImage imageNamed:@"pass"];
    self.textV.delegate = self ;
    self.textV = [[UITextView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(self.titleField.frame)+30, self.frame.size.width-90, 120)];
    self.textV.textAlignment = NSTextAlignmentLeft ;
    self.textV.backgroundColor =[UIColor colorWithWhite:0.9 alpha:1];
    self.textV.font = [UIFont systemFontOfSize:15.0f];
    self.textV.editable = YES ;
    self.textV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.textV.layer.cornerRadius = 6.0f;
    self.textV.layer.borderWidth = 2;
    self.textV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textV.userInteractionEnabled = YES ;
    [loginview addSubview:self.textV];
    //创建Label 加提示语
    self.promptTitle = [[UILabel alloc]initWithFrame:CGRectMake(5,5,100,20)];
    self.promptTitle.text = @"最多可输入140字";
    self.promptTitle.font = [UIFont systemFontOfSize:12.0];
    [self.promptTitle setTextColor:[UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:0.8]];
    
    self.promptTitle.hidden=NO;
    [self.textV addSubview:self.promptTitle];

}
//点击屏幕任意一处取消键盘的第一响应项
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

@end
