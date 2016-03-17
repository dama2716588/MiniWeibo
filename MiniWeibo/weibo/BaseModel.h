//
//  BaseModel.h
//  MiniWeibo
//
//  Created by pandora on 3/15/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject <NSCoding, NSCopying, NSMutableCopying>
{
    NSArray *_keys;
}

- (id)initWithDictionary:(NSDictionary *)dic;
- (NSDictionary *)dic;

@end
