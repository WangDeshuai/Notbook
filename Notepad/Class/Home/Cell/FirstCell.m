//
//  FirstCell.m
//  Notepad
//
//  Created by feijiu_1 on 2017/12/8.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "FirstCell.h"

@implementation FirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",(long)indexPath.section,(long)indexPath.row];
    FirstCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[FirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    int r =(arc4random()%256);
    int g =(arc4random()%256);
    int b =(arc4random()%256);
    
    
    cell.backgroundColor=RGB(r, g, b);
    
    
    
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
    self.layer.cornerRadius=5;
    self.clipsToBounds=YES;
     NSString * path =NSHomeDirectory();
    NSString *imagePath = [path stringByAppendingString:@"/Documents/pic.png"];
    UIImage *getimage2 = [UIImage imageWithContentsOfFile:imagePath];
    
    
    
    
    _lineView0=[UIView new];
    _lineView0.backgroundColor=[UIColor whiteColor];
    [self.contentView sd_addSubviews:@[_lineView0]];
    _lineView0.sd_layout
    .leftSpaceToView(self.contentView, 44)
    .topSpaceToView(self.contentView, 0)
    .widthIs(1)
    .heightIs(30);
    
    _dianLabel0=[UILabel new];
    _dianLabel0.backgroundColor=[UIColor whiteColor];
    _dianLabel0.sd_cornerRadius=@(7.5);
    [self.contentView sd_addSubviews:@[_dianLabel0]];
    _dianLabel0.sd_layout
    .centerXEqualToView(_lineView0)
    .topSpaceToView(_lineView0, 0)
    .widthIs(15)
    .heightIs(15);
    
    
    
    _leftImage=[UIImageView new];
    if (getimage2==nil) {
         _leftImage.image=[UIImage imageNamed:@"mine_head"];
    }else{
        _leftImage.image=getimage2;
    }
   
    _leftImage.sd_cornerRadius=@(30);
    [self.contentView sd_addSubviews:@[_leftImage]];
    _leftImage.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(_dianLabel0, 10)
    .widthIs(60)
    .heightIs(60);
    
    
    
    _nameLabel=[UILabel new];
    _nameLabel.font=[UIFont systemFontOfSize:15];
    _nameLabel.alpha=.7;
 
    _nameLabel.textColor=[UIColor whiteColor];
    _nameLabel.font=[UIFont systemFontOfSize:16];
    _nameLabel.font=[UIFont boldSystemFontOfSize:15];
    [self.contentView sd_addSubviews:@[_nameLabel]];
    _nameLabel.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(_leftImage, 10)
    .heightIs(20);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _contentLabel=[UILabel new];
    _contentLabel.alpha=.7;
    _contentLabel.numberOfLines=2;
    _contentLabel.textColor=[UIColor whiteColor];
    _contentLabel.text=@"Here you can add a note to remind you of your memory";
    _contentLabel.font=[UIFont systemFontOfSize:16];
    [self.contentView sd_addSubviews:@[_contentLabel]];
    _contentLabel.sd_layout
    .leftEqualToView(_nameLabel)
    .topSpaceToView(_nameLabel, 5)
    .heightIs(40)
    .rightSpaceToView(self.contentView, 15);
    
    
    
    
    
    
    _timeLable=[UILabel new];
    _timeLable.font=[UIFont systemFontOfSize:12];
    _timeLable.textColor=[UIColor whiteColor];
//    _timeLable.text=[self getCurrentTime];
    [self.contentView sd_addSubviews:@[_timeLable]];
    _timeLable.sd_layout
    .leftEqualToView(_nameLabel)
    .topSpaceToView(_contentLabel, 10)
    .heightIs(15);
    [_timeLable setSingleLineAutoResizeWithMaxWidth:200];
    
    
   
    
   
    _lineView1=[UIView new];
    _lineView1.backgroundColor=[UIColor whiteColor];
    [self.contentView sd_addSubviews:@[_lineView1]];
    _lineView1.sd_layout
    .rightSpaceToView(self.contentView, 44)
    .topSpaceToView(self.contentView, 0)
    .widthIs(1)
    .heightIs(30);
    
    
    _dianLabel1=[UILabel new];
    _dianLabel1.backgroundColor=[UIColor whiteColor];
    _dianLabel1.sd_cornerRadius=@(7.5);
    [self.contentView sd_addSubviews:@[_dianLabel1]];
    _dianLabel1.sd_layout
    .centerXEqualToView(_lineView1)
    .topSpaceToView(_lineView1, 0)
    .widthIs(15)
    .heightIs(15);
    
  
    
    
    
    [self setupAutoHeightWithBottomView:_timeLable bottomMargin:30];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setFrame:(CGRect)frame
{
    frame.origin.y+=15;
    frame.size.height-=15;
    frame.origin.x+=10;
    frame.size.width-=20;
    [super setFrame:frame ];
}
@end
