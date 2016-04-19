//
//  SHPhotoCollectionViewCell.h
//  SmallLoving
//
//  Created by xIang on 16/3/26.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    //右上角编辑按钮的两种状态;
    //正常的状态，按钮显示“编辑”;
    NormalState,
    //正在删除时候的状态，按钮显示“完成”;
    DeleteState
}CellState;

@interface SHPhotoCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView * photoImageView;
@property (nonatomic, strong) UIButton * selectBtn;
@end
