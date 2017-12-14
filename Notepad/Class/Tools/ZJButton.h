//
//  ZJbtn.h
//  车管家
//
//  Created by linghang on 17/6/10.
//  Copyright © 2017年 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonClick)(UIButton *sender);

@interface ZJButton : UIButton

@property (nonatomic, strong) buttonClick block;

/**
 @param frame 按钮的位置
 @param text 按钮的标题文字
 @param textColor 按钮文字的颜色
 @param textAlignment 按钮标题的对齐方式
 @param imageName 按钮图片
 @param backgroundColor 按钮的背景颜色
 @param block 回调
 */
+ (id)buttonWithFrame:(CGRect)frame Text:(NSString *)text TextColor:(UIColor *)textColor TextAlignment:(NSTextAlignment)textAlignment ImageName:(NSString *)imageName BackgroundColor:(UIColor *)backgroundColor Block:(buttonClick)block;

@end
