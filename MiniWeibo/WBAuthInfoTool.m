//
//  WBAuthInfoTool.m
//  MiniWeibo
//
//  Created by pandora on 3/15/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import "WBAuthInfoTool.h"
#import "WBAuthInfo.h"

#define WBInfoPath [[[[NSFileManager defaultManager]containerURLForSecurityApplicationGroupIdentifier:MiniWeiboGroupID]URLByAppendingPathComponent:@"authInfo.data"]path]

@implementation WBAuthInfoTool

+(BOOL)saveInfoWith:(WBAuthInfo *)authInfo
{
    authInfo.expires_time = [[NSDate date]dateByAddingTimeInterval:[authInfo.expires_in doubleValue]];
    return [NSKeyedArchiver archiveRootObject:authInfo toFile:WBInfoPath];
}

+(WBAuthInfo *)authInfo
{
    WBAuthInfo *authInfo =  [NSKeyedUnarchiver unarchiveObjectWithFile:WBInfoPath];
    if (authInfo == nil) {
        return nil;
    }
    if ([[NSDate date] compare:authInfo.expires_time] == NSOrderedDescending) {
        return nil;
    }
    return authInfo;
}

@end
