//
//  WBDataManager.m
//  MiniWeibo
//
//  Created by pandora on 3/17/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import "WBDataManager.h"
#import "FMDatabaseQueue.h"

static WBDataManager *s_instance = nil;

static NSString *const CREATE_TABLE_SQL =
@"CREATE TABLE IF NOT EXISTS %@ ( \
ID TEXT NOT NULL, \
JSONString TEXT NOT NULL, \
PRIMARY KEY(ID)) \
";

@interface WBDataManager()
{
    FMDatabaseQueue *_queue;
}

@end

@implementation WBDataManager

+(void)purgeSharedInstance
{
    @synchronized(s_instance) {
        s_instance = nil;
    }
}

+ (WBDataManager *)sharedInstance
{
    @synchronized(s_instance) {
        if (!s_instance) {
            s_instance = [[WBDataManager alloc] init];
        }
    }
    return s_instance;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *dataBasePath= [documentPath stringByAppendingPathComponent:@"com.baidu.mimic.db"];
        _queue = [FMDatabaseQueue databaseQueueWithPath:dataBasePath];
    }
    return self;
}

- (BOOL)saveWeiboWith:(WBCellModel *)weibo
{
    return YES;
}

- (NSArray *)weiboWithParameters:(WBParametersRequestInfo *)parameters
{
    return nil;
}

@end
