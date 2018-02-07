//
//  NSString+MR.m
//  NetStatus
//
//  Created by MccRee on 2018/2/6.
//  Copyright © 2018年 mccree. All rights reserved.
//

//屏幕高度
#define H [UIScreen mainScreen].bounds.size.height
#define W [UIScreen mainScreen].bounds.size.width
//适配iPhoneX的宏
#define k_iPhoneX (W == 375.f && H == 812.f ? YES : NO)

#import "NSString+MR.h"
#import <UIKit/UIApplication.h>
@implementation NSString (MR)

+ (NSString *)getNetStatus{
    NSString *network = @"";
    UIApplication *app = [UIApplication sharedApplication];//获取当前app
    UIView *statusBar = [app valueForKeyPath:@"statusBar"];
    if (k_iPhoneX) {
        id statusBarView = [statusBar valueForKeyPath:@"statusBar"];
        UIView *foregroundView = [statusBarView valueForKeyPath:@"foregroundView"];
        NSArray *subviews = [[foregroundView subviews][2] subviews];
        for (id subview in subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarWifiSignalView")]) {
                network = @"WIFI";
            }else if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarStringView")]) {
                network = [subview valueForKeyPath:@"originalText"];
            }
        }
        return network;
    }else{
        UIApplication *app = [UIApplication sharedApplication];//获取当前app
        NSArray *chidren = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
        int type = 0;
        for(id child in chidren){
            if([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
                type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            }
        }
        switch(type) {
            case 0:
                network = @"notReachable";
                break;
            case 1:
                network = @"2g";
                break;
            case 2:
                network = @"3g";
                break;
            case 3:
                network = @"4g";
                break;
            case 4:
                network = @"LTE";
                break;
            case 5:
                network = @"wifi";
                break;
            default:
                break;
        }
        return network;
    }
}
@end
