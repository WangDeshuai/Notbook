//
//  BaseViewController.m
//  Notepad
//
//  Created by Mac on 2017/11/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=BG_COLOR;
 self.navigationController.interactivePopGestureRecognizer.enabled=YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [self CreatLeftBtn];
    [self CreatRightBtn];
}

#pragma mark --返回按钮
-(void)CreatLeftBtn{
    UIButton * backHomeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backHomeBtn.frame=CGRectMake(0, 0, 100, 40);
    _backHomeBtn=backHomeBtn;
    [backHomeBtn setImage:[UIImage imageNamed:@"NavigationBar_Back"] forState:0];
    backHomeBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [backHomeBtn addTarget:self action:@selector(backHomeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftImage =[[UIBarButtonItem alloc]initWithCustomView:backHomeBtn];
    //backBarButtonItem
    self.navigationItem.leftBarButtonItem=leftImage;
}
#pragma mark --右按钮
-(void)CreatRightBtn{
    UIButton * rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0, 0, 100, 40);
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    _rightButton=rightBtn;
    UIBarButtonItem * rightBtnItem =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=rightBtnItem;
}




#pragma mark - ******** push下一页并推出当前页 ********
- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated dismiss:(BOOL)dismiss{
    [self.navigationController pushViewController:viewController animated:animated];
    if (dismiss) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3  * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
            for (UIViewController *vc in marr) {
                if ([vc isKindOfClass:[self class]]) {
                    [marr removeObject:vc];
                    break;
                }
            }
            self.navigationController.viewControllers = marr;
        });
        
    }
    
    
}



#pragma mark --返回按钮点击事件
-(void)backHomeBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --导航标题设置
-(void)setTitle:(NSString *)title{
    UILabel * namelabel =[UILabel new];
    namelabel.textColor=[UIColor whiteColor];
    namelabel.text=title;
    namelabel.textAlignment=1;
    namelabel.frame=CGRectMake(0, 0, 120, 40);
    self.navigationItem.titleView=namelabel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
