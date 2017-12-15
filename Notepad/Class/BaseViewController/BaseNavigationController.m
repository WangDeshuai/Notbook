//
//  BaseNavigationController.m
//  DistributionQuery
//
//  Created by Macx on 16/10/8.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationBar.barTintColor=Main_Color;
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.interactivePopGestureRecognizer.enabled=NO;
    self.fd_prefersNavigationBarHidden = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"InfoNotification" object:nil];
}
- (void)InfoNotificationAction:(NSNotification *)notification{
     NSLog(@"---接收到通知---");
    int r =(arc4random()%256);
    int g =(arc4random()%256);
    int b =(arc4random()%256);
    self.navigationBar.barTintColor=RGB(r, g, b);
   
    
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
