//
//  AddVC.m
//  Notepad
//
//  Created by feijiu_1 on 2017/11/25.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "AddVC.h"
#import "AddCell.h"
#import "ZJSelectPhotoTool.h"
@interface AddVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSString * _userName;
    NSString * _nikeName;
    NSString * _phone;
    NSString * _email;
    NSString * _code;
    NSString * _website;
    NSString * _divideClass;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)PeopleData * dataDao;
@property(nonatomic,strong)UIImage * headImage;
@end

@implementation AddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=BG_COLOR;
    self.title=@"Editor";
  
    _dataDao=[[PeopleData alloc]init];
    [_dataDao connectSqlite];
    _dataArray=@[@"User name:",@"Nick name:",@"Phone:",@"Email:",@"Sercret code:",@"Web site:",@"Divide class:"];
    [self CreatTableView];
   
}
#pragma mark --创建tableView`
-(void)CreatTableView{
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.backgroundColor=BG_COLOR;
    _tableView=tableView;
    
    tableView.tableFooterView=[self CreatFootView];
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
    cell.textField.delegate=self;
    cell.textField.tag=indexPath.row;
    return cell;
    
}

-(UIView *)CreatFootView{
    UIView * footView =[UIView new];
    footView.backgroundColor=BG_COLOR;
    footView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(300);
    
    UIButton * buttonImage =[UIButton buttonWithType:UIButtonTypeCustom];
    [buttonImage setBackgroundImage:[UIImage imageNamed:@"上传图片"] forState:0];
    [buttonImage addTarget:self action:@selector(buttonImageClink:) forControlEvents:UIControlEventTouchUpInside];
    [footView sd_addSubviews:@[buttonImage]];
    buttonImage.sd_layout
    .leftSpaceToView(footView, 15)
    .topSpaceToView(footView, 15)
    .widthIs(80)
    .heightIs(80);
    
    
    
    
    
    UIButton * footBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [footBtn setTitle:@"Save" forState:0];
    footBtn.backgroundColor=Main_Color;
    footBtn.sd_cornerRadius=@(10);
    footBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    footBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [footBtn addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [footView sd_addSubviews:@[footBtn]];
    footBtn.sd_layout
    .leftSpaceToView(footView, 30)
    .rightSpaceToView(footView, 30)
    .centerYEqualToView(footView)
    .heightIs(40);
    
    
    
    return footView;
}




#pragma mark --保存
-(void)saveButtonClick{
     NSString * str1 =[ToolClass isString:_userName];
     NSString * str2 =[ToolClass isString:_nikeName];
     NSString * str3 =[ToolClass isString:_phone];
     NSString * str4 =[ToolClass isString:_email];
     NSString * str5 =[ToolClass isString:_code];
     NSString * str6 =[ToolClass isString:_website];
     NSString * str7 =[ToolClass isString:_divideClass];
  NSLog(@">>>%@>>>%@>>>%@>>>%@>>>%@>>>%@>>>%@",str1,str2,str3,str4,str5,str6,str7);
    
    if ([str1 isEqualToString:@""] || [str2 isEqualToString:@""] || [str3 isEqualToString:@""] || [str4 isEqualToString:@""] || [str5 isEqualToString:@""] || [str6 isEqualToString:@""] || [str7 isEqualToString:@""]) {
        
        [LCProgressHUD showFailure:@"Please enter complete information"];
        return;
    }
    
    [_dataDao insertPeopleWithName:str1 Nickname:str2 Phone:str3 Email:str4 Code:str5 Web:str6 Divide:str7 Other1:@"0" Oher2:@""];
    SGViewController * vc = [[SGViewController alloc]init];
    BaseNavigationController *rootController = [[BaseNavigationController alloc] initWithRootViewController:vc];
    
    [(DDMenuController *)[UIApplication sharedApplication].delegate.window.rootViewController setRootController:rootController animated:YES];
    
    
}
-(void)buttonImageClink:(UIButton*)button{
    [ZJSelectPhotoTool showSeletPhotoWith:self NamesArray:@[@"Select from album", @"Take pictures"] IsEditing:NO BackImageBlock:^(UIImage *image) {
        NSLog(@">>>>%@",image);
        _headImage=image;
        [button setBackgroundImage:image forState:0];
        
    } IsIcon:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag==0) {
        _userName=textField.text;
    }else if (textField.tag==1){
        _nikeName=textField.text;
    }else if (textField.tag==2){
        _phone=textField.text;
    }else if (textField.tag==3){
        _email=textField.text;
    }else if (textField.tag==4){
        _code=textField.text;
    }else if (textField.tag==5){
        _website=textField.text;
    }else if (textField.tag==6){
        _divideClass=textField.text;
    }
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
