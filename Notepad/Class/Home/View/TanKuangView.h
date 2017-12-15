//
//  TanKuangView.h
//  Notepad
//
//  Created by Mac on 2017/12/15.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TanKuangView : UIView
-(id)initWithArray:(NSArray*)array;
@property(nonatomic,copy)void(^Block)(NSInteger tagg);
-(void)show;
-(void)dissmiss;
@end
