//
//  ZJSelectCell.h
//  车管家
//
//  Created by linghang on 17/6/10.
//  Copyright © 2017年 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJSelectCell : UITableViewCell

@property (nonatomic, strong) UILabel *titLabel;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIView *line;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier height:(CGFloat)height;

@end
