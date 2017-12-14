//
//  ZJbtn.m
//  车管家
//
//  Created by linghang on 17/6/10.
//  Copyright © 2017年 zj. All rights reserved.
//

#import "ZJButton.h"

@implementation ZJButton

+ (id)buttonWithFrame:(CGRect)frame Text:(NSString *)text TextColor:(UIColor *)textColor TextAlignment:(NSTextAlignment)textAlignment ImageName:(NSString *)imageName BackgroundColor:(UIColor *)backgroundColor Block:(buttonClick)block {
    
    ZJButton *button = [super buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = backgroundColor;
    button.block = block;
    [button addTarget:button action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.textAlignment = textAlignment;
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    return button;
    
}

- (void)clickButton:(UIButton *)sender {
    
    if (self.block) {
        self.block(sender);
    }
}

@end
