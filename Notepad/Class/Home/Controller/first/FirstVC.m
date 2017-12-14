//
//  FirstVC.m
//  Notepad
//
//  Created by Mac on 2017/11/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "FirstVC.h"
#import "AddVC.h"
#import "CustomCell.h"
#import "ClassPeople.h"
#import "FindVC.h"
#import "FirstCell.h"
@interface FirstVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UICollectionView*collevtion;
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)ClassPeople * classDao;
@end

@implementation FirstVC
-(void)viewWillAppear:(BOOL)animated{
   _dataArray=[_classDao searchAllPeople];
    [_collevtion reloadData];
}


-(UIView*)CreatView{
    UIView * view =[UIView new];
    view.backgroundColor=[UIColor redColor];
    view.frame=CGRectMake(0, 0, ScreenWidth, 150);
    
    
    return view;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backHomeBtn.hidden=YES;
    self.view.backgroundColor=BG_COLOR;
    _dataArray=@[@"Student",@"Friend",@"Family",@"Colleagues",@"Other"];
    _classDao=[[ClassPeople alloc]init];
    [_classDao connectSqlite];
    NSArray * array =[_classDao searchAllPeople];
    
    if (array.count==0 ||array==nil) {
         [_classDao insertPeopleWithName:@"Student"];
         [_classDao insertPeopleWithName:@"Friend"];
         [_classDao insertPeopleWithName:@"Family"];
         [_classDao insertPeopleWithName:@"Colleagues"];
         [_classDao insertPeopleWithName:@"Other"];
    }
      _dataArray=[_classDao searchAllPeople];
    
    [self CreatCollection];
    
}

//-(void)CreatTableView{
//    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49) style:UITableViewStylePlain];
//    tableView.dataSource=self;
//    tableView.delegate=self;
//    _tableView=tableView;
//    _tableView.rowHeight=65;
//    tableView.backgroundColor=BG_COLOR;
//    tableView.tableHeaderView=[self CreatView];
//    tableView.tableFooterView=[UIView new];
//    [self.view addSubview:tableView];
//
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return _dataArray.count;;
//}
//
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    FirstCell * cell =[FirstCell cellWithTableView:tableView IndexPath:indexPath];
//    ClassData * p =_dataArray[indexPath.row];
//    cell.nameLabel.text=p.name;
//    return cell;
//
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    FindVC * vc =[FindVC new];
//    ClassData * p =_dataArray[indexPath.row];
//    vc.hidesBottomBarWhenPushed=YES;
//    vc.titleName=p.name;
//    vc.index=[NSString stringWithFormat:@"%lu",indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
//}





//
//
-(void)CreatCollection{

    UICollectionViewFlowLayout * layout =[UICollectionViewFlowLayout new];
    int d= 20;
    int k =(ScreenWidth-d*4)/3;
    int g=k+5;
    layout.itemSize=CGSizeMake(k, g);
    layout.minimumLineSpacing=45+2;//行高
    layout.minimumInteritemSpacing=20;//间距
    if (ScreenWidth==320) {
        layout.minimumLineSpacing=40;//行高
         layout.sectionInset=UIEdgeInsetsMake(47+5, 20, 20, 20);
    }else if (ScreenWidth==375&& ScreenHeight==667){
        layout.sectionInset=UIEdgeInsetsMake(47+5, 20, 20, 20);
    }else if(ScreenWidth==414){
        layout.sectionInset=UIEdgeInsetsMake(20, 20, 20, 20);
    }else if (ScreenWidth==375 && ScreenHeight==812){

         layout.minimumLineSpacing=40+40;//行高
         layout.sectionInset=UIEdgeInsetsMake(47+15, 20, 20, 20);
    }

    NSLog(@">>>>%f>>>>%f",ScreenWidth,ScreenHeight);

    _collevtion=[[UICollectionView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49) collectionViewLayout:layout];
    _collevtion.pagingEnabled=NO;
    _collevtion.delegate=self;
    _collevtion.dataSource=self;
    _collevtion.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_collevtion];


    [_collevtion registerClass:[CustomCell class] forCellWithReuseIdentifier:@"cell"];

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//        cell.backgroundColor=[UIColor redColor];
    int r =(arc4random()%256);
    int ggg =(arc4random()%256);
    int b =(arc4random()%256);
    cell.backgroundColor=RGB(r, ggg, b);;
    ClassData * p =_dataArray[indexPath.row];
    cell.nameLable.text=p.name;
    return cell;

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    FindVC * vc =[FindVC new];
    ClassData * p =_dataArray[indexPath.row];
    vc.hidesBottomBarWhenPushed=YES;
    vc.titleName=p.name;
    vc.index=[NSString stringWithFormat:@"%lu",indexPath.item];
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
