//
//  WBAuthInfoTool.h
//  MiniWeibo
//
//  Created by pandora on 3/15/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBAuthInfo.h"

@interface WBAuthInfoTool : NSObject

+(BOOL)saveInfoWith:(WBAuthInfo *)authInfo;
+(WBAuthInfo *)authInfo;

@end
