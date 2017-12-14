//
//  ZJPickerView.h
//  Black
//
//  Created by zhangjing on 15/10/24.
//  Copyright © 2015年 张晶. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^myBlock)(NSString *title, NSInteger index);

@interface ZJPickerView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *namesArray;

+ (void)showPickerViewWithNamesArray:(NSArray *)names Block:(myBlock)block;

@end
