//
//  SHSleepView.h
//  Happiness
//
//  Created by xIang on 16/3/22.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHSleepingView;

@interface SHSleepView : UIView
@property(nonatomic, strong)UIImageView *backgroundImageView;
@property(nonatomic, strong)UIButton *backBtn;
@property(nonatomic, strong)UIButton *wakeBtn;
@property(nonatomic, strong)UILabel *timeLabel;
@property(nonatomic, strong)UILabel *sleepTimeLabel;
@property(nonatomic, strong)SHSleepingView *sleepingView;

- (NSString *)createdSinceNowWithDate:(NSString *)date;
@end
