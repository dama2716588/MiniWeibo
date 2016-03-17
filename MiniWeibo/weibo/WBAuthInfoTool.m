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
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:MiniWeiboGroupID];
    [shared setObject:[authInfo dic] forKey:@"wb_auth_info"];
    return [shared synchronize];
}

+(WBAuthInfo *)authInfo
{
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:MiniWeiboGroupID];
    NSDictionary *dic = [shared objectForKey:@"wb_auth_info"];
    WBAuthInfo *authInfo = [[WBAuthInfo alloc] initWithDictionary:dic];
    return authInfo;
}

@end
