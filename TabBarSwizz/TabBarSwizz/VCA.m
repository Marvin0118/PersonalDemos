//
//  VCA.m
//  MethodSwizz
//
//  Created by MccRee on 2017/9/13.
//  Copyright © 2017年 MccRee. All rights reserved.
//

#import "VCA.h"
#import "VCB.h"
@interface VCA ()

@end

@implementation VCA

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor redColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    VCB *vcb = [[VCB alloc]init];
    [self presentViewController:vcb animated:YES completion:^{
        
    }];
}

@end
