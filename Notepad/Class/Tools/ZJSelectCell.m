//
//  ZJSelectCell.m
//  车管家
//
//  Created by linghang on 17/6/10.
//  Copyright © 2017年 zj. All rights reserved.
//

#import "ZJSelectCell.h"

@implementation ZJSelectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier height:(CGFloat)height {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-30*pix, height)];
        _imgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_imgView];
        
        _titLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-30*pix, height)];
        _titLabel.backgroundColor = [UIColor clearColor];
        _titLabel.textColor = [UIColor blackColor];
        _titLabel.textAlignment = NSTextAlignmentCenter;
        _titLabel.font = [UIFont systemFontOfSize:15];
        [_imgView addSubview:_titLabel];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, height-2*pix, ScreenWidth-30*pix, 2*pix)];
        _line.backgroundColor = BG_COLOR;
        [self.contentView addSubview:_line];
    }
    return self;
}

@end
