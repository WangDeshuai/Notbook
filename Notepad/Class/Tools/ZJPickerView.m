//
//  ZJPickerView.m
//  Black
//
//  Created by zhangjing on 15/10/24.
//  Copyright © 2015年 张晶. All rights reserved.
//

#import "ZJPickerView.h"
#import "ZJSelectCell.h"
#import "ZJButton.h"
#define row_height 90*pix

@interface ZJPickerView()

@property (strong, nonatomic) myBlock sendBlock;

/** 蒙版Button */
@property (strong, nonatomic) ZJButton *mengBanButton;

/** 主面板 */
@property (strong, nonatomic) UIView *mainBanView;

/** 取消按钮 */
@property (strong, nonatomic) ZJButton *quxiaButton;;

@end

@implementation ZJPickerView
static ZJPickerView *object = nil;

+ (void)showPickerViewWithNamesArray:(NSMutableArray *)names Block:(myBlock)block {
    
    // 1. 判断当前Object是否为空, 如果为空就创建一个
    if ( object == nil) {
        @synchronized (self){ // 避免多个线程同时访问
            if (object == nil) {
                
                // 1. 创建拾取器视图对象
                object = [[ZJPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
                
                // 2. 创建蒙版
                object.mengBanButton = [ZJButton buttonWithFrame:object.bounds Text:nil TextColor:nil TextAlignment:0 ImageName:nil BackgroundColor:[UIColor blackColor] Block:^(UIButton *sender) {
                    
                    // 出场
                    [UIView animateWithDuration:0.5 animations:^{
                        object.mengBanButton.alpha = 0.4;
                        object.mainBanView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, object.tableView.frame.size.height);
                    } completion:^(BOOL finished) {
                        
                        [object removeFromSuperview];
                        
                    }];
                    
                }];
                object.mengBanButton.alpha = 0.4;
                [object addSubview:object.mengBanButton];
                
                // 3. 创建主面板
                object.mainBanView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                object.backgroundColor = [UIColor clearColor];
                [object addSubview:object.mainBanView];
                
                // 4. 创建表示图
                object.tableView = [[UITableView alloc] initWithFrame:CGRectMake(15*pix, 0, ScreenWidth-30*pix, object.mainBanView.frame.size.height+30*pix) style:UITableViewStylePlain];
                object.tableView.delegate = object;
                object.tableView.dataSource = object;
                object.tableView.backgroundColor = [UIColor clearColor];
                object.tableView.bounces = NO;
                object.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                [object.mainBanView addSubview:object.tableView];
                
                // 7. 调用出场事件
                [object showPickerViewWithNamesArray:names Block:block];
                
            }
        }
    } else {
    
        // 调用出场事件
        [object showPickerViewWithNamesArray:names Block:block];
        
    }
    
}

#pragma mark - Show picker view
- (void)showPickerViewWithNamesArray:(NSMutableArray *)names Block:(myBlock)block{
    
    // 1. 指定回调的Block
    self.sendBlock = block;
    
    // 2. 数组赋值
    self.namesArray = names;
    
    // 3. 刷新标示图
    [self.tableView reloadData];
    
    // 4. 设定表示图的frame
    if (names.count*row_height < ScreenHeight*2/3) {
        self.tableView.frame = CGRectMake(15*pix, 0, ScreenWidth-30*pix, (names.count+1)*row_height+30*pix);
    } else {
        self.tableView.frame = CGRectMake(15*pix, 0, ScreenWidth-30*pix, ScreenHeight*2/3+30*pix);
    }
    
    self.mainBanView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, row_height + 20 + self.tableView.frame.size.height);

    // 5. 拿到当前的窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 6. 把Object添加到窗口
    [window addSubview:object];
    
    // 7. 展现视图
    [UIView animateWithDuration:0.5 animations:^{
        
       self.mengBanButton.alpha = 0.4;
        
       self.mainBanView.frame = CGRectMake(0, ScreenHeight - (self.tableView.frame.size.height)-30*pix, ScreenWidth, self.tableView.frame.size.height);
        
    }];
}

#pragma mark - 表示图代理事件
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return self.namesArray.count;
    } else {
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return row_height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return 0;
    } else {
        return 30*pix;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZJSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZJSelectCell"];
    if (!cell) {
        cell = [[ZJSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZJSelectCell" height:row_height];
    }
    
    if (indexPath.section == 0) {
        cell.titLabel.text = self.namesArray[indexPath.row];
    } else {
        cell.titLabel.text = @"取消";
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        [self removeFromSuperview];
        return;
    } else {
        // 回调Block
        self.sendBlock(self.namesArray[indexPath.row], indexPath.row);
        [UIView animateWithDuration:0.5 animations:^{
            self.mengBanButton.alpha = 0.4;
            self.mainBanView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 70 + self.tableView.frame.size.height);
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
            
        }];

    }
}

@end
