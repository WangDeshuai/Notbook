//
//  AddView.h
//  Notepad
//
//  Created by feijiu_1 on 2017/12/8.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddView : UIView
-(id)init;
@property(nonatomic,copy)void(^blockBtn)(int tag);
@end
