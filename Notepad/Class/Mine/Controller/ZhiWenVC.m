//
//  ZhiWenVC.m
//  Notepad
//
//  Created by feijiu_1 on 2017/11/30.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ZhiWenVC.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface ZhiWenVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation ZhiWenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Set TouchID";
//    [self evaluateAuthenticate];
    [self CreatTableView];
}



-(void)CreatTableView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    _tableView=tableView;
    tableView.tableFooterView=[UIView new];
    tableView.backgroundColor=BG_COLOR;
    tableView.rowHeight=50;
    [self.view addSubview:tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UISwitch *switchView = [[UISwitch alloc]initWithFrame:CGRectMake(ScreenWidth-80, 8, 100.0f, 28.0f)];
        switchView.tag=10;
        [cell addSubview:switchView];
    }
    
    UISwitch * switchView =[cell viewWithTag:10];
    switchView.on=NO;
    [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知

    cell.textLabel.text=@"Open TouchID";
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}


-(void)switchAction:(UISwitch*)switchView{
    if (switchView.on==YES) {
        NSLog(@"打开了");
        [self evaluateAuthenticate];
    }else{
        NSLog(@"关闭了");
    }
}



- (void)evaluateAuthenticate
{
    //创建LAContext
    LAContext* context = [[LAContext alloc] init];
    NSError* error = nil;
    NSString* result = @"Please verify your fingerprint";
    
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            if (success) {
                //验证成功，主线程处理UI
                NSLog(@"验证成功");
            }
            else
            {
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        //系统取消授权，如其他APP切入
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        //用户取消验证Touch ID
//                        NSLog(@"用户取消了Touch ID");
                        break;
                    }
                    case LAErrorAuthenticationFailed:
                    {
                        //授权失败
                        break;
                    }
                    case LAErrorPasscodeNotSet:
                    {
                        //系统未设置密码
//                        NSLog(@"未设置密码吗");
                        break;
                    }
                    case LAErrorTouchIDNotAvailable:
                    {
                        //设备Touch ID不可用，例如未打开
                        break;
                    }
                    case LAErrorTouchIDNotEnrolled:
                    {
                        //设备Touch ID不可用，用户未录入
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //用户选择输入密码，切换主线程处理
                            
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //其他情况，切换主线程处理
                        }];
                        break;
                    }
                }
            }
        }];
    }
    else
    {
        //不支持指纹识别，LOG出错误详情
        NSLog(@"不支持指纹识别");
        
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        
        NSLog(@"%@",error.localizedDescription);
    }
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
