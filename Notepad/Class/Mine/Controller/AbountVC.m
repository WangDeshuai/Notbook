//
//  AbountVC.m
//  Notepad
//
//  Created by feijiu_1 on 2017/11/30.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "AbountVC.h"

@interface AbountVC ()

@end

@implementation AbountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Abount";
    UIImageView * logoImage =[UIImageView new];
    logoImage.image=[UIImage imageNamed:@"imageLogo"];
    [self.view sd_addSubviews:@[logoImage]];
    logoImage.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view,100)
    .widthIs(100)
    .heightIs(100);
    
    UILabel * namelabel =[UILabel new];
    namelabel.text=@"Quick memory assistant";
    namelabel.textAlignment=1;
    namelabel.alpha=.7;
    [self.view sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(logoImage,20)
    .heightIs(20);
    [namelabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    
    UILabel * bottomLabel =[UILabel new];
    bottomLabel.text=@"Copyright\n the APP Developer ALL Rights Reserved";
    bottomLabel.font=[UIFont systemFontOfSize:15];
    bottomLabel.textAlignment=1;
    bottomLabel.alpha=.6;
    [self.view sd_addSubviews:@[bottomLabel]];
    bottomLabel.sd_layout
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,10)
    .bottomSpaceToView(self.view,50)
    .autoHeightRatio(0);
    
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
