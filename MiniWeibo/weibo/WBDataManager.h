//
//  WBDataManager.h
//  MiniWeibo
//
//  Created by pandora on 3/17/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBCellModel.h"
#import "WBParametersRequestInfo.h"

@interface WBDataManager : NSObject

+ (WBDataManager *)sharedInstance;
+ (void)purgeSharedInstance;

- (BOOL)saveWeiboWith:(WBCellModel *)weibo;
- (NSArray *)weiboWithParameters:(WBParametersRequestInfo *)parameters;

@end
