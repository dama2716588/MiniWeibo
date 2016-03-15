//
//  WBAuthInfo.h
//  MiniWeibo
//
//  Created by pandora on 3/15/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import "BaseModel.h"

@interface WBAuthInfo : BaseModel

@property(nonatomic,copy)NSString *access_token;
@property(nonatomic,copy)NSString *expires_in;
@property(nonatomic,copy)NSString *remind_in;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSDate *expires_time;

@end
