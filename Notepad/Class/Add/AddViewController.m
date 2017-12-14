//
//  AddViewController.m
//  Notepad
//
//  Created by feijiu_1 on 2017/12/8.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "AddViewController.h"
#import "AddView.h"
@interface AddViewController ()
@property(nonatomic,strong)AddView * addview;
@end

@implementation AddViewController

-(void)viewWillAppear:(BOOL)animated{
    int g =ScreenHeight/2;
    _addview=[[AddView alloc]init];
    _addview.frame=CGRectMake(0, ScreenHeight, ScreenWidth, g);
    _addview.blockBtn = ^(int btn) {
        
    };
    
    [UIView animateWithDuration:2 animations:^{
        _addview.frame=CGRectMake(0, ScreenHeight-g-49, ScreenWidth, g);
        [self.view addSubview:_addview];
    } completion:^(BOOL finished) {
    }];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_addview removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backHomeBtn.hidden=YES;
    
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
