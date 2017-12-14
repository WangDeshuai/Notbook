//
//  AddCell.m
//  Notepad
//
//  Created by feijiu_1 on 2017/11/25.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "AddCell.h"

@implementation AddCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    AddCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[AddCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    //name
    _nameLabel=[UILabel new];
    _nameLabel.font=[UIFont systemFontOfSize:15];
    _nameLabel.alpha=.7;
    _nameLabel.textAlignment=0;
    [self.contentView sd_addSubviews:@[_nameLabel]];
    _nameLabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .heightIs(20);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    //textField
    _textField=[UITextField new];
    _textField.placeholder=@"please enter content";
    _textField.textAlignment=2;
    _textField.keyboardType=UIKeyboardTypeDefault;
    _textField.font=[UIFont systemFontOfSize:15];
    [self.contentView sd_addSubviews:@[_textField]];
    _textField.sd_layout
    .leftSpaceToView(_nameLabel, 10)
    .rightSpaceToView(self.contentView, 15)
    .centerYEqualToView(_nameLabel)
    .heightIs(30);
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
