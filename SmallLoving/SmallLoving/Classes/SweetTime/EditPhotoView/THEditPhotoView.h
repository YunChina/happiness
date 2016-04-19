//
//  THEditPhotoView.h
//  WangQiuJia-1-2015
//
//  Created by 王鑫 on 16/3/7.
//  Copyright © 2016年 网球家. All rights reserved.
//要去发送图片的view(0-9张图片的view）

#import <UIKit/UIKit.h>
@class THEditPhotoView;
@protocol THEditPhotoViewDelegate <NSObject>
/**
 *  打开照片库
 */
-(void)editPhotoViewToOpenAblum:(THEditPhotoView *)editView;

@end
@interface THEditPhotoView : UIView
/**
 *  快速创建view
 */
+(id)editPhotoView;

/**
 *  添加一张图片
 */
-(void)addOneImage:(UIImage *)image;
/**
 *  获取editPhoto中的图片数组
 */
-(NSArray *)fetchPhotos;
/**代理*/
@property(assign,nonatomic)id<THEditPhotoViewDelegate>delegate;
@end
