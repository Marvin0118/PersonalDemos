//
//  UIControl+MRLog.m
//  TouchMethod
//
//  Created by MccRee on 2017/10/20.
//  Copyright © 2017年 YSTen. All rights reserved.
//

#import "UIControl+MRLog.h"

@implementation UIControl (MRLog)

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event{
    NSLog(@"%s",__func__);
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event{
    NSLog(@"%s",__func__);
    return YES;
}

- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event{
    NSLog(@"%s",__func__);
}

- (void)cancelTrackingWithEvent:(nullable UIEvent *)event{
    NSLog(@"%s",__func__);
}

@end
