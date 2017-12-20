//
//  ViewController.m
//  MethodSwizz
//
//  Created by MccRee on 2017/9/13.
//  Copyright © 2017年 MccRee. All rights reserved.
//

#import "ViewController.h"
#import "VCA.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    VCA *vca = [[VCA alloc]init];
    [self.navigationController pushViewController:vca animated:YES];
}

@end
