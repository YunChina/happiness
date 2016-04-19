//
//  CYAlertController.m
//  SmallLoving
//
//  Created by Cheney on 16/3/23.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "CYAlertController.h"

@interface CYAlertController ()

@end

@implementation CYAlertController

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle isSucceed:(BOOL)succeed {
    CYAlertController * ac = [CYAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    // 如果成功
    if (succeed) {
        [ac succeedAction];
    } else {
        [ac failureAction];
    }
    return ac;
}

+ (instancetype)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle isSucceed:(BOOL)succeed viewController:(UIViewController *)viewController {
    CYAlertController * ac = [CYAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle isSucceed:succeed];
    [viewController presentViewController:ac animated:YES completion:nil];
    return ac;
}

- (void)succeedAction {
    
}

- (void)setAllActions:(NSArray *)allActions {
    _allActions = allActions;
    for (CYAlertAction * action in allActions) {
        [self addAction:action];
    }
    CYAlertAction * action = [CYAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [self addAction:action];
}

- (void)failureAction {
    uint64_t delayInSeconds = 1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
