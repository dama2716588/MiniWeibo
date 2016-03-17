//
//  AppDelegate.m
//  MiniWeibo
//
//  Created by pandora on 3/14/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import "AppDelegate.h"
#import "WBParametersRequestInfo.h"

@interface AppDelegate ()

@property(nonatomic,assign) UIBackgroundTaskIdentifier backgroundTask;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    _index = [[IndexViewController alloc] init];
    _nav = [[UINavigationController alloc] initWithRootViewController:_index];
    self.window.rootViewController = _nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply
{
    NSLog(@"handleWatchKitExtensionRequest : %@",userInfo);
    [self beginBackgroundTask];
    [self requestDataWith:userInfo reply:reply];
    //结束后台任务
    [self endBackgroundTask];
}

-(void)requestDataWith:(NSDictionary*)userInfo reply:(void (^)(NSDictionary *))reply
{
    WBParametersRequestInfo *parameters = [[WBParametersRequestInfo alloc] initWithDictionary:userInfo];
    //TODO: get weibo data
}

-(void)beginBackgroundTask
{
    self.backgroundTask = [[UIApplication sharedApplication]beginBackgroundTaskWithName:@"backgroundTask" expirationHandler:^{
        [self endBackgroundTask];
    }];
}

-(void)endBackgroundTask
{
    [[UIApplication sharedApplication]endBackgroundTask:self.backgroundTask];
    self.backgroundTask = UIBackgroundTaskInvalid;
}

@end
