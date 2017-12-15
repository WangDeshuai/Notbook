//
//  SettingVC.m
//  Notepad
//
//  Created by Mac on 2017/11/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "SettingVC.h"
#import "SettingCell.h"
#import "GestureVC.h"
#import "NumberPassWordVC.h"
#import "GroupVC.h"
#import "AbountVC.h"
#import "TouchIDViewController.h"
#import "ZhiWenVC.h"
#import "ZJSelectPhotoTool.h"
@interface SettingVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong) UIImageView * imageview;
@property(nonatomic,assign) CGRect  imageRect;
@property(nonatomic,strong)UIImage * headImage;
@end

@implementation SettingVC
static const CGFloat headHeight =160;
static const CGFloat ratio =0.6;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.rightButton.hidden=YES;
     self.backHomeBtn.hidden=YES;
    self.title=@"Setting";
    [self CreatBgImageView];
    [self CreatData];
    [self CreatTableView];
}
- (void)viewWillAppear:(BOOL)animated{
    // 设置导航栏背景透明(取值范围0~1)
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
}
#pragma mark --数据源
-(void)CreatData{
    NSArray * arr1=@[@"Password Settings gestures",@"Setting digital password",@"Set TouchID"];
    NSArray * arr2 =@[@"Group management"];
    NSArray * arr3 =@[@"iCloud Synchronous"];
    NSArray * arr4=@[@"Abount us"];
    _dataArray=@[arr1,arr2,arr3,arr4];
}
//创建背景拉伸图
-(void)CreatBgImageView{
    _imageview =[UIImageView new];
    _imageview.image=[UIImage imageNamed:@"mine_bg"];
    _imageview.frame=CGRectMake(0, 0, ScreenWidth, ScreenWidth*ratio);
    _imageRect=_imageview.frame;
    [self.view addSubview:_imageview];
  
    
    
}
//创建表头
-(UIView*)CraetTableViewHeader{
    UIView * headerView =[UIView new];
    headerView.backgroundColor=[UIColor clearColor];
    headerView.frame=CGRectMake(0, 0, ScreenWidth, headHeight);
    
    //头像
    UIButton * headBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [headBtn setBackgroundImage:[UIImage imageNamed:@"mine_head"] forState:0];
    [headBtn addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    headBtn.sd_cornerRadius=@(40);
    [headerView sd_addSubviews:@[headBtn]];
    headBtn.sd_layout
    .centerXEqualToView(headerView)
    .topSpaceToView(headerView, 10)
    .widthIs(80)
    .heightIs(80);
    //名字
    UILabel * namelabel =[UILabel new];
    namelabel.text=@"Hello";
    namelabel.textColor=[UIColor whiteColor];
    if (@available(iOS 8.2, *)) {
        namelabel.font=[UIFont systemFontOfSize:17 weight:.3];
    } else {
    }
    [headerView sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .topSpaceToView(headBtn, 10)
    .centerXEqualToView(headBtn)
    .heightIs(20);
    [namelabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    //副标题(名字下面label)
    UILabel * namelabel2=[UILabel new];
    namelabel2.text=@"You can choose a head you like";
    namelabel2.textColor=[[UIColor whiteColor]colorWithAlphaComponent:.5];
    if (@available(iOS 8.2, *)) {
        namelabel2.font=[UIFont systemFontOfSize:15 weight:.3];
    } else {
    }
    [headerView sd_addSubviews:@[namelabel2]];
    namelabel2.sd_layout
    .topSpaceToView(namelabel, 5)
    .centerXEqualToView(headBtn)
    .heightIs(20);
    [namelabel2 setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    
    
    return headerView;
}

#pragma mark --创建表
-(void)CreatTableView{
     UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-53) style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.backgroundColor=BG_COLOR;
    _tableView=tableView;
    tableView.backgroundColor=[UIColor clearColor];
    tableView.sectionHeaderHeight=40;
    tableView.tableHeaderView=[self CraetTableViewHeader];
    tableView.tableFooterView=[UIView new];
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
    SettingCell * cell=[SettingCell cellWithTableView:tableView IndexPath:indexPath];
    cell.nameLabel.text=_dataArray[indexPath.section][indexPath.row];
    cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

#pragma mark --表点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController * vc =nil;
  
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
                vc =[[GestureVC alloc] init];
                break;
            case 1:
                vc=[[NumberPassWordVC alloc]init];
                break;
            case 2:
                vc=[[ZhiWenVC alloc]init];
                break;
            default:
                break;
        }
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section==1){
        GroupVC * vc =[GroupVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section==2){
        TouchIDViewController * vc =[TouchIDViewController new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section==3){
        AbountVC * vc =[AbountVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
   
 

}
#pragma mark ---ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY<headHeight) {//向上滑offsetY+
        CGFloat aipat =offsetY/headHeight;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:aipat];
    }else{
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    }
    
    if (offsetY>0) {
        //往上移动
        _imageview.frame=({
            CGRect frame =_imageRect;
            frame.origin.y=_imageRect.origin.y-offsetY;
            frame;
        });
    }else
    {
        _imageview.frame=({
            CGRect frame=_imageRect;
            frame.size.height=_imageRect.size.height-offsetY;
            frame.size.width=frame.size.height/ratio;
            frame.origin.x=_imageRect.origin.x-(frame.size.width-_imageRect.size.width)/2;
            frame;
        });
    }
    
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView =[UIView new];
    headerView.backgroundColor=BG_COLOR;
    
    NSArray * array =@[@"SECURITY SETTINGS",@"GROUP MANAGEMENT",@"ICLOUD SETTING",@"ABOUNT"];
    UILabel * namelabel=[UILabel new];
    namelabel.text=array[section];
    namelabel.alpha=.6;
    namelabel.font=[UIFont systemFontOfSize:15];
    [headerView sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .leftSpaceToView(headerView, 15)
    .centerYEqualToView(headerView)
    .heightIs(30);
    [namelabel setSingleLineAutoResizeWithMaxWidth:200];
    
    
    
    return headerView;
}


#pragma mark --头像选择
-(void)headBtnClick:(UIButton*)btn{
    
    [ZJSelectPhotoTool showSeletPhotoWith:self NamesArray:@[@"Select from album", @"Take pictures"] IsEditing:NO BackImageBlock:^(UIImage *image) {
        NSLog(@">>>>%@",image);
        _headImage=image;
        [btn setBackgroundImage:image forState:0];
        [self saveImage];
    } IsIcon:NO];
}

-(void)saveImage{
    NSString * path =NSHomeDirectory();
    NSString * imagePath =[path stringByAppendingString:@"/Documents/pic.png"];
    [UIImagePNGRepresentation(_headImage) writeToFile:imagePath atomically:YES];
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
