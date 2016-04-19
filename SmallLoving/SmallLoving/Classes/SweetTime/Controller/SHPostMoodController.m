//
//  SHPostMoodController.m
//  Happiness
//
//  Created by lanou3g on 16/3/21.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#define CWScreenW  [UIScreen mainScreen].bounds.size.width
#define kY self.view.frame.size.width-40
#import "SHPostMoodController.h"
#import "SHPostMood.h"
#import <AVObject.h>
#import "CYAccountTool.h"
#import "CYAccount.h"
@interface SHPostMoodController ()<UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong)SHPostMood *postMood;


@end
@interface SHPostMoodController ()


@end

@implementation SHPostMoodController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.postMood = [[SHPostMood alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.postMood ;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"书写心情";
    [self layoutView];
    self.postMood.headButton.userInteractionEnabled =YES ;
    self.postMood.textV.delegate = self;
    self.postMood.titleField.delegate = self;

}

- (void)viewDidAppear:(BOOL)animated{
    [self.postMood.titleField becomeFirstResponder];
}

- (void)layoutView{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bar-bg"] forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:  @selector(cancleBtnClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:  @selector(rightBtnClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}
//textView开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.postMood.promptTitle.hidden = YES;

}


- (void)rightBtnClick{
    if(self.postMood.titleField.text.length ==0 &&self.postMood.textV.text.length == 0){
        //弹框显示
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提醒" message:@"请先输入心情内容" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
            
            [self.postMood.titleField becomeFirstResponder];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"稍后发布" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action){
            [self.postMood.titleField resignFirstResponder];
            [self.postMood.textV resignFirstResponder];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [self showDetailViewController:alert sender:nil];
    }else{

        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
        
         self.titleString = self.postMood.titleField.text;

        
        
        self.textString = self.postMood.textV.text;
        
        NSString *timestamp = [formatter stringFromDate:date];
        CYAccount *cyAccount = [CYAccountTool account];
        
        //上传到云端
        AVObject *moodAV = [[AVObject alloc] initWithClassName:@"SweetTime"];// 构建对象
        [moodAV setObject:self.titleString forKey:@"titleString"];// 标题
        [moodAV setObject:self.textString forKey:@"textString"];// 内容
        [moodAV setObject:cyAccount.iconURL forKey:@"iconURL"]; //头像
        [moodAV setObject:cyAccount.nickName forKey:@"nickName"]; //昵称
        [moodAV setObject:timestamp forKey:@"timestamp"];//时间
        [moodAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                CYLog(@"心情存储成功");
            }
        }];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)cancleBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view resignFirstResponder];
    return YES;
}
/*
 **监听点击事件，当点击非textfiled位置的时候，所有输入法全部收缩
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

//判断是否超出最大限额 140
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@""] && range.length > 0) {
        //删除字符肯定是安全的
        return YES;
    }
    else {
        if (self.postMood.textV.text.length - range.length + text.length > 140) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"超出最大可输入长度" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return NO;
        }else {
            return YES;
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.postMood.titleField == textField)
    {
        if ([toBeString length] > 20) {
            textField.text = [toBeString substringToIndex:20];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"超过最大字数不能输入了" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            return NO;
        }
    }
    return YES;
}
////视图上移的方法
//- (void)animateTextView:(UITextView *)textView up:(BOOL)up{
//    if (self.view.frame.size.height ==548&&self.view.frame.size.width==320) {
//        NSLog(@"abcdefghij");
//    }
//        //设置视图上移的距离，单位像素
//       const int movementDistance = 80;
//        //三目运算，判定是否需要上移视图或者不变
//        int movement = (up ? -movementDistance : movementDistance);
//        //设置动画的名字
//        [UIView beginAnimations:@"Animation" context:nil];
//        //设置动画的开始移动位置
//        [UIView setAnimationBeginsFromCurrentState: YES];
//        //设置动画的间隔时间
//        [UIView setAnimationDuration: 0.20];
//        //设置视图移动的位移
//        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
//        //设置动画结束
//        [UIView commitAnimations];
//    
//}
@end
