//
//  TanKuangView.m
//  Notepad
//
//  Created by Mac on 2017/12/15.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "TanKuangView.h"

@implementation TanKuangView

-(id)initWithArray:(NSArray*)array{
    self=[super init];
    if (self) {
        self.layer.cornerRadius=5;
        self.clipsToBounds=YES;
        self.backgroundColor=[UIColor whiteColor];
        self.frame=CGRectMake(ScreenWidth-160-30,64, 160, 100);
        for (int i =0; i<array.count; i++) {
            UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
            [self sd_addSubviews:@[btn]];
            btn.tag=i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:array[i] forState:0];
            [btn setTitleColor:Main_Color forState:0];
            btn.titleLabel.font=[UIFont systemFontOfSize:15];
            btn.sd_layout
            .leftSpaceToView(self, 0)
            .rightSpaceToView(self, 0)
            .topSpaceToView(self, 10+(10+30)*i)
            .heightIs(30);
        }
        
     
    }
    
    return self;
}

-(void)btnClick:(UIButton*)btn{
    self.Block(btn.tag);
}
- (void)show{
    //获取window对象
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    //171 285
//    self.frame=CGRectMake(ScreenWidth-171-15, 64+30 , 171 ,285 );
//    self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tc_bg"]];
    UIButton * view = [UIButton buttonWithType:UIButtonTypeCustom];//
    view.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [view addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    view.tag=1000;
    [window addSubview:view];
    [window addSubview:self];
}
-(void)dissmiss{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView * view =[window viewWithTag:1000];
    
    [view removeFromSuperview];
    [self removeFromSuperview];
    
}
@end
