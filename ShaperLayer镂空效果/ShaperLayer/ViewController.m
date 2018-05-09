//
//  ViewController.m
//  ShaperLayer
//
//  Created by MccRee on 2018/5/8.
//  Copyright © 2018年 mccree. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.view.bounds);
    
    CGPathRef subPath = CGPathCreateWithEllipseInRect(CGRectMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height - 50, 50, 50), NULL);
    CGPathAddPath(path, NULL, subPath);
    CGPathCloseSubpath(path);
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = path;
    maskLayer.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.55].CGColor;
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    [self.view.layer addSublayer:maskLayer];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
