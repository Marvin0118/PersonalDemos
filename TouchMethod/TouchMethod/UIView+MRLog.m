//
//  UIView+MRLog.m
//  TouchMethod
//
//  Created by MccRee on 2017/10/20.
//  Copyright © 2017年 YSTen. All rights reserved.
//

#import "UIView+MRLog.h"

@implementation UIView (MRLog)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%zd",event.allTouches.count);
    UITouch *touch = [touches anyObject];
    //    NSLog(@"%zd",touch.phase);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%zd",event.allTouches.count);
    UITouch *touch = [touches anyObject];
    //    NSLog(@"%zd",touch.phase);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%zd",event.allTouches.count);
    UITouch *touch = [touches anyObject];
    //    NSLog(@"%zd",touch.phase);
    CGPoint locationPoint = [touch preciseLocationInView:touch.view];
    CGPoint preLocationPoint = [touch precisePreviousLocationInView:touch.view];
    //    NSLog(@"(%.1f,%.1f) , (%.1f,%.1f)",locationPoint.x,locationPoint.y,preLocationPoint.x,preLocationPoint.y);
}

@end
