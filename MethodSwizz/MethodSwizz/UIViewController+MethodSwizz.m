//
//  UIViewController+MethodSwizz.m
//  MethodSwizzDEMO
//
//  Created by MccRee on 2017/8/18.
//  Copyright © 2017年 MccRee. All rights reserved.
//

#import "UIViewController+MethodSwizz.h"
#import <objc/runtime.h>
#import "MRLog.h"
@implementation UIViewController (MethodSwizz)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /**
         原来的方法和实现
         */
        SEL origWill = @selector(viewWillAppear:);
        Method oriWillMethod = class_getInstanceMethod([self class], origWill);
        /**
         交换后的方法和实现
         */
        SEL swizzWillSel = @selector(mr_viewDidAppear:);
        Method swizzWillMethod = class_getInstanceMethod([self class], swizzWillSel);
        method_exchangeImplementations(oriWillMethod, swizzWillMethod);
        
        SEL origDis = @selector(viewWillDisappear:);
        Method oriDisMethod = class_getInstanceMethod([self class], origDis);
        SEL swizzDisSel = @selector(mr_viewDidDisappear:);
        Method swizzDisMethod = class_getInstanceMethod([self class], swizzDisSel);
        method_exchangeImplementations(oriDisMethod, swizzDisMethod);
        
        
    });
}

//runTime添加属性
static const void *exposureTimeKey = &exposureTimeKey;
static const void *leaveTimeKey = &leaveTimeKey;
static const void *durationKey = &durationKey;

@dynamic exposureTime;
@dynamic leaveTime;
@dynamic duration;

- (NSString *)exposureTime {
    return objc_getAssociatedObject(self, exposureTimeKey);
}
- (void)setExposureTime:(NSString *)exposureTime{
    objc_setAssociatedObject(self, exposureTimeKey, exposureTime, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)leaveTime {
    return objc_getAssociatedObject(self, leaveTimeKey);
}
- (void)setLeaveTime:(NSString *)leaveTime{
    objc_setAssociatedObject(self, leaveTimeKey, leaveTime, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)duration {
    return objc_getAssociatedObject(self, durationKey);
}
- (void)setDuration:(NSString *)duration{
    objc_setAssociatedObject(self, durationKey, duration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)mr_viewDidDisappear:(BOOL)animated{
    NSString *className = NSStringFromClass([self class]);
    NSArray *arrBanList = @[@"UINavigationController",  //导航
                            @"UITabBarController",      //TabBar
                            @"DebugInfoVC",             //调试页
                            @"PTERootController",       //PTE调试页
                            @"UICompatibilityInputViewController",  //系统不知名控制器
                            @"YSTabBarViewController",   //Tab
                            @"HomePageViewController",    //主页二级目录
                            @"HotspotViewController",     //有料,因为MainVC中有有料,所以不能用HotspotViewController
                            @"YSTabHTMLViewController",   //H5父控制器
                            @"ProgramViewController",    //电视的节目列表
                            @"TVProgrameListViewController", //电视节目
                            @"TVDetailDateViewController",  //直播的顶部Tab控制器
                            @"PageViewController",          //直播里的子控制器
                            @"SJVideoDetailViewController", //video详情页控制器
                            @"SJLiveTVDetailViewController", //live详情页
                            @"VideoCategoryDetailCollectionViewController", //EPG页的collectionVC
                            @"SJLocalVideoViewController",      //我的相册曝光时的视频列表控制器
                            ];
    if (![arrBanList containsObject:className]) {
        NSInteger end = [[NSDate date] timeIntervalSince1970]*1000;  //毫秒单位
        NSInteger start = [self.exposureTime integerValue];
        NSInteger dur = end - start;
        self.duration = [NSString stringWithFormat:@"%li",(long)dur];
        NSLog(@"页面消失:%@  停留时间:%@ms \n%@",className,self.duration,[MRLog sharedMRLog].visitId);
        
    }
    [self mr_viewDidDisappear:animated];
}

- (void)mr_viewDidAppear:(BOOL)animated{
    /**
     这里不是循环调用
     */
    NSString *className = NSStringFromClass([self class]);
    NSArray *arrBanList = @[@"UINavigationController",  //导航
                            @"UITabBarController",      //TabBar
                            @"DebugInfoVC",             //调试页
                            @"PTERootController",       //PTE调试页
                            @"UICompatibilityInputViewController",  //系统不知名控制器
                            @"YSTabBarViewController",   //Tab
                            @"HomePageViewController",    //主页二级目录
                            @"HotspotViewController",     //有料,因为MainVC中有有料,所以不能用HotspotViewController
                            @"YSTabHTMLViewController",   //H5父控制器
                            @"ProgramViewController",    //电视的节目列表
                            @"TVProgrameListViewController", //电视节目
                            @"TVDetailDateViewController",  //直播的顶部Tab控制器
                            @"PageViewController",          //直播里的子控制器
                            @"SJVideoDetailViewController", //video详情页控制器
                            @"SJLiveTVDetailViewController", //live详情页
                            @"VideoCategoryDetailCollectionViewController", //EPG页的collectionVC
                            @"SJLocalVideoViewController",      //我的相册曝光时的视频列表控制器
                            ];
    if (![arrBanList containsObject:className]) {
        NSInteger start = [[NSDate date] timeIntervalSince1970]*1000; //毫秒单位
        self.exposureTime = [NSString stringWithFormat:@"%li",(long)start];
        NSLog(@"页面曝光:%@\n%@",className,[MRLog sharedMRLog].visitId);
        
    }
    [self mr_viewDidAppear:animated];
}



@end
