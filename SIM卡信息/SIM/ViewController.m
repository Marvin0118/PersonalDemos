//
//  ViewController.m
//  SIM
//
//  Created by MccRee on 2018/3/2.
//  Copyright © 2018年 mccree. All rights reserved.
//

#import "ViewController.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

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
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    //运营商可用
    BOOL use = carrier.allowsVOIP;
    //运营商名字
    NSString *name = carrier.carrierName;
    //ISO国家代码
    NSString *code = carrier.isoCountryCode;
    //移动国家代码
    NSString *mcc = [carrier mobileCountryCode];
    //移动网络代码
    NSString *mnc = [carrier mobileNetworkCode];
    NSLog(@"================SIM卡信息================\n运营商可用:%d\n运营商名字:%@\nISO国家代码:%@\n移动国家代码:%@\n移动网络代码:%@\n",use,name,code,mcc,mnc);
    
}


@end
