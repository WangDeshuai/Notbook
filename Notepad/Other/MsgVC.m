//
//  MsgVC.m
//  Notepad
//
//  Created by feijiu_1 on 2017/11/30.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "MsgVC.h"
#import <BmobSDK/Bmob.h>
@interface MsgVC ()
@property(nonatomic,strong)UIWebView * webView;
@property(nonatomic,copy)NSString * urlStr1;
@end

@implementation MsgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self CreatWebView];
}
-(void)CreatWebView{
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"TXAPP"];
    
    [bquery getObjectInBackgroundWithId:@"b9418c19ed" block:^(BmobObject *object,NSError *error)
     {
         if (error)
         {
             
         }else{
             NSLog(@"调用后端云bmob");
             if (object) {
                 NSString *status = [object objectForKey:@"isShow"];
                 if ([status isEqualToString:@"0"]) {
                     //正常的
                     NSLog(@"zhengc");
                     self.view.backgroundColor=[UIColor magentaColor];
                 }else{
                     self.view.backgroundColor=[UIColor whiteColor];
                     
                     UIWebView* webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20,ScreenWidth , ScreenHeight-20)];
                     _webView=webView;
                     [self.view addSubview:webView];
                     NSString * url1 =[object objectForKey:@"strUrl"];
                     NSURL* url = [NSURL URLWithString:url1];//创建URL
                     webView.scalesPageToFit = YES;
                     NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
                     [webView loadRequest:request];//加载
                     
                 }
                 
             }
         }
     }];
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
