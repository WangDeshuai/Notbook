//
//  NumberPassWordVC.m
//  Notepad
//
//  Created by feijiu_1 on 2017/11/25.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "NumberPassWordVC.h"
#import "WHC_GestureUnlockScreenVC.h"
@interface NumberPassWordVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArray;
@end

@implementation NumberPassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Digital password";
    [self CreatData];
    [self CreatTableView];
}
-(void)CreatData{
    NSArray * arr1 =@[@"Enabke the digital password"];
    NSArray * arr2 =@[@"Delete numeric password"];
    _dataArray=@[arr1,arr2];
}

-(void)CreatTableView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    _tableView=tableView;
    tableView.tableFooterView=[UIView new];
    tableView.sectionFooterHeight=55;
    tableView.sectionHeaderHeight=20;
    tableView.backgroundColor=BG_COLOR;
    [self.view addSubview:tableView];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray[section] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text=_dataArray[indexPath.section][indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.textLabel.alpha=.7;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
               [WHC_GestureUnlockScreenVC setUnlockScreenWithType:ClickNumberType];
            break;
        case 1:
            if(![WHC_GestureUnlockScreenVC removeGesturePasswordWithVC:self]){
            }
            break;
            
        default:
            break;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view =[UIView new];
    view.backgroundColor=BG_COLOR;
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footView =[UIView new];
    footView.backgroundColor=BG_COLOR;
    NSArray * array =@[@"Note:\nnumber password as auxiliary password,when you can't user the fingerprint unlock,password reset password!",@"You can delete your password here!"];
    UILabel * namelabel =[UILabel new];
    namelabel.text=array[section];
    namelabel.font=[UIFont systemFontOfSize:14];
    namelabel.alpha=.7;
    [footView sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .leftSpaceToView(footView, 17)
    .rightSpaceToView(footView, 15)
    .centerYEqualToView(footView)
    .autoHeightRatio(0);
    
    return footView;
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
