//
//  TouchIDViewController.m
//  DistributionQuery
//
//  Created by Macx on 17/10/6.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "TouchIDViewController.h"
#import "PeopleData.h"
@interface TouchIDViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArr;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSURL *icloudURL;
@property(nonatomic,strong)PeopleData * pDao;
@end

@implementation TouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"iCloud set up";
    NSArray * array1 =@[@"Synchize to iCloud"];
    NSArray * array2 =@[@"From iCloud Synchronize"];
    _pDao=[[PeopleData alloc]init];
    [_pDao connectSqlite];
   

     _dataArr=@[array1,array2];
    [self CreatTabelView];
}




-(void)CreatTabelView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _tableView=tableView;
    tableView.dataSource=self;
     _tableView.backgroundColor=BG_COLOR;
    tableView.delegate=self;
    tableView.tableFooterView=[UIView new];
    tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:tableView];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr[section] count];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
       
    }
   
    cell.textLabel.text=_dataArr[indexPath.section][indexPath.row];
    cell.textLabel.alpha=.7;
    cell.textLabel.textColor=RGB(0, 132, 255);
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

     [self shangChuaniCloud];
    
    
    if (indexPath.section==0) {
        // 另起一个线程上传
        [NSThread detachNewThreadSelector:@selector(uploadICloud) toTarget:self withObject:nil];

    }else{
//        self.label.text = @"开始下载";
        if (self.filePath==nil) {
            return;
        }

        // 下载icloud文件
        if (![self downloadFileIfNotAvailable:self.icloudURL])
        {
//            self.label.text = @"下载失败";
            [LCProgressHUD showMessage:@"Restore failure"];
            return;
        }
        // 更新界面
//        NSArray *array = [[NSArray alloc] initWithContentsOfURL:self.icloudURL];
//        self.textView.text = [array objectAtIndex:0];
        
//        self.label.text = @"下载成功";
        [LCProgressHUD showMessage:@"Restore success"];
    }
    
}

- (void)uploadICloud
{
   
    if (self.filePath==nil) {
        return;
    }
    
    // 调用主进程的方法更新界面,在主进程外更新界面常会引起错误
    [self performSelectorOnMainThread:@selector(setString:)
                           withObject:@"开始上传"
                        waitUntilDone:NO];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    

    NSArray *data = [[NSArray alloc] initWithObjects:@"Check if the data is in sync", nil];
    
    // 判断本地文件是否存在
    if (![manager fileExistsAtPath:self.filePath]) {
        // 不存在则创建
        if (![data writeToFile:self.filePath atomically:YES])
        {
            [self performSelectorOnMainThread:@selector(setString:)
                                   withObject:@"Failed to write local file"
                                waitUntilDone:NO];
        }
    }
    
    // 判断iCloud里该文件是否存在
    if ([manager isUbiquitousItemAtURL:self.icloudURL]) {
        // 存在则修改
        if (![data writeToURL:self.icloudURL atomically:YES])
        {
            [self performSelectorOnMainThread:@selector(setString:)
                                   withObject:@"Failed to write iCloud file"
                                waitUntilDone:NO];
        }
        [self performSelectorOnMainThread:@selector(setString:)
                               withObject:@"Uploaded successfully"
                            waitUntilDone:NO];
        return;
    }
    
    // 上传至iCloud
    // 指定本地文件完整路径
    NSURL *url = [NSURL fileURLWithPath:self.filePath];
    NSError *error;
    // 官方文档建议本方法不要在主进程里执行
    if (![manager setUbiquitous:YES itemAtURL:url destinationURL:self.icloudURL error:&error])
    {
        NSLog(@"setUbiquitous error %@,\n%@", error, [error userInfo]);
//        self.label.text = @"上传失败";
        NSLog(@"同步失败");
        [LCProgressHUD showMessage:@"Synchronization failure"];
        return;
    }

    [LCProgressHUD showMessage:@"Synchronization succeed"];
   
}

-(void)shangChuaniCloud{
    
    // 文件名
    NSString *fileName = @"data.txt";
    
    // 得到文件管理器
    NSFileManager *manager = [NSFileManager defaultManager];
    
    // 验证iCloud是否激活
    NSURL *url = [manager URLForUbiquityContainerIdentifier:nil];
    if (url == nil)
    {
        UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"Warm tips" message:@"iCloud is not available,please go to Setting iCloud to enable" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action =[UIAlertAction actionWithTitle:@"OK" style:0 handler:nil];
        [actionView addAction:action];
        
        [self presentViewController:actionView animated:YES completion:nil];
        return;
    }
    
    // 指定iCloud完整路径
    self.icloudURL = [NSURL URLWithString:fileName relativeToURL:url];
    
    // 得到本程序沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
}









// 此方法是官方文档提供,用来检查文件状态并下载
- (BOOL)downloadFileIfNotAvailable:(NSURL*)file {
    NSNumber*  isIniCloud = nil;
    
    if ([file getResourceValue:&isIniCloud forKey:NSURLIsUbiquitousItemKey error:nil]) {
        // If the item is in iCloud, see if it is downloaded.
        if ([isIniCloud boolValue]) {
            NSNumber*  isDownloaded = nil;
            if ([file getResourceValue:&isDownloaded forKey:NSURLUbiquitousItemIsDownloadedKey error:nil]) {
                if ([isDownloaded boolValue])
                    return YES;
                
                // Download the file.
                NSFileManager*  fm = [NSFileManager defaultManager];
                if (![fm startDownloadingUbiquitousItemAtURL:file error:nil]) {
                    return NO;
                }
                return YES;
            }
        }
    }
    
    // Return YES as long as an explicit download was not started.
    return YES;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 15;
    }else{
       return 40;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
    
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * headView =[UIView new];
    headView.backgroundColor=BG_COLOR;
    
    
    UILabel * namelabel =[UILabel new];
    if (section==0) {
        namelabel.text=@"note:Synchronize to iCloud operations will overwrite backups that have been in iCloud!";
    }else{
        namelabel.text=@"note:From iClioud Synchronize to local operation,it will overwrite local data!";
    }
    
    namelabel.alpha=.8;
    namelabel.numberOfLines=2;
    namelabel.font=[UIFont systemFontOfSize:14];
    [headView sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .leftSpaceToView(headView,20)
    .centerYEqualToView(headView)
    .heightIs(40)
    .rightSpaceToView(headView,15);
    
    
    
    return headView;
}





//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView * headView =[UIView new];
//    headView.backgroundColor=BG_COLOR;
//    return headView;
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
