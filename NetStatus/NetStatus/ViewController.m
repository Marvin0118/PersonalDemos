//
//  ViewController.m
//  NetStatus
//
//  Created by MccRee on 2018/2/6.
//  Copyright © 2018年 mccree. All rights reserved.
//



#import "ViewController.h"
#import "NSString+MR.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",[NSString getNetStatus]);
}

@end
