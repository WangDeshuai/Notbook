//
//  BaseTabbarController.m
//  Notepad
//
//  Created by Mac on 2017/11/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "BaseTabbarController.h"
#import "BaseNavigationController.h"
#import "FirstVC.h"
#import "SearchVC.h"
#import "SettingVC.h"
#import "SGViewController.h"
#import "AddViewController.h"
#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"
#define Global_tintColor [UIColor colorWithRed:255/255.0 green:(122 / 255.0) blue:0 alpha:1]
@interface BaseTabbarController ()

@end

@implementation BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"SGViewController",
                                   kTitleKey  : @"First",
                                   kImgKey    : @"分组",
                                   kSelImgKey : @"分组1"},
                                 
                                 @{kClassKey  : @"SearchVC",
                                   kTitleKey  : @"Add",
                                   kImgKey    : @"发布",
                                   kSelImgKey : @"发布"},
                                 
                                 @{kClassKey  : @"SettingVC",
                                   kTitleKey  : @"Setting",
                                   kImgKey    : @"设置",
                                   kSelImgKey : @"设置1"},
                                 ];
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : Main_Color} forState:UIControlStateSelected];
        [self addChildViewController:nav];
        
    }];
   // [self CreatTabbarView];
}
//-(void)CreatTabbarView{
//    NSLog(@"走了");
//    //首页
//    FirstVC * vc1 =[FirstVC new];
//    UINavigationController * nav1 =[[UINavigationController alloc]initWithRootViewController:vc1];
//    UIImage * image1 =[[UIImage imageNamed:@"分组"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIImage * seletImage1 =[[UIImage imageNamed:@"分组1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc1.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"首页" image:image1 selectedImage:seletImage1];
//    [vc1.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
//    [vc1.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:RGB(0, 170, 278)} forState:UIControlStateSelected];
//    //搜索
//    SearchVC * vc2 =[SearchVC new];
//    UINavigationController * nav2 =[[UINavigationController alloc]initWithRootViewController:vc2];
//    UIImage * image2 =[[UIImage imageNamed:@"分组"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIImage * seletImage2 =[[UIImage imageNamed:@"分组1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc2.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"搜索" image:image2 selectedImage:seletImage2];
//    [vc2.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
//    [vc2.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:RGB(0, 170, 278)} forState:UIControlStateSelected];
//    
//    //设置
//    SettingVC * vc3=[SettingVC new];
//    UINavigationController * nav3 =[[UINavigationController alloc]initWithRootViewController:vc3];
//    UIImage * image3 =[[UIImage imageNamed:@"分组"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIImage * seletImage3 =[[UIImage imageNamed:@"分组1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc3.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"设置" image:image3 selectedImage:seletImage3];
//    [vc3.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
//    [vc3.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:RGB(0, 170, 278)} forState:UIControlStateSelected];
//    
//    UIWindow *window = [UIApplication sharedApplication].delegate.window;
//    UITabBarController * tController = [[UITabBarController alloc]init];
//    tController.viewControllers=@[nav1,nav2,nav3];
//    window.rootViewController=tController;
//    
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
