//
//  DanmuModel.h
//  ShiJiaLH
//
//  Created by MccRee on 2018/1/8.
//  Copyright © 2018年 YSTen. All rights reserved.
//

#import <HJDanmaku/HJDanmaku.h>

@interface DanmuModel : HJDanmakuModel

/**
 是否是自己发的弹幕
 */
@property (nonatomic, assign) BOOL selfFlag;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor  *textColor;
@property (nonatomic, strong) UIFont   *textFont;

@end
