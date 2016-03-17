//
//  WBCellModel.m
//  MiniWeibo
//
//  Created by pandora on 3/17/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import "WBCellModel.h"

@implementation WBCellModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    [super setValue:value forUndefinedKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"reply_comment"]){
        self.user = [[WBUserModel alloc] initWithDictionary:value];
    } else {
        [super setValue:value forKey:key];
    }
}

@end
