//
//  SGViewController.m
//  Notepad
//
//  Created by feijiu_1 on 2017/12/8.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "SGViewController.h"
#import "FirstVC.h"
#import "SGPagingView.h"
#import "SecondVC.h"
#import "AddOneVC.h"
#import "TanKuangView.h"
#import "AddVC.h"
@interface SGViewController ()<SGPageTitleViewDelegate, SGPageContentViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@end

@implementation SGViewController
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Home";
    self.backHomeBtn.hidden=YES;
    self.rightButton.hidden=NO;
    [self.rightButton setImage:[UIImage imageNamed:@"public"] forState:0];
    self.rightButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [self.rightButton addTarget:self action:@selector(rightClink) forControlEvents:UIControlEventTouchUpInside];
//
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSelectedIndex:) name:@"changeSelectedIndex" object:nil];
    [self setupPageView];
}

-(void)rightClink{
    TanKuangView * view =[[TanKuangView alloc]initWithArray:@[@"Content memory",@"Sequential memory"]];
     __weak typeof(view)  sf = view;
    view.Block=^(NSInteger tagg){
        if (tagg==0) {
            
            AddOneVC * vc =[AddOneVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            AddVC * vc =[AddVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        [sf dissmiss];
    
    };
    [view show];
//    AddOneVC * vc =[AddOneVC new];
//    [self.navigationController pushViewController:vc animated:YES];
}


- (void)changeSelectedIndex:(NSNotification *)noti {
    _pageTitleView.resetSelectedIndex = [noti.object integerValue];
}
- (void)setupPageView {
    CGFloat statusHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    CGFloat pageTitleViewY = 0;
    if (statusHeight == 20.0) {
        pageTitleViewY = 64;
    } else {
        pageTitleViewY = 88;
    }
    
    NSArray *titleArr = @[@"Content memory", @"Sequential memory"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorAdditionalWidth = 10;
    configure.titleSelectedColor=Main_Color;
    configure.titleColor=[UIColor lightGrayColor];
    configure.indicatorColor=Main_Color;
    configure.titleFont=[UIFont systemFontOfSize:16];
    
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, pageTitleViewY, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
    self.pageTitleView.isShowBottomSeparator=NO;
    [self.view addSubview:_pageTitleView];
    
    
    NSMutableArray * childArr=[NSMutableArray array];
    FirstVC * xvc =[FirstVC new];
    SecondVC * pvc=[SecondVC new];
    [childArr addObject:pvc];
    [childArr addObject:xvc];
    /// pageContentView
    CGFloat contentViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
    //     NSLog(@"2==>>>%lu",originalIndex);
}


#pragma mark --点击事件
-(void)rightButtonClick{
    AddOneVC * vc =[AddOneVC new];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
