//
//  WBParametersRequestInfo.m
//  MiniWeibo
//
//  Created by pandora on 3/16/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import "WBParametersRequestInfo.h"
#import "WBAuthInfoTool.h"

@implementation WBParametersRequestInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    [super setValue:value forUndefinedKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"access_token"]){
        self.access_token = [[WBAuthInfoTool authInfo] access_token];
    } else {
        [super setValue:value forKey:key];
    }
}

@end
