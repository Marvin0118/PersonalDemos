//
//  AppDelegate.m
//  MethodSwizz
//
//  Created by MccRee on 2017/9/13.
//  Copyright © 2017年 MccRee. All rights reserved.
//

#import "AppDelegate.h"
#import "MRLog.h"
@interface AppDelegate ()
@property (nonatomic, assign) BOOL firstLaunch;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[MRLog sharedMRLog] createNewVisitId];
    
    NSLog(@"1、非运行状态 → 前台非活动状态\n执行方法：application:DidFinishLaunchingWithOptions:\n%@",[MRLog sharedMRLog].visitId);
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"3、前台活动状态 → 前台非活动状态\n执行方法：application:WillResignActive\n%@",[MRLog sharedMRLog].visitId);

    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"4、后台状态 → 挂起状态\n执行方法：application:DidEnterBackground\n%@",[MRLog sharedMRLog].visitId);


}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    if (self.firstLaunch) {
//        self.firstLaunch = NO;
//    }else{
//        [[MRLog sharedMRLog] createNewVisitId];
//    }
    [[MRLog sharedMRLog] createNewVisitId];
    NSLog(@"7、后台状态 → 前台非活跃状态\n执行方法：application:WillEnterForeground\n%@",[MRLog sharedMRLog].visitId);

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    NSLog(@"2、前台非活动状态 → 前台活动状态\n执行方法：application:DidBecomeActive\n%@",[MRLog sharedMRLog].visitId);
}


- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"5、挂起状态 → 非运行状态\n执行方法：application:WillTerminate\n%@",[MRLog sharedMRLog].visitId);

    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
