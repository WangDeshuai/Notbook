//
//  AddOneVC.m
//  Notepad
//
//  Created by feijiu_1 on 2017/12/8.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "AddOneVC.h"
#import "OneClass.h"
@interface AddOneVC ()
@property(nonatomic,strong)UITextField * titleText;
@property(nonatomic,strong)UITextView * contenText;
@property(nonatomic,strong)OneClass * dao;
@end

@implementation AddOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Message";
 
    _dao=[[OneClass alloc]init];
    [_dao connectSqlite];
    [self CreatUI];
}


-(void)CreatUI{
    UITextField * textField =[[UITextField alloc]init];
  
    if (_p) {
        textField.text=_p.title;
    }else{
        textField.placeholder=@"Please enter the title";
    }
    int h=0;
    if (kDevice_Is_iPhoneX==YES) {
        h=64+20;
    }else{
        h=64;
    }
    
    
    _titleText=textField;
    textField.backgroundColor=[UIColor whiteColor];
    textField.font=[UIFont systemFontOfSize:15];
    [self.view sd_addSubviews:@[textField]];
    textField.sd_layout
    .leftSpaceToView(self.view, 5)
    .rightSpaceToView(self.view, 5)
    .topSpaceToView(self.view,h+10)
    .heightIs(30);
   
    
    //内容
    UITextView * textView =[UITextView new];
    _contenText=textView;
    textView.backgroundColor=[UIColor whiteColor];
    if (_p) {
        textView.text=_p.content;
    }else{
         textView.text=@"Please enter content...";
    }
   
    textView.alpha=.6;
    textView.font=[UIFont systemFontOfSize:15];
    [self.view sd_addSubviews:@[textView]];
    textView.sd_layout
    .leftEqualToView(textField)
    .rightEqualToView(textField)
    .topSpaceToView(textField, 15)
    .heightIs(200);
    
    
    UIButton * saveBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.backgroundColor=Main_Color;
    [saveBtn addTarget:self action:@selector(saveBtnClink) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitle:@"Save" forState:0];
    saveBtn.sd_cornerRadius=@(20);
    [self.view sd_addSubviews:@[saveBtn]];
    saveBtn.sd_layout
    .topSpaceToView(textView, 30)
    .heightIs(40)
    .leftSpaceToView(self.view, 30)
    .rightSpaceToView(self.view, 30);
    
}

#pragma mark --保存按钮
-(void)saveBtnClink{
    
    NSString * title =[NSString stringWithFormat:@"%@",_titleText.text];
    NSString * content =[NSString stringWithFormat:@"%@",_contenText.text];
    NSString * time=[self getCurrentTime];
    
    
    [_dao insertPeopleWithName:title Content:content Other:time];
//    [self.navigationController popViewControllerAnimated:YES];
    SGViewController * vc = [[SGViewController alloc]init];
    BaseNavigationController *rootController = [[BaseNavigationController alloc] initWithRootViewController:vc];
    
    [(DDMenuController *)[UIApplication sharedApplication].delegate.window.rootViewController setRootController:rootController animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取当前时间
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
