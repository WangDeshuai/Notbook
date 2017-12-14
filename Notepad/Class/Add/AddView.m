//
//  AddView.m
//  Notepad
//
//  Created by feijiu_1 on 2017/12/8.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "AddView.h"
@interface AddView ()
@property(nonatomic,strong)UIView * navView;
@property(nonatomic,strong)UIButton * canBtn;
@property(nonatomic,strong)UIButton * sureBtn;
@property(nonatomic,strong)UILabel * namelabel;
@property(nonatomic,assign)int tagg;
@end
@implementation AddView

-(id)init{
    self=[super init];
    if (self) {
//        UIWindow *window = ([UIApplication sharedApplication].delegate).window;

        self.backgroundColor=BG_COLOR;
//        UIView * bgView =[UIView new];
//        bgView.alpha=.4;
//        bgView.backgroundColor=[UIColor blackColor];
//        bgView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
//        [window addSubview:bgView];
//
//        [bgView bringSubviewToFront:self];
//
        _navView=[UIView new];
        _navView.backgroundColor=Main_Color;
        [self sd_addSubviews:@[_navView]];
        _navView.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .heightIs(44);
        //标题
        UILabel * nameLabel =[UILabel new];
        nameLabel.text=@"Please select";
        nameLabel.font=[UIFont systemFontOfSize:16];
        nameLabel.textColor=[UIColor whiteColor];
        [_navView sd_addSubviews:@[nameLabel]];
        nameLabel.sd_layout
        .centerXEqualToView(_navView)
        .centerYEqualToView(_navView)
        .heightIs(20);
        [nameLabel setSingleLineAutoResizeWithMaxWidth:100];
        //取消
        _canBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_canBtn setTitle:@"Cancel" forState:0];
        [_canBtn addTarget:self action:@selector(canBtnClink) forControlEvents:UIControlEventTouchUpInside];
    _canBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        _canBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [_navView sd_addSubviews:@[_canBtn]];
        _canBtn.sd_layout
        .leftSpaceToView(_navView, 15)
        .centerYEqualToView(nameLabel)
        .widthIs(70)
        .heightIs(20);
        
        //确定
        _sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"Sure" forState:0];
    _sureBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        _sureBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [_sureBtn addTarget:self action:@selector(sureBtnClink:) forControlEvents:UIControlEventTouchUpInside];
        [_navView sd_addSubviews:@[_sureBtn]];
        _sureBtn.sd_layout
        .rightSpaceToView(_navView, 15)
        .centerYEqualToView(nameLabel)
        .widthIs(70)
        .heightIs(20);
        
        
        
        //随机发布
        UIButton * myBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        myBtn.tag=1;
        [myBtn addTarget:self action:@selector(mybtnClink:) forControlEvents:UIControlEventTouchUpInside];
        [myBtn setBackgroundImage:[UIImage imageNamed:@"普通记忆"] forState:0];
        [self sd_addSubviews:@[myBtn]];
        myBtn.sd_layout
        .leftSpaceToView(self, 30)
        .topSpaceToView(_navView, 40)
        .widthIs(80)
        .heightIs(80);
        
        //分类发布
        UIButton * classBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        classBtn.tag=2;
        [classBtn addTarget:self action:@selector(mybtnClink:) forControlEvents:UIControlEventTouchUpInside];
        [classBtn setBackgroundImage:[UIImage imageNamed:@"分类记忆"] forState:0];
        [self sd_addSubviews:@[classBtn]];
        classBtn.sd_layout
        .rightSpaceToView(self, 30)
        .centerYEqualToView(myBtn)
        .widthIs(100)
        .heightIs(100);
        
        UILabel * namelabel =[UILabel new];
        _namelabel=namelabel;
//        namelabel.backgroundColor=Main_Color;
        namelabel.textAlignment=1;
        namelabel.text=@"My memory";
        namelabel.textColor=[UIColor blackColor];
        [self sd_addSubviews:@[namelabel]];
        namelabel.sd_layout
        .centerXEqualToView(self)
        .topSpaceToView(classBtn, 30)
        .widthIs(120)
        .heightIs(30);
        
    }
    
    return self;
}


-(void)sureBtnClink:(UIButton*)btn{
    self.blockBtn(_tagg);
}

//取消
-(void)canBtnClink{
    int g =ScreenHeight/2;
    self.frame=CGRectMake(0, ScreenHeight-g-49, ScreenWidth, g);
    [UIView animateWithDuration:2 animations:^{
        self.frame=CGRectMake(0, ScreenHeight, ScreenWidth, g);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)mybtnClink:(UIButton*)btn{
    if (btn.tag==1) {
        _namelabel.text=@"My memory";
        _tagg=0;
    }else{
         _namelabel.text=@"Class memory";
        _tagg=1;
    }
}
@end
