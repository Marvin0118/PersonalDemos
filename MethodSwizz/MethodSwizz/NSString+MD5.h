//
//  NSString+MD5.h
//  MethodSwizz
//
//  Created by MccRee on 2017/9/15.
//  Copyright © 2017年 MccRee. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSString (MD5)
/**
 *  md5加密的字符串

 */
+ (NSString *)MD5String:(NSString *)str;

@end
