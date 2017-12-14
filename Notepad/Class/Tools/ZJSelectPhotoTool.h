//
//  ZJSelectPhotoTool.h
//  车管家
//
//  Created by linghang on 17/6/10.
//  Copyright © 2017年 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 用于回传图片的block
 */
typedef void(^backPhotoBlock)(UIImage *image);

@interface ZJSelectPhotoTool : NSObject

/**
 1. 用来跳转界面的视图控制器
 */
@property (strong, nonatomic) UIViewController *controller;

/**
 2. 指针block
 */
@property (strong, nonatomic) backPhotoBlock pointBlock;
/**
 3. 是否是头像
 */
@property (assign, nonatomic) BOOL isIcon;

#pragma mark - 展示选择图片的工具类方法
+ (void)showSeletPhotoWith:(UIViewController *)controller NamesArray:(NSArray *)titlesArray IsEditing:(BOOL)isEditing BackImageBlock:(backPhotoBlock)block IsIcon:(BOOL)isIcon;

@end
