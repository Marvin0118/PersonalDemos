//
//  ViewController.m
//  ViewAnimationMasonry
//
//  Created by MccRee on 2018/3/13.
//  Copyright © 2018年 mccree. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

@interface ViewController ()

@property(nonatomic,strong) UIView *subView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subView = [[UIView alloc]init];
    self.subView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.subView];
    
    [self.subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.left.mas_equalTo(self.view).offset(50);
        make.top.mas_equalTo(self.view).offset(100);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.25 animations:^{
        [self.subView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(200);
        }];
        [self.view layoutIfNeeded];
    }];
}

@end
