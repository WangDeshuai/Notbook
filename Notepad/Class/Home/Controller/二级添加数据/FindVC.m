//
//  FindVC.m
//  Notepad
//
//  Created by feijiu_1 on 2017/11/30.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "FindVC.h"
#import "AddVC.h"
#import "PeopleData.h"
#import "ChaXunVC.h"
#import "CustomCell.h"
@interface FindVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)PeopleData * peopleDao;
@property(nonatomic,strong)UICollectionView * collevtion;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation FindVC
-(void)viewWillAppear:(BOOL)animated
{
    _dataArray=[_peopleDao genJuPid:_index];
    [_tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=_titleName;
    [self.rightButton setTitle:@"Add" forState:0];    self.rightButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [self.rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _peopleDao =[[PeopleData alloc]init];
    [_peopleDao connectSqlite];
    [self CreatTabelView];
}
//-(void)CreatCollection{
//
//    UICollectionViewFlowLayout * layout =[UICollectionViewFlowLayout new];
//    int d= 20;
//    int k =(ScreenWidth-d*4)/3;
//    int g=k+30;
//    layout.itemSize=CGSizeMake(k, g);
//    layout.minimumLineSpacing=20;
//    layout.minimumInteritemSpacing=20;
//    layout.sectionInset=UIEdgeInsetsMake(20, 20, 20, 20);
//
//
//    _collevtion=[[UICollectionView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49) collectionViewLayout:layout];
//    _collevtion.pagingEnabled=NO;
//    _collevtion.delegate=self;
//    _collevtion.dataSource=self;
//    _collevtion.backgroundColor=BG_COLOR;
//    [self.view addSubview:_collevtion];
//
//
//    [_collevtion registerClass:[CustomCell class] forCellWithReuseIdentifier:@"cell"];
//
//}
//
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return _dataArray.count;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    //        cell.backgroundColor=[UIColor redColor];
//    cell.imageview.image=[UIImage imageNamed:@"文件"];
//    People * people =_dataArray[indexPath.row];
//    cell.nameLable.text=people.username;;
//    return cell;
//
//}
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    ChaXunVC * vc =[ChaXunVC new];
//    People * p =_dataArray[indexPath.row];
//    vc.people=p;
//    [self.navigationController pushViewController:vc animated:YES];
//}
-(void)CreatTabelView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _tableView=tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor=BG_COLOR;
    tableView.rowHeight=50;
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
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    People * people =_dataArray[indexPath.row];
    cell.textLabel.text=people.username;
    cell.textLabel.font=[UIFont systemFontOfSize:17];
    cell.detailTextLabel.text=people.phone;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
    cell.detailTextLabel.alpha=.6;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChaXunVC * vc =[ChaXunVC new];
    People * p =_dataArray[indexPath.row];
    vc.people=p;
    [self.navigationController pushViewController:vc animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --右按钮点击
-(void)rightButtonClick{
    AddVC * vc =[AddVC new];
    vc.hidesBottomBarWhenPushed=YES;
    vc.index=_index;
    [self.navigationController pushViewController:vc animated:YES];
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
