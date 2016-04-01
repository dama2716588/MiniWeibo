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

- (void)saveWeiboWith:(NSDictionary *)weibo
{
    [self insertObject:[weibo mj_JSONString] intoTable:@"friends_timeline"];
}

-(NSArray *)getAllWeibo;
{
    return [self selectAllRecords:@"friends_timeline"];
}

-(NSArray *)selectAllRecords:(NSString *)tableName
{
    __block NSMutableArray *searchArray = [[NSMutableArray alloc]init];
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:[NSString stringWithFormat:@"select *from %@ ",tableName]];
        while ([resultSet next])
        {
            NSString   *JSONString= [resultSet stringForColumn:@"JSONString"];
            NSDictionary *jsondict =[JSONString objectFromJSONString];
            [searchArray addObject:jsondict];
        }
    }];
    return searchArray;
}

-(NSArray *)selectAllRecordsToModel:(Class)className  fromTable:(NSString *)tableName
{
    __block NSMutableArray *searchArray = [[NSMutableArray alloc]init];
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:[NSString stringWithFormat:@"select *from %@  order by ID ASC",tableName]];
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

- (void)insertObject:(NSString*)jsonStr intoTable:(NSString *)tableName
{
    // TODO: need to fix
    // crach: jk_encode_add_atom_to_buffer https://github.com/johnezang/JSONKit/pull/89
    //NSString *jsonStr=[dict mj_JSONString];
    
//    NSError* error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
//    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
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

- (void)clearWeiboCache
{
    [self eraseTable:@"friends_timeline"];
}

- (void)eraseTable:(NSString *)tableName
{
    // not exist
    if ([self tableExists:tableName] == NO) {
        return;
    }
    
    NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
    [self executeUpdateWithSQL:sqlstr fromTable:tableName];
}

-(void)executeUpdateWithSQL:(NSString *)sql fromTable:(NSString *)tableName
{
     [_queue inDatabase:^(FMDatabase *db) {
        if(![db executeUpdate:sql]){
            NSLog(@"ERROR,Failed To executeUpdate Table %@",tableName);
        }
    }];
}

@end
