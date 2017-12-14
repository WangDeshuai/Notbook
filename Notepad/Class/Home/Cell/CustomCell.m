//
//  CustomCell.m
//  DistributionQuery
//
//  Created by Macx on 17/10/15.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self CreatStr];
       
    }
     return self;
}

-(void)CreatStr{
    _imageview=[[UIImageView alloc]init];
    _imageview.image=[UIImage imageNamed:@"文件夹"];
    
   
    
    

    _imageview.backgroundColor=[UIColor clearColor];
    [self.contentView sd_addSubviews:@[_imageview]];
    
    int k =0;
    int g =0;
    
    if (ScreenWidth==320) {
        k=60;
        g=166*60/141;
    }else if (ScreenWidth==375){
        k=80;
        g=166*80/141;
    }else{
        k=100;
        g=166*100/141;
    }
    
    
    //141  166
    _imageview.sd_layout
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.contentView,0)
    .widthIs(k)
    .heightIs(g);
    
    _nameLable=[UILabel new];
    _nameLable.numberOfLines=2;
    if (@available(iOS 8.2, *)) {
        _nameLable.font=[UIFont systemFontOfSize:14 weight:.5];
    } else {
        // Fallback on earlier versions
    }
    _nameLable.alpha=.6;
    _nameLable.textAlignment=1;
     [_nameLable.layer setShadowColor:[UIColor redColor].CGColor];
    [_nameLable.layer setShadowRadius:3.0];
    [_nameLable.layer setShadowOffset:CGSizeMake(0, 5)];
//    _nameLable.textColor=[UIColor blackColor];
    [_imageview sd_addSubviews:@[_nameLable]];
//    _nameLable.backgroundColor=[UIColor redColor];
    _nameLable.sd_layout
    .leftSpaceToView(_imageview,0)
    .rightSpaceToView(_imageview,15)
    .bottomSpaceToView(_imageview, 5)
    .autoHeightRatio(0);
    
    
    
}


@end
