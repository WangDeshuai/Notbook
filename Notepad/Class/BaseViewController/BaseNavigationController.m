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
//     [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"imagenav"] forBarMetrics:UIBarMetricsDefault];
//    self.interactivePopGestureRecognizer.delegate=self;
    self.navigationBar.barTintColor=RGB(63, 164, 62);
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.interactivePopGestureRecognizer.enabled=NO;
    self.fd_prefersNavigationBarHidden = NO;
}
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    return self.childViewControllers.count > 1;
//}

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
