//
//  MRDelegate.m
//  TouchMethod
//
//  Created by MccRee on 2017/10/19.
//  Copyright © 2017年 YSTen. All rights reserved.
//

#import "MRDelegate.h"

@interface MRDelegate()

@property(nonatomic,assign) BOOL isMoved;

@end

@implementation MRDelegate

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.isMoved = NO;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.isMoved = YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    NSLog(@"touchFingerCount:%zd",event.allTouches.count);
    if (!self.isMoved && event.allTouches.count == 1) {
        CGPoint locationPoint = [touch preciseLocationInView:touch.view];
        NSLog(@"touchLocation:(%.1f,%.1f)",locationPoint.x,locationPoint.y);
    }
    self.isMoved = NO;
}

- (void)touchesEstimatedPropertiesUpdated:(NSSet<UITouch *> *)touches{
    
}

@end
