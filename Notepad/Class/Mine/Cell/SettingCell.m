//
//  SettingCell.m
//  Notepad
//
//  Created by feijiu_1 on 2017/11/25.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    SettingCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[SettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self CreatStar];
    }
    return self;
}
-(void)CreatStar{
    _nameLabel=[UILabel new];
    _nameLabel.alpha=.7;
    _nameLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView sd_addSubviews:@[_nameLabel]];
    _nameLabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .heightIs(20);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
