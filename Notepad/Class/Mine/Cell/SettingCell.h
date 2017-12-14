//
//  SettingCell.h
//  Notepad
//
//  Created by feijiu_1 on 2017/11/25.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;
@property(nonatomic,strong)UILabel * nameLabel;
@end
