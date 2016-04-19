//
//  SHDiaryView.h
//  SmallLoving
//
//  Created by xIang on 16/4/1.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHDiaryView : UIView
@property(nonatomic, strong)UILabel *timeLabel;
@property(nonatomic, strong)UITextView *contentTextView;
- (void)setupTimeLabel;

@end
