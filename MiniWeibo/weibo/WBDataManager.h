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

- (void)saveWeiboWith:(NSDictionary *)weibo;
-(NSArray *)getAllWeibo;;
- (void)eraseTable:(NSString *)tableName;
- (void)clearWeiboCache;

@end
