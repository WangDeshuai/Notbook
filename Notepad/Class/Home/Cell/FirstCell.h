//
//  FirstCell.h
//  Notepad
//
//  Created by feijiu_1 on 2017/12/8.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;
@property(nonatomic,strong)UIImageView * leftImage;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * contentLabel;
@property(nonatomic,strong)UILabel * timeLable;


@property(nonatomic,strong)UILabel * dianLabel0;
@property(nonatomic,strong)UIView * lineView0;

@property(nonatomic,strong)UILabel * dianLabel1;
@property(nonatomic,strong)UIView * lineView1;
@end
