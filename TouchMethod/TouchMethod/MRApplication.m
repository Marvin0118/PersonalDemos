//
//  MRApplication.m
//  ShiJia_JiangSu
//
//  Created by MccRee on 2017/10/20.
//  Copyright © 2017年 Ysten.com. All rights reserved.
//

#import "MRApplication.h"
#include <CommonCrypto/CommonCrypto.h>

@interface MRApplication()

@property(nonatomic,assign) BOOL isMoved;

@end

@implementation MRApplication

- (void)sendEvent:(UIEvent *)event{
    if (event.type==UIEventTypeTouches) {
        UITouch *touch = [event.allTouches anyObject];
        
        if (touch.phase == UITouchPhaseBegan) {
            self.isMoved = NO;
        }
        
        if (touch.phase == UITouchPhaseMoved) {
            self.isMoved = YES;
        }
        
        if (touch.phase == UITouchPhaseEnded) {
            if (!self.isMoved && event.allTouches.count == 1) {
                UITouch *touch = [event.allTouches anyObject];
                CGPoint locationPointWindow = [touch preciseLocationInView:touch.window];
                NSInteger dateTime = [[NSDate date] timeIntervalSince1970]*1000;
                NSString *touchEventID = [self md5String: [NSString stringWithFormat:@"touchid%zd",dateTime]];
                NSLog(@"TouchLocationWindow:(%.1f,%.1f),touchId:%@",locationPointWindow.x,locationPointWindow.y,touchEventID);
            }
            self.isMoved = NO;
        }
    }
    [super sendEvent:event];
}

- (NSString *)md5String:(NSString *)str {
    NSData *strData = [str dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(strData.bytes, (CC_LONG)strData.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
