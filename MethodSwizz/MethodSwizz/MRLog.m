//
//  MRLog.m
//  logDemo
//
//  Created by MccRee on 2017/7/19.
//  Copyright © 2017年 MccRee. All rights reserved.
//

#import "MRLog.h"
#import "AppDelegate.h"


#define pollSec 5 //轮询时间单位s

@interface MRLog()





@end


@implementation MRLog

+ (instancetype)sharedMRLog{
    static MRLog *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[MRLog alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {

        
    }
    return self;
}

- (void)createNewVisitId{
    NSLog(@"生成visitId");
    NSInteger start = [[NSDate date] timeIntervalSince1970]*1000; //毫秒单位
    self.visitId = [NSString MD5String: [NSString stringWithFormat:@"%zd",start]];
}



@end
