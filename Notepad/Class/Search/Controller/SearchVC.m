//
//  SearchVC.m
//  Notepad
//
//  Created by Mac on 2017/11/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "SearchVC.h"
#import "PeopleData.h"
#import "ChineseString.h"
#import "ChaXunVC.h"
#import "AddView.h"
#import "AddOneVC.h"
#import "AddVC.h"
@interface SearchVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)PeopleData * peopleDao;
@property(nonatomic,strong)NSMutableArray * rightIndexArr;//索引
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * nameArray;
@property(nonatomic,strong)AddView * addview;
@property(nonatomic,strong) UIImageView * imageview;
@property(nonatomic,assign) CGRect  imageRect;
@end

@implementation SearchVC
static const CGFloat headHeight =160;
static const CGFloat ratio =0.6;


-(void)viewWillAppear:(BOOL)animated{
   
    NSArray * peopeArr =[_peopleDao searchAllPeople];
    [self.nameArray removeAllObjects];
    for (int i=0; i<peopeArr.count; i++) {
        People *  p =peopeArr[i];
        [self.nameArray addObject:p.nickname];
    }
    _rightIndexArr=[ChineseString IndexArray:self.nameArray];//索引
    _dataArray=[ChineseString LetterSortArray:self.nameArray];
    [_tableView reloadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.rightButton.hidden=YES;
    self.title=@"Search";
    self.backHomeBtn.hidden=YES;
    _peopleDao=[[PeopleData alloc]init];
    [_peopleDao connectSqlite];
    _nameArray=[NSMutableArray new];


    [self CreatTableView];
}



//返回索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _rightIndexArr;
}
//响应点击索引时的委托方法
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger count = 0;
    for(NSString *character in _rightIndexArr)
    {
        if([character isEqualToString:title])
        {
            return count;
        }
        count ++;
    }
    return 0;
}


//返回每个区头索引的内容(不用设置区头的高度)
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * str =[_rightIndexArr objectAtIndex:section];

    return [NSString stringWithFormat:@"%@",str];
}





-(void)CreatTableView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    _tableView=tableView;
    tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    tableView.tableFooterView=[UIView new];
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
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * name =_dataArray[indexPath.section][indexPath.row];
    People *  p =[_peopleDao peopleName:name];
     ChaXunVC* vc =[ChaXunVC new];
    vc.people=p;
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
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
