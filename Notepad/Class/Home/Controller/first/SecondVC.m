//
//  SecondVC.m
//  Notepad
//
//  Created by feijiu_1 on 2017/12/8.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "SecondVC.h"
#import "OneClass.h"
#import "FirstCell.h"
#import "AddOneVC.h"
@interface SecondVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)OneClass * dao;
@property(nonatomic,strong)NSArray * dataArray;
@end

@implementation SecondVC
-(void)viewWillAppear:(BOOL)animated{
//    _dao=[[OneClass alloc]init];
//    [_dao connectSqlite];
    
    _dataArray =[_dao searchAllPeople];
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backHomeBtn.hidden=YES;
    _dao=[[OneClass alloc]init];
    [_dao connectSqlite];
    NSArray * array =[_dao searchAllPeople];
    if (array==nil || array.count==0) {
        [_dao insertPeopleWithName:@"Example" Content:@"This is a memory way of memorizing content!" Other:[self getCurrentTime]];
    }
    
    
    [self CreatTableView];
    
    
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.sd_cornerRadius=@(30);
     [btn addTarget:self action:@selector(rightClink) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor=[UIColor redColor];
    [self.view sd_addSubviews:@[btn]];
    btn.sd_layout
    .rightSpaceToView(self.view, 15)
    .bottomSpaceToView(self.view, 49+15)
    .widthIs(60)
    .heightIs(60);
    
    
}
-(void)rightClink{
    int r =(arc4random()%256);
    int g =(arc4random()%256);
    int b =(arc4random()%256);
    self.navigationController.navigationBar.barTintColor=RGB(r, g, b);
    [_tableView reloadData];
}
-(void)CreatTableView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    _tableView=tableView;
    tableView.tableFooterView=[UIView new];
    tableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FirstCell * cell =[FirstCell cellWithTableView:tableView IndexPath:indexPath];
    OnePeople * p =_dataArray[indexPath.row];
    cell.nameLabel.text=p.title;
    cell.timeLable.text=p.otherstr1;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OnePeople * p =_dataArray[indexPath.row];
    AddOneVC * vc =[AddOneVC new];
    vc.p=p;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_tableView cellHeightForIndexPath:indexPath cellContentViewWidth:[ToolClass cellContentViewWith] tableView:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyy-MM-dd HH:mm"];
    NSString*dateTime = [formatter stringFromDate:[NSDate  date]];
    return dateTime;
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
