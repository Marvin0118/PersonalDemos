//
//  ViewController.m
//  TwoTableView
//
//  Created by MccRee on 2017/9/7.
//  Copyright © 2017年 MccRee. All rights reserved.
//

#import "ViewController.h"
#import "TableViewA.h"
#import "TableViewB.h"
#import "DayTitleView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TableViewA *ta = [[TableViewA alloc]init];
    TableViewB *tb = [[TableViewB alloc]init];
    [self addChildViewController:ta];
    [self.view addSubview:ta.view];
    [self addChildViewController:tb];
    [self.view addSubview:tb.view];
    
    DayTitleView *dv = [[DayTitleView alloc]init];
    [self.view addSubview:dv];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
