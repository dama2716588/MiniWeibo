//
//  WBDataManager.m
//  MiniWeibo
//
//  Created by pandora on 3/17/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import "WBDataManager.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "MJExtension.h"
#import "JSONKit.h"

static WBDataManager *s_instance = nil;

static NSString *const CREATE_TABLE_SQL =
@"CREATE TABLE IF NOT EXISTS %@ ( \
ID INTEGER, \
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
        
        NSString *dataBasePath = [[[[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:MiniWeiboGroupID] URLByAppendingPathComponent:@"miniweibo.db"] path];
        NSLog(@"dataBasePath___ : %@",dataBasePath);
        _queue = [FMDatabaseQueue databaseQueueWithPath:dataBasePath];
    }
    return self;
}

- (void)saveWeiboWith:(WBCellModel *)weibo
{
    [self insertObject:[weibo dic] intoTable:@"friends_timeline"];
}

-(NSArray *)getAllWeibo;
{
    return [self selectAllRecordsToModel:[WBCellModel class] fromTable:@"friends_timeline"];
}

-(NSArray *)selectAllRecordsToModel:(Class)className  fromTable:(NSString *)tableName
{
    __block NSMutableArray *searchArray = [[NSMutableArray alloc]init];
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:[NSString stringWithFormat:@"select *from %@  order by ID DESC",tableName]];
        while ([resultSet next])
        {
            NSString   *JSONString= [resultSet stringForColumn:@"JSONString"];
            NSDictionary *jsondict =[JSONString objectFromJSONString];
            id obj = [className mj_objectWithKeyValues:jsondict];
            [searchArray addObject:obj];
        }
    }];
    return searchArray;
}

- (BOOL)tableExists:(NSString *)tableName
{
    __block   NSInteger result = NO;
    [_queue inDatabase:^(FMDatabase *db) {
        result = [db tableExists:tableName];
    }];
    
    return result;
}

- (void)createTableWithName:(NSString *)tableName
{
    NSAssert(tableName != nil, @"tableName not nil");
    
    if([self tableExists:tableName]) return;
    
    NSString * sql = [NSString stringWithFormat:CREATE_TABLE_SQL, tableName];
    [_queue inDatabase:^(FMDatabase *db) {
        if(![db executeUpdate:sql]) {
            NSLog(@"ERROR, Failed To Create Table: %@", tableName);
        }else {
            NSLog(@"Sucess To Create Table: %@", tableName);
        }
    }];
}

- (void)insertObject:(NSDictionary*)dict intoTable:(NSString *)tableName
{
    NSString *jsonStr=[dict mj_JSONString];
    
    [self createTableWithName:tableName];
    
    if (jsonStr == nil) {
        NSLog(@"mj_JSONString is nil, insertObject failed!");
        return;
    }
    
    NSString  *insertSQl=[NSString stringWithFormat:@"insert or replace into '%@' (JSONString) values (?) ",tableName];
    
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if(![db executeUpdate:insertSQl,jsonStr]){
            NSLog(@"rollback Table : %@",tableName);
            *rollback = YES;
            return ;
        }
    }];
}

@end
