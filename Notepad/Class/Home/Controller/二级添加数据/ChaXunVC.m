//
//  ChaXunVC.m
//  Notepad
//
//  Created by feijiu_1 on 2017/11/30.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ChaXunVC.h"
#import "AddCell.h"
@interface ChaXunVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArray;
@end

@implementation ChaXunVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray=@[@"User name:",@"Nick name:",@"Phone:",@"Email:",@"Sercret code:",@"Web site:",@"Divide class:"];
    self.title=_people.username;
    [self CreatTableView];
}
#pragma mark --创建tableView`
-(void)CreatTableView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.backgroundColor=BG_COLOR;
    _tableView=tableView;
    
    tableView.tableFooterView=[UIView new];
    tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddCell * cell =[AddCell cellWithTableView:tableView IndexPath:indexPath];
    cell.nameLabel.text=_dataArray[indexPath.row];
    cell.textField.enabled=NO;
    if (indexPath.row==0) {
        cell.textField.text=_people.username;
    }else if (indexPath.row==1){
        cell.textField.text=_people.nickname;
    }else if (indexPath.row==2){
        cell.textField.text=_people.phone;
    }else if (indexPath.row==3){
        cell.textField.text=_people.email;
    }else if (indexPath.row==4){
        cell.textField.text=_people.code;
    }else if (indexPath.row==5){
        cell.textField.text=_people.website;
    }else if (indexPath.row==6){
        cell.textField.text=_people.divide;
    }
    
    
    return cell;
    
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
