//
//  MRLog.h
//  logDemo
//
//  Created by MccRee on 2017/7/19.
//  Copyright © 2017年 MccRee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+MD5.h"



@interface MRLog : NSObject

@property(nonatomic,copy) NSString *visitId;

+ (instancetype)sharedMRLog;

- (void)createNewVisitId;
@end

