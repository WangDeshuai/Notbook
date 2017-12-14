//
//  GroupVC.m
//  Notepad
//
//  Created by feijiu_1 on 2017/11/29.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "GroupVC.h"
#import "ClassPeople.h"
@interface GroupVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)ClassPeople * classDao;
@property(nonatomic,strong)NSArray * dataArray;
@end

@implementation GroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Group Management";
    _classDao=[[ClassPeople alloc]init];
    [_classDao connectSqlite];
     _dataArray =[_classDao searchAllPeople];
    [self.rightButton setTitle:@"Add" forState:0];
    [self.rightButton addTarget:self action:@selector(addBtnClink) forControlEvents:UIControlEventTouchUpInside];
   self.rightButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    
    [self CreatTableView];
}


#pragma mark --按钮点击
-(void)addBtnClink{
    UIAlertController * alercont =[UIAlertController alertControllerWithTitle:@"Create a new group" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alercont addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Please enter a group name";
    }];
    
    UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField * text= alercont.textFields[0];
        NSString * str =[ToolClass isString:[NSString stringWithFormat:@"%@",text.text]];
        if ([str isEqualToString:@""]) {
        }else{
            [_classDao insertPeopleWithName:str];
            _dataArray =[_classDao searchAllPeople];
            [_tableView reloadData];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alercont addAction:cancelAction];
    [alercont addAction:determineAction];
    
    [self presentViewController:alercont animated:YES completion:nil];
}


#pragma mark ------创建表格
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
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    ClassData * p =_dataArray[indexPath.row];
    cell.textLabel.text=p.name;
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.textLabel.alpha=.7;
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
